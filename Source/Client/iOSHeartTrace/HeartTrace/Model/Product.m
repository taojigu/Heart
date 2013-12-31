//
//  Product.m
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "Product.h"
#import "Organization.h"

/*
 @property(nonatomic,retain)NSString*productId;
 @property(nonatomic,retain)NSString*name;
 @property(nonatomic,retain)NSString*text;
 @property(nonatomic,retain)NSString*imageUrl;
 @property(nonatomic,assign)float price;
 @property(nonatomic,assign)NSString*launchedDate;
 @property(nonatomic,retain)Organization*organization;
 */

@implementation Product

@synthesize productId;
@synthesize name;
@synthesize text;
@synthesize imageUrl;
@synthesize launchedDate;
@synthesize organization;
@synthesize price;


-(void)dealloc{
    [self.productId release];
    [self.name release];
    [self.text release];
    [self.imageUrl release];
    [self.launchedDate release];
    [self.organization release];
    [super dealloc];
}

+(Product*)fakeProduct:(NSInteger)productIndex{
    Product*prdt=[[[Product alloc]init]autorelease];
    prdt.name=[NSString stringWithFormat:@"ProductName%i",productIndex];
    prdt.productId=[NSString stringWithFormat:@"pid%i",productIndex];
    prdt.imageUrl=nil;
    prdt.launchedDate=@"2013-12-31";
    prdt.organization=nil;
    return prdt;
}
@end
