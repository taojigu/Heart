//
//  Organization.m
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "Organization.h"

@implementation Organization

@synthesize organizationId;
@synthesize name;

-(void)dealloc{
    [self.organizationId release];
    [self.name release];
    [super dealloc];
}

@end
