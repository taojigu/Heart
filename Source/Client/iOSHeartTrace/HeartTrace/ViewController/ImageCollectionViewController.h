//
//  ImageCollectionViewController.h
//  HeartTrace
//
//  Created by user on 14-1-13.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QBImagePickerControllerDelegate;

@protocol ImageCollectionViewControllerDelegate <NSObject>



@end


@interface ImageCollectionViewController : UICollectionViewController<QBImagePickerControllerDelegate>{

}

@property(nonatomic,assign)id<ImageCollectionViewControllerDelegate>delegate;


@property(nonatomic,retain)UIImage*addCellImage;
@property(nonatomic,retain)NSMutableArray*imageArray;
@property(nonatomic,retain)UIViewController*mainViewController;

@end
