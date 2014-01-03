//
//  Wish.h
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class Product;
@class ImageInfo;

@interface Wish : NSObject{
    
}

@property(nonatomic,retain)NSString*title;
@property(nonatomic,retain)User*user;
@property(nonatomic,retain)Product*product;
@property(nonatomic,retain)NSString*time;
@property(nonatomic,retain)NSString*text;
@property(nonatomic,retain)NSString*imageUrl;
@property(nonatomic,retain)NSMutableArray*imageInfoArray;

+(Wish*)fakeWish:(NSInteger)wishIndex;

@end
