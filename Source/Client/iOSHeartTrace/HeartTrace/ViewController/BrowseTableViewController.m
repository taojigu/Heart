//
//  BrowseTableViewController.m
//  HeartTrace
//
//  Created by user on 14-1-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "BrowseTableViewController.h"
#import "ASIHTTPRequest.h"
#import "ModelHeader.h"
#import "RequestURLUtility.h"
#import "ASIHTTPRequest+RequestIdentify.h"
#import "ProductPageParser.h"
#import "OrganizationPageParser.h"


#define ProductIndex 0
#define OrganizationIndex 1

#define SearchRequestTag 0
#define ProductRequestTag 1
#define OrganizationRequestTag 2


@interface BrowseTableViewController ()<ASIHTTPRequestDelegate,UISearchBarDelegate>{
    @private
    IBOutlet UISearchBar*searchBar;
    UISegmentedControl*segmentControl;    
}

//@property(nonatomic,retain)NSMutableArray*productArray;
//@property(nonatomic,retain)NSMutableArray*organizationArray;
@property(nonatomic,retain)ElementsContainer*productContainer;
@property(nonatomic,retain)ElementsContainer*organizationContainer;

-(void)initSegmentControl;
-(void)initSearchBar;

@end

@implementation BrowseTableViewController

@synthesize delegate;
@synthesize scope;

//@synthesize productArray;
//@synthesize organizationArray;

@synthesize productContainer;
@synthesize organizationContainer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.scope=BrowseScopeAll;
        ElementsContainer*tmpContainer=[[ElementsContainer alloc]init];
        self.productContainer=tmpContainer;
        [tmpContainer release];
        
        tmpContainer=[[ElementsContainer alloc]init];
        self.organizationContainer=tmpContainer;
        [tmpContainer release];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubviews];
    
     
    [self startDownloadProduct:0];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    [segmentControl release];
    [self.organizationContainer release];
    [self.productContainer release];
    [super dealloc];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (ProductIndex==segmentControl.selectedSegmentIndex) {
        return [self.productContainer.elementArray count];
    }
    if (OrganizationIndex==segmentControl.selectedSegmentIndex) {
        return [self.organizationContainer.elementArray count];
    }
    NSAssert(NO, @"Invalidate SegmentControl Index");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ProductIndex==segmentControl.selectedSegmentIndex) {
        return [self productTableViewCell:tableView indexPath:indexPath];
    }
    if (OrganizationIndex==segmentControl.selectedSegmentIndex) {
        return [self organizationTableViewCell:tableView indexPath:indexPath];
    }
    NSAssert(NO, @"Invalidate TabelView Cell");
    
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


#pragma -- AsiHttpRequestDelegate message
-(void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"Start download Product or Organization");
   
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Request %@ failed",request.requestName);
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    ElementsContainer*resultPage=nil;
    ElementsContainer*bufferContainer=nil;
    if (ProductRequestTag==request.tag) {
        //Parse the Product Data
        ProductPageParser*prtParser=[[ProductPageParser alloc]init];
        resultPage=[prtParser parse:request.responseData];
        [prtParser release];
        bufferContainer=self.productContainer;
        
    }
    if (OrganizationRequestTag==request.tag) {
        //Parse the Organization Data
        OrganizationPageParser*orgParser=[[OrganizationPageParser alloc]init];
        resultPage=[orgParser parse:request.responseData];
        [orgParser release];
        bufferContainer=self.organizationContainer;
    }
    if (nil==resultPage) {
        return;
    }
    [bufferContainer.elementArray addObjectsFromArray:resultPage.elementArray];
    bufferContainer.count=[bufferContainer.elementArray count];
    bufferContainer.pageIndex=resultPage.pageIndex;
    
    [self.tableView reloadData];
    
    return;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)srchBar{

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)srchBar{
    [searchBar resignFirstResponder];
}

#pragma mark -- selector messages

-(void)segmentIndexChanged:(UISegmentedControl*)segmentCtrl{
    ElementsContainer*ec=nil;
    if (ProductIndex==segmentControl.selectedSegmentIndex) {
        ec=self.productContainer;
    }
    if (OrganizationIndex==segmentControl.selectedSegmentIndex) {
        ec=self.organizationContainer;
    }
    NSAssert(nil!=ec, @"Invalidate ElementContainer");

    if ([ec.elementArray count]==0) {
        [self startDownload:0];
    }
    [self.tableView reloadData];
}
#pragma mark -- private messages

-(void)startDownloadOrganization:(NSInteger)pageIndex{

    NSString*requestString=[RequestURLUtility organizationRequestURLString:pageIndex pageSize:12];
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestString]];
    request.tag=OrganizationRequestTag;
    request.delegate=self;
    [request startAsynchronous];
}
-(void)startDownloadProduct:(NSInteger)pageIndex{
    NSString*requesString=[RequestURLUtility productRequestURLString:pageIndex pageSize:12];
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:requesString]];
    request.tag=ProductRequestTag;
    request.delegate=self;
    [request startAsynchronous];
}

-(void)startDownload:(NSInteger)pageIndex{
    if (ProductIndex==segmentControl.selectedSegmentIndex) {
        [self startDownloadProduct:pageIndex];
        return;
    }
    if (OrganizationIndex==segmentControl.selectedSegmentIndex) {
        [self startDownloadOrganization:pageIndex];
        return;
    }
    
}
-(void)initSubviews{
    [self initSegmentControl];
    [self initSearchBar];
    
}

-(void)initSegmentControl{
    NSArray*itemArray=nil;
    switch (self.scope) {   
        case BrowseScopeProduct:
            itemArray=[NSArray arrayWithObjects:NSLocalizedString(@"Product", nil), nil];
            break;
        case BrowseScopeOrganization:
            itemArray=[NSArray arrayWithObjects:NSLocalizedString(@"Organization", nil), nil];
            break;
        case BrowseScopeAll:
            itemArray=[NSArray arrayWithObjects:NSLocalizedString(@"Product", nil),NSLocalizedString(@"Organization", nil), nil];
            break;
        default:
            NSAssert(NO, @"Invalidate Browse Scope");
            break;
    }
    segmentControl=[[UISegmentedControl alloc]initWithItems:itemArray];
    segmentControl.momentary=NO;
    segmentControl.selectedSegmentIndex=0;
    segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    segmentControl.frame=CGRectInset(segmentControl.frame, 5, 5);
    [segmentControl addTarget:self action:@selector(segmentIndexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=segmentControl;
    
    
}
-(void)initSearchBar{
    
    self.tableView.tableHeaderView=searchBar;
    
}

-(UITableViewCell*)productTableViewCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Product*prt=[self.productContainer.elementArray objectAtIndex:indexPath.row];
    cell.textLabel.text=prt.name;
    
    // Configure the cell...
    
    return cell;
}
-(UITableViewCell*)organizationTableViewCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier = @"OrganizationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Organization*org=[self.organizationContainer.elementArray objectAtIndex:indexPath.row];
    cell.textLabel.text=org.name;
    
    // Configure the cell...
    
    return cell;
}


@end
