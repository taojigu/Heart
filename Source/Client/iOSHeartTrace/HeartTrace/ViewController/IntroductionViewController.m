//
//  IntroductionViewController.m
//  HeartTrace
//
//  Created by user on 13-12-23.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "IntroductionViewController.h"

@interface IntroductionViewController ()

@property(nonatomic,retain)NSArray*imageArray;

-(IBAction)finishIntroduction:(id)sender;

@end

@implementation IntroductionViewController

@synthesize imageArray;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [self.imageArray release];
    [super dealloc];
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
-(IBAction)finishIntroduction:(id)sender{
    if (nil!=self.delegate&&[self.delegate respondsToSelector:@selector(introductionDidFinish:)]) {
        [self.delegate introductionDidFinish:self];
    }
}

@end
