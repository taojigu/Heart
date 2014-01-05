//
//  WishWallTableViewController.m
//  HeartTrace
//
//  Created by user on 13-12-23.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "WishWallTableViewController.h"
#import "ASIHTTPRequest.h"
#import "RequestURLUtility.h"
#import "ElementsContainer.h"
#import "Wish.h"
#import "WishPageParser.h"
#import "WishTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Product.h"
#import "Organization.h"



@interface WishWallTableViewController (){
    @private
    IBOutlet UIView*loadingView;
    
}

@property(nonatomic,retain)ElementsContainer*wishPage;


-(void)presentLoadingView;
-(void)startRequestWishPage:(NSInteger)pageIndex;
@end

@implementation WishWallTableViewController

@synthesize wishPage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"WishWallTitle", nil);
        wishPage=[[ElementsContainer alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self presentLoadingView];

    [self startRequestWishPage:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.wishPage release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.wishPage.elementArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WishTableViewCell *cell = (WishTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[WishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Wish*wish=[self.wishPage.elementArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.imageViewProfile setImageWithURL:[NSURL URLWithString:wish.imageUrl] placeholderImage:nil];
    [cell.btnUser setTitle:wish.user.nickName forState:UIControlStateNormal];
    cell.labelWishText.text=wish.text;
    cell.labelTime.text=wish.time;
    
    cell.wish=wish;
    // Configure the cell...
    
    return cell;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Wish*ws=[self.wishPage.elementArray objectAtIndex:indexPath.row];
    return [WishTableViewCell heightForCell:ws];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
      *detailViewController = [[ alloc] initWithNibName:@";" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
#pragma mark -- AsiHttpRequestDelegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    [loadingView removeFromSuperview];
    WishPageParser*parser=[[WishPageParser alloc]init];
    ElementsContainer*result=[parser parse:[request responseData]];
    [parser release];
    [self.wishPage.elementArray addObjectsFromArray:result.elementArray];
    [self.tableView reloadData];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [loadingView removeFromSuperview];
}
-(void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"Request started");
    
}

#pragma mark -- private messages
-(void)presentLoadingView{
    loadingView.frame=self.view.bounds;
    [self.view addSubview:loadingView];
}
-(void)startRequestWishPage:(NSInteger)pageIndex{
    NSString*wishUrlString=[RequestURLUtility wishRequestURLString:0 pageSize:2];
    ASIHTTPRequest*requst=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:wishUrlString]];
    requst.delegate=self;
    [requst startAsynchronous];
    
    
}
@end
