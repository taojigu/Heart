//
//  WishPageParser.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "WishPageParser.h"
#import "ElementsContainer.h"
#import "FakeDataFactory.h"

@implementation WishPageParser

-(ElementsContainer*)parse:(NSData*)data{
    
    ElementsContainer*fakeResult=[FakeDataFactory fakeWishPage:0 pageSize:3];
    return fakeResult;
}

@end
