//
//  User.h
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    
}

@property(nonatomic,retain)NSString*userId;
@property(nonatomic,retain)NSString*nickName;
@property(nonatomic,retain)NSString*account;
@property(nonatomic,retain)NSString*accoutnType;

+(User*)fakeUser:(NSInteger)userIndex;

@end
