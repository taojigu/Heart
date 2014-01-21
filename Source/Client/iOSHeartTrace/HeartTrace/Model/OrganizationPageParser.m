//
//  OrganizationPageParser.m
//  HeartTrace
//
//  Created by user on 14-1-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "OrganizationPageParser.h"
#import "ElementsContainer.h"
#import "FakeDataFactory.h"

@implementation OrganizationPageParser

-(ElementsContainer*)parse:(NSData*)data{
    return [FakeDataFactory fakeOrganizationPage:0 pageSize:12];
}

@end
