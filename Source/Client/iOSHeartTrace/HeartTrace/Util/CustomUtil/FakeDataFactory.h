//
//  FakeDataFactory.h
//  HeartTrace
//
//  Created by user on 13-12-31.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ElementsContainer;


@interface FakeDataFactory : NSObject

+(ElementsContainer*)fakeWishPage:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
