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
+(NSString*)productRequestURLString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
+(NSString*)organizationRequestURLString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
+(NSString*)searchProductRequestURLString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
+(NSString*)shakeProductUrl;
@end
