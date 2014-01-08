//
//  ProductDetailViewController.m
//  HeartTrace
//
//  Created by user on 14-1-8.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController (){
    @private
    IBOutlet UILabel*labelProudctName;
    IBOutlet UIImageView*imageViewProduct;
    IBOutlet UIButton*btnOrgnize;
}

-(IBAction)buttonProudctClicked:(id)sender;
    

@end

@implementation ProductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action messages
-(IBAction)buttonProudctClicked:(id)sender{
    
}

@end
