//
//  ImageInfo.m
//  HeartTrace
//
//  Created by user on 14-1-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageInfo.h"

@implementation ImageInfo


@synthesize imageId;
@synthesize imageName;
@synthesize width;
@synthesize height;
@synthesize imageUrlString;
@synthesize introduction;
@synthesize image;

-(void)dealloc{
    [self.imageId release];
    [self.imageName release];
    [self.imageUrlString release];
    [self.introduction release];
    [self.image release];
    [super dealloc];
}
+(ImageInfo*)fakeImageInfo:(NSInteger)imageIndex{
    ImageInfo*result=[[[ImageInfo alloc]init]autorelease];
    result.imageId=[NSString stringWithFormat:@"ImageId %i",imageIndex];
    result.imageName=[NSString stringWithFormat:@"ImageName %i",imageIndex];
    result.width=80;
    result.height=120;
    result.introduction=[NSString stringWithFormat:@"The image introduction for the image %i",imageIndex];
    return result;
}
+(ImageInfo*)imageInfoFromImage:(UIImage*)image{
    ImageInfo*info=[[[ImageInfo alloc]init]autorelease];
    info.image=image;
    return info;
}


@end
