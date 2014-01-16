//
//  ImageCollectionViewController.m
//  HeartTrace
//
//  Created by user on 14-1-13.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageCollectionViewController.h"

#import "QBImagePickerController.h"

#define MaxImageAmount 9

#define  ImageCellIdentifer @"ImageCellIdentifer"


@interface ImageCollectionViewController ()



@end

@implementation ImageCollectionViewController

@synthesize imageArray;
@synthesize addCellImage;
@synthesize mainViewController;

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithCollectionViewLayout:layout];
    if (self) {
        NSMutableArray*tmpArray=[[NSMutableArray alloc]init];
        self.imageArray=tmpArray;
        [tmpArray release];
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
    [self.mainViewController release];
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
        QBImagePickerController*qpvc=[[QBImagePickerController alloc]init];
        qpvc.delegate=self;
        qpvc.allowsMultipleSelection=YES;
        qpvc.limitsMaximumNumberOfSelection=YES;
        qpvc.maximumNumberOfSelection=MaxImageAmount-[self.imageArray count];
        [self.mainViewController.navigationController pushViewController:qpvc animated:YES];
        [qpvc release];
    }
    else{
        NSLog(@"Present Image Browse ViewController");
        
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return MIN(MaxImageAmount, [self.imageArray count]+1);
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

#pragma mark -- QBImagePickerControllerDelegate messages

-(void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info{
    
    NSArray*dictArray=(NSArray*)info;
    for (NSDictionary*dict in dictArray) {
        UIImage*image=[dict valueForKey:MediaInfoKeyOrigianlImage];
        [self.imageArray addObject:image];
    }

   
    [imagePickerController.navigationController popToViewController:self.mainViewController animated:YES];
    [self.collectionView reloadData];
}



@end
