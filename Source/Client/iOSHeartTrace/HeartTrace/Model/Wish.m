//
//  Wish.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "Wish.h"
#import "User.h"
#import "Product.h"



@implementation Wish

@synthesize user;
@synthesize product;
@synthesize time;
@synthesize text;
@synthesize imageUrl;
@synthesize title;

-(void)dealloc{
    [self.title release];
    [self.user release];
    [self.product release];
    [self.time release];
    [self.text release];
    [self.imageUrl release];
    
    [super dealloc];
}
+(Wish*)fakeWish:(NSInteger)wishIndex{
    Wish*wish=[[[Wish alloc]init]autorelease];
    User*fakeUser=[User fakeUser:wishIndex];
    wish.user=fakeUser;
    wish.imageUrl=nil;
    wish.text=[NSString stringWithFormat:@"The Wish Text is %i",wishIndex];
    wish.time=@"2013-12-31";
    wish.product=[Product fakeProduct:wishIndex];
    return wish;
    
}

@end
