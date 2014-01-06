//
//  IntroductionViewController.h
//  HeartTrace
//
//  Created by user on 13-12-23.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroductionViewCotrollerDelegate <NSObject>

-(void)introductionDidFinish:(UIViewController*)viewController;

@end

@interface IntroductionViewController : UIViewController{
    
}

@property(nonatomic,assign)id<IntroductionViewCotrollerDelegate>delegate;

@end
