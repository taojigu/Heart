//
//  AddWishViewController.m
//  HeartTrace
//
//  Created by user on 14-1-8.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "AddWishViewController.h"

@interface AddWishViewController (){
    @private
    IBOutlet UIScrollView*scrollView;
    IBOutlet UITableViewCell*cellSelectProduct;
    IBOutlet UITextView*wishTextView;
    IBOutlet UICollectionView*collectionViewImage;
    IBOutlet UISegmentedControl*segmentControl;

}


-(void)configureDefaults;
-(void)refeshLayout;
@end

@implementation AddWishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self configureDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self refreshLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private messages

-(void)configureDefaults{
    [scrollView addSubview:segmentControl];
    [scrollView addSubview:wishTextView];
    [scrollView addSubview:collectionViewImage];
    [scrollView addSubview:cellSelectProduct];
    segmentControl.selectedSegmentIndex=0;

}
-(void)refreshLayout{
    [self layoutSegmentControl];
    [self layoutWishTextView];
    [self layoutImageCollectionView];
    [self layoutProductCell];
    
}
-(void)layoutSegmentControl{
    
}
-(void)layoutWishTextView{
    
}
-(void)layoutImageCollectionView{
    
}
-(void)layoutProductCell{
    
}

@end
