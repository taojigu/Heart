//
//  OrganizationPageParser.h
//  HeartTrace
//
//  Created by user on 14-1-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ElementsContainer;

@interface OrganizationPageParser : NSObject

-(ElementsContainer*)parse:(NSData*)data;

@end
