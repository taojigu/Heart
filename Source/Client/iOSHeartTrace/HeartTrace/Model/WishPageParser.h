//
//  WishPageParser.h
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ElementsContainer;
@interface WishPageParser : NSObject


-(ElementsContainer*)parse:(NSData*)data;
@end
