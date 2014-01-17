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
//#import "ImageCollectionViewController.h"
#import "ImageNameConst.h"
#import "QBImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>

#define MaxImageAmount 9

#define ImageFromAlbumIndex 1
#define ImageFromCameraIndex 2

#define  ImageCellIdentifer @"ImageCellIdentifer"



#define HorizontalMargin 10
#define ViewDistance 10
#define SegmentControlHeight 30
#define TextViewWishHeight 100
#define CellProductHeight 44
#define CollectionVeiwImageHeight 200

#define CollectionViewImageMargin 5
#define CollectionViewCellLength 60




@interface AddWishViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,QBImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    @private
    IBOutlet UIScrollView*scrollView;
    IBOutlet UITableViewCell*cellSelectProduct;
    IBOutlet UITextView*wishTextView;
    //IBOutlet UICollectionView*collectionViewImage;
    IBOutlet UISegmentedControl*segmentControl;
    //ImageCollectionViewController*imageCollecitonViewController;
    UICollectionView*imageCollectionView;
    
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
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
     CGRect rect=self.view.frame;
     rect.origin.y=rect.origin.y+44;
     scrollView.frame=rect;
     
   
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
    //[self initImageCollectionViewController];
    [self initImageCollectionView];
   

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
    //imageCollecitonViewController.view.frame=rect;
    
    imageCollectionView.frame=rect;
}
-(void)layoutProductCell{
    CGRect rect=CGRectMake(HorizontalMargin, CGRectGetMaxY(imageCollectionView.frame)+ViewDistance,subViewWidth, CellProductHeight);
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
/*
-(void)initImageCollectionViewController{
    UICollectionViewFlowLayout*imageLayout=[[UICollectionViewFlowLayout alloc]init];
    imageLayout.itemSize=CGSizeMake(CollectionViewCellLength,CollectionViewCellLength);
    imageLayout.minimumInteritemSpacing=CollectionViewImageMargin;
    imageLayout.minimumLineSpacing=CollectionViewImageMargin;
    imageLayout.sectionInset=UIEdgeInsetsMake(CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin);
    imageCollecitonViewController=[[ImageCollectionViewController alloc]initWithCollectionViewLayout:imageLayout];
    imageCollecitonViewController.addCellImage=[UIImage imageNamed:ProfileHeaderJpeg];
    imageCollecitonViewController.mainViewController=self;
    [imageLayout release];
     [scrollView addSubview:imageCollecitonViewController.view];
}*/

-(void)initImageCollectionView{
    UICollectionViewFlowLayout*imageLayout=[[UICollectionViewFlowLayout alloc]init];
    imageLayout.itemSize=CGSizeMake(CollectionViewCellLength,CollectionViewCellLength);
    imageLayout.minimumInteritemSpacing=CollectionViewImageMargin;
    imageLayout.minimumLineSpacing=CollectionViewImageMargin;
    imageLayout.sectionInset=UIEdgeInsetsMake(CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin, CollectionViewImageMargin);
    imageCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:imageLayout];
    [imageLayout release];
    imageCollectionView.delegate=self;
    imageCollectionView.dataSource=self;
    [scrollView addSubview:imageCollectionView];
    
    UINib*cellNib=[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil];
    [imageCollectionView registerNib:cellNib forCellWithReuseIdentifier:ImageCellIdentifer];
    

}

#pragma mark -- CollectionViewController Delegate messages


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (([self.imageArray count]==indexPath.row)&&(MaxImageAmount!=[self.imageArray count])){
        
        [self promoteImageActionSheet];
        return;
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
        imageView.image=[UIImage imageNamed:ProfileHeaderJpeg];//self.addCellImage;
        imageView.alpha=0.5;
    }
    else{
        UIImage*img=[self.imageArray objectAtIndex:indexPath.row];
        imageView.image=img;
        
    }
    
    return  cell;
}

#pragma mark -- QBImagePickerControllerDelegate messages

-(void)imagePickerController:(UIViewController *)imagePickerController didFinishPickingMediaWithInfo:(id)info{
    
    if ([imagePickerController class]==[QBImagePickerController class]) {
        
        NSArray*dictArray=(NSArray*)info;
        for (NSDictionary*dict in dictArray) {
            UIImage*image=[dict valueForKey:MediaInfoKeyOrigianlImage];
            [self.imageArray addObject:image];
        }
        
        [imagePickerController.navigationController dismissViewControllerAnimated:YES completion:^{[imageCollectionView reloadData];}];
        
        return;
    }
    
    if ([imagePickerController class]==[UIImagePickerController class]) {
        UIImagePickerController*picker=(UIImagePickerController*)imagePickerController;
        NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
        //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
        if ([type isEqualToString:(NSString*)kUTTypeImage]&&picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
            //获取照片的原图
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            [self.imageArray addObject:original];
            UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
            [imagePickerController dismissViewControllerAnimated:YES completion:^{
                [imageCollectionView reloadData];
            }];
        }
    }
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo{
    
    NSLog(@"saved..");
}

#pragma mark -- UIActionSheetDelegate messages

-(void)actionSheetCancel:(UIActionSheet *)actionSheet{
    [actionSheet resignFirstResponder];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case ImageFromCameraIndex:
            [self presentQBImagePicker];
            break;
        case ImageFromAlbumIndex:
            [self presentCameraImagePicker];
            break;
        default:
            break;
    }
}



#pragma mark -- private messages

-(void)presentQBImagePicker{
    NSLog(@"Present Image Add ViewController");
    QBImagePickerController*qpvc=[[QBImagePickerController alloc]init];
    qpvc.filterType=QBImagePickerFilterTypeAllPhotos;
    qpvc.delegate=self;
    qpvc.allowsMultipleSelection=YES;
    qpvc.limitsMaximumNumberOfSelection=YES;
    qpvc.maximumNumberOfSelection=MaxImageAmount-[self.imageArray count];
    UINavigationController*naviPicker=[[UINavigationController alloc]initWithRootViewController:qpvc];
    //[self.navigationController pushViewController:qpvc animated:YES];
    [self.navigationController presentViewController:naviPicker animated:YES completion:nil];
    [qpvc release];
    [naviPicker release];
    
}
-(void)presentCameraImagePicker{
    UIImagePickerController*picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.delegate=self;
    
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}

-(void)promoteImageActionSheet{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Destructive", nil) otherButtonTitles:NSLocalizedString(@"ImageFromCamera", nil),NSLocalizedString(@"ImageFromAlbum", nil) , nil];
    sheet.actionSheetStyle=UIActionSheetStyleDefault;
    //sheet.destructiveButtonIndex=3;
    [sheet showInView:self.view];
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
    NSLog(@"Submit wishs");
}

@end
