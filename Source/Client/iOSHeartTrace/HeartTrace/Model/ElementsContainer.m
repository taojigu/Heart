//
//  ElementsContainer.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "ElementsContainer.h"

@implementation ElementsContainer

@synthesize pageIndex;
@synthesize pageSize;
@synthesize count;
@synthesize elementArray;

-(void)dealloc{
    [self.elementArray release];
    [super dealloc];
}

@end
