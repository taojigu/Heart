//
//  Product.h
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Organization;
@class Product;

@interface Product : NSObject


@property(nonatomic,retain)NSString*productId;
@property(nonatomic,retain)NSString*name;
@property(nonatomic,retain)NSString*text;
@property(nonatomic,retain)NSString*imageUrl;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)NSString*launchedDate;
@property(nonatomic,retain)Organization*organization;

+(Product*)fakeProduct:(NSInteger)productIndex;

@end
