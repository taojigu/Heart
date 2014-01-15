//
//  AddWishViewController.m
//  HeartTrace
//
//  Created by user on 14-1-8.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "AddWishViewController.h"
#import "BrowseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageCollectionViewController.h"
#import "ImageNameConst.h"


#define HorizontalMargin 10
#define ViewDistance 10
#define SegmentControlHeight 30
#define TextViewWishHeight 100
#define CellProductHeight 44
#define CollectionVeiwImageHeight 200

#define CollectionViewImageMargin 5
#define CollectionViewCellLength 60




@interface AddWishViewController (){
    @private
    IBOutlet UIScrollView*scrollView;
    IBOutlet UITableViewCell*cellSelectProduct;
    IBOutlet UITextView*wishTextView;
    //IBOutlet UICollectionView*collectionViewImage;
    IBOutlet UISegmentedControl*segmentControl;
    ImageCollectionViewController*imageCollecitonViewController;
    
    CGFloat subViewWidth;
    

}

@property(nonatomic,retain)NSMutableArray*imageArray;





-(void)configureDefaults;
-(void)refreshLayout;
@end

@implementation AddWishViewController

@synthesize imageArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
        NSMutableArray*tmpArray=[[NSMutableArray alloc]init];
        self.imageArray=tmpArray;
        [tmpArray release];
        
        UIBarButtonItem*barButtonSubmit=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"SubmitText", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(submitButtonClicked:)];
        self.navigationItem.rightBarButtonItem=barButtonSubmit;
        [barButtonSubmit release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureDefaults];
    [self refreshLayout];
     [self resetTextViewPlaceHolder:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.imageArray release];
    [super dealloc];
}

#pragma mark -- delelgate messages

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [wishTextView resignFirstResponder];
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"Begin Edit");
    if ([UIColor grayColor]==textView.textColor) {
         
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (0==[textView.text length]) {
        [self resetTextViewPlaceHolder:YES];
    }else{
        //[self resetTextViewPlaceHolder:NO];
    }
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if ([UIColor grayColor]==textView.textColor) {
        textView.text=text;
        [self resetTextViewPlaceHolder:NO];
    }
    
    return YES;
}


#pragma mark -- private messages

-(void)configureDefaults{
    [scrollView addSubview:segmentControl];
    [scrollView addSubview:wishTextView];
    //[scrollView addSubview:collectionViewImage];
    [scrollView addSubview:cellSelectProduct];
    segmentControl.selectedSegmentIndex=0;
    cellSelectProduct.layer.cornerRadius=8;
    cellSelectProduct.layer.borderColor=[UIColor blackColor].CGColor;
    cellSelectProduct.layer.borderWidth=2;
    cellSelectProduct.selectionStyle=UITableViewCellSelectionStyleBlue;
    UITapGestureRecognizer*recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellProductTapped:)];
    [cellSelectProduct addGestureRecognizer:recognizer];
    [recognizer release];
    
    subViewWidth=CGRectGetWidth(self.view.frame)-HorizontalMargin*2;
    //collectionViewImage.hidden=YES;
    UICollectionViewFlowLayout*imageLayout=[[UICollectionViewFlowLayout alloc]init];
    imageLayout.itemSize=CGSizeMake(CollectionViewCellLength,CollectionViewCellLength);
    imageLayout.minimumInteritemSpacing=CollectionViewImageMargin;
    imageLayout.minimumLineSpacing=CollectionViewImageMargin;
    imageLayout.sectionInset=UIEdgeInsetsMake(CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin);
    imageCollecitonViewController=[[ImageCollectionViewController alloc]initWithCollectionViewLayout:imageLayout];
    imageCollecitonViewController.addCellImage=[UIImage imageNamed:ProfileHeaderJpeg];
    [imageLayout release];
    [scrollView addSubview:imageCollecitonViewController.view];

}
-(void)refreshLayout{
    [self layoutSegmentControl];
    [self layoutWishTextView];
    [self layoutImageCollectionView];
    [self layoutProductCell];
    
    CGFloat scrollHeight=MAX(CGRectGetHeight(self.view.frame), CGRectGetMaxY(cellSelectProduct.frame)+ViewDistance);
    scrollView.contentSize=CGSizeMake(CGRectGetWidth(self.view.frame), scrollHeight);
    
}
-(void)layoutSegmentControl{
    CGRect rect=CGRectMake(HorizontalMargin, ViewDistance, subViewWidth, SegmentControlHeight);
    segmentControl.frame=rect;
    
}
-(void)layoutWishTextView{
    CGRect rect=CGRectMake(HorizontalMargin, CGRectGetMaxY(segmentControl.frame)+ViewDistance, subViewWidth, TextViewWishHeight);
    wishTextView.frame=rect;
}
-(void)layoutImageCollectionView{
    CGRect rect=CGRectMake(HorizontalMargin, CGRectGetMaxY(wishTextView.frame)+ViewDistance,subViewWidth,CollectionVeiwImageHeight);
    //collectionViewImage.frame=rect;
    imageCollecitonViewController.view.frame=rect;
}
-(void)layoutProductCell{
    CGRect rect=CGRectMake(HorizontalMargin, CGRectGetMaxY(imageCollecitonViewController.view.frame)+ViewDistance,subViewWidth, CellProductHeight);
    cellSelectProduct.frame=rect;
}
-(void)resetTextViewPlaceHolder:(BOOL)placeHolderPattern{
    if (placeHolderPattern) {
        wishTextView.textColor=[UIColor grayColor];
        wishTextView.text=NSLocalizedString(@"DefaultWishText", nil);
        wishTextView.selectedRange=NSMakeRange(0, 0);

    }else{
        wishTextView.textColor=[UIColor blackColor];
    }
   
}
#pragma mark -- selector messages

-(void)cellProductTapped:(UITapGestureRecognizer*)recognizer{
    cellSelectProduct.selected=YES;
    BrowseViewController*brvc=[[BrowseViewController alloc]init];
    [self.navigationController pushViewController:brvc animated:YES];
    [brvc release];
    cellSelectProduct.selected=NO;
}

-(void)submitButtonClicked:(id)sender{
     
}

@end
