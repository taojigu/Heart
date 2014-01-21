//
//  Organization.h
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ElementsContainer;

@interface Organization : NSObject

@property(nonatomic,retain)NSString*organizationId;
@property(nonatomic,retain)NSString*name;
@property(nonatomic,retain)ElementsContainer*productElementContainer;

+(Organization*)fakeOrganization:(NSInteger)index;


@end
