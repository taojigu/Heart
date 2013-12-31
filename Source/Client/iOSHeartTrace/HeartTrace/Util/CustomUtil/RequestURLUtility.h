//
//  RequestURLUtility.h
//  HeartTrace
//
//  Created by user on 13-12-24.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestURLUtility : NSObject

+(NSString*)wishRequestURLString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
@end
