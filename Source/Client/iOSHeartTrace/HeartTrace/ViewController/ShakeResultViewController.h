//
//  ShakeResultViewController.h
//  HeartTrace
//
//  Created by user on 14-1-22.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ElementsContainer;
@protocol ProductDelegate;


@interface ShakeResultViewController : UIViewController<ProductDelegate>{
    
}

@property(nonatomic,retain)ElementsContainer*shareResultContainer;
@property(nonatomic,assign)id<ProductDelegate>delegate;

@end
