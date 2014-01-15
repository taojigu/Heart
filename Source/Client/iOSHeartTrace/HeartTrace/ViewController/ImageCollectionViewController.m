//
//  ImageCollectionViewController.m
//  HeartTrace
//
//  Created by user on 14-1-13.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImageNameConst.h"

#define MaxImageAmount 9

#define  ImageCellIdentifer @"ImageCellIdentifer"


@interface ImageCollectionViewController ()



@end

@implementation ImageCollectionViewController

@synthesize imageArray;
@synthesize addCellImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.imageArray=[NSMutableArray arrayWithObjects:nil];
        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib*cellNib=[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:ImageCellIdentifer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.imageArray release];
    [self.addCellImage release];
    [super dealloc];
}

#pragma -- mark datasource and delegate messsage

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (([self.imageArray count]==indexPath.row)&&(MaxImageAmount!=[self.imageArray count])){
        NSLog(@"Present Image Add ViewController");
    }
    else{
        NSLog(@"Present Image Browse ViewController");
        
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageArray count]+1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:ImageCellIdentifer forIndexPath:indexPath];
    NSAssert(nil!=cell, @"Nil Cell is not expected");
    UIImageView*imageView=(UIImageView*)[cell viewWithTag:101];
    
    if (([self.imageArray count]==indexPath.row)&&(MaxImageAmount!=[self.imageArray count])) {
        imageView.image=self.addCellImage;
        imageView.alpha=0.5;
    }
    else{
        UIImage*img=[self.imageArray objectAtIndex:indexPath.row];
        imageView.image=img;
        
    }
    
    return  cell;
}



@end
