//
//  ProductDelegate.h
//  HeartTrace
//
//  Created by user on 14-1-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@protocol ProductDelegate <NSObject>

-(void)productDidSelected:(id)sender product:(Product*)product;

@end
