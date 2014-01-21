//
//  ProductPageParser.m
//  HeartTrace
//
//  Created by user on 14-1-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ProductPageParser.h"
#import "FakeDataFactory.h"

@implementation ProductPageParser

-(ElementsContainer*)parse:(NSData*)data{
    return [FakeDataFactory fakeProductPage:0 pageSize:12];
}
@end
