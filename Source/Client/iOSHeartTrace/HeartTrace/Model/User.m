//
//  User.m
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "User.h"

@implementation User
/*
 @property(nonatomic,retain)NSString*userId;
 @property(nonatomic,retain)NSString*nickName;
 @property(nonatomic,retain)NSString*account;
 @property(nonatomic,retain)NSString*accoutnType;
 */

@synthesize userId;
@synthesize nickName;
@synthesize account;
@synthesize accoutnType;

-(void)dealloc{
    [self.userId release];
    [self.nickName release];
    [self.account release];
    [self.accoutnType release];
    [super dealloc];
}
+(User*)fakeUser:(NSInteger)userIndex{
    User*result=[[[User alloc]init]autorelease];
    result.userId=[NSString stringWithFormat:@"uid%i",userIndex];
    result.account=[NSString stringWithFormat:@"Account%i",userIndex];
    result.accoutnType=@"DefaultAccount";
    result.nickName=[NSString stringWithFormat:@"NickName%i",userIndex];
    return result;
}

@end
