//
//  ASIHTTPRequest+RequestIdentify.m
//  HeartTrace
//
//  Created by user on 14-1-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ASIHTTPRequest+RequestIdentify.h"
#import <objc/runtime.h>

#define RequestNamePropertyKey @"PropertyRequestName"

@implementation ASIHTTPRequest (RequestIdentify)


-(NSString*)requestName{
    return objc_getAssociatedObject(self, RequestNamePropertyKey);
}

-(void)setRequestName:(NSString *)requestName{
    objc_setAssociatedObject(self, RequestNamePropertyKey, requestName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
