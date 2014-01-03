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
#import "ImageInfo.h"
#import "ImageInfo.h"


@implementation Wish

@synthesize user;
@synthesize product;
@synthesize time;
@synthesize text;
@synthesize imageUrl;
@synthesize title;
@synthesize imageInfoArray;

-(id)init{
    self=[super init];
    user=[[User alloc]init];
    product=[[Product alloc]init];
    imageInfoArray=[[NSMutableArray alloc]init];
    return self;
}
-(void)dealloc{
    [self.title release];
    [self.user release];
    [self.product release];
    [self.time release];
    [self.text release];
    [self.imageUrl release];
    [self.imageInfoArray release];
    
    [super dealloc];
}
+(Wish*)fakeWish:(NSInteger)wishIndex{
    Wish*wish=[[[Wish alloc]init]autorelease];
    User*fakeUser=[User fakeUser:wishIndex];
    wish.user=fakeUser;
    wish.imageUrl=nil;
    NSMutableString*strText=[[NSMutableString alloc]init];
    for (NSInteger indx=0; indx<=wishIndex; indx++) {
        [strText appendFormat:@"The wish text is %i",indx];
    }
    wish.text=strText;
    [strText release];
    wish.time=@"2013-12-31";
    wish.product=[Product fakeProduct:wishIndex];
    ImageInfo*imageInfo=[ImageInfo fakeImageInfo:wishIndex];
    [wish.imageInfoArray addObject:imageInfo];
    return wish;
    
}

@end
