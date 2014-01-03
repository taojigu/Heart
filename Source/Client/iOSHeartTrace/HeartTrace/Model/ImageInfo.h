//
//  ImageInfo.h
//  HeartTrace
//
//  Created by user on 14-1-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject{
    
}

@property(nonatomic,retain)NSString*imageId;
@property(nonatomic,retain)NSString*imageName;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,retain)NSString*imageUrlString;
@property(nonatomic,retain)NSString*introduction;


+(ImageInfo*)fakeImageInfo:(NSInteger)imageIndex;
@end
