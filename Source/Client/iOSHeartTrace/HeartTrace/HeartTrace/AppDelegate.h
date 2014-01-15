//
//  AppDelegate.h
//  HeartTrace
//
//  Created by user on 13-12-20.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroductionViewCotrollerDelegate;


@interface AppDelegate : UIResponder <UIApplicationDelegate,ASIHTTPRequestDelegate,IntroductionViewCotrollerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
