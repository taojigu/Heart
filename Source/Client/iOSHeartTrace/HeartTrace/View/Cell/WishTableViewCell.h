//
//  WishTableViewCell.h
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Wish;
@class Product;

@interface WishTableViewCell : UITableViewCell

@property(nonatomic,retain)Wish*wish;
@property(nonatomic,retain)UIImageView*imageViewProfile;
@property(nonatomic,retain)UIButton*btnUser;
@property(nonatomic,retain)UILabel*labelWishText;
@property(nonatomic,retain)UIImageView* imageViewWish;
@property(nonatomic,retain)UIView*viewProduct;
@property(nonatomic,retain)UIImageView*imageViewProduct;
@property(nonatomic,retain)UILabel*labelProductText;
@property(nonatomic,retain)UILabel*labelTime;

+(CGFloat)heightForCell:(Wish *)wish;


+(CGSize)wishImageSize:(Wish*)wish;
+(CGSize)productViewSize:(Wish*)wish width:(CGFloat)width;
+(CGSize)timeLabelSize:(Wish*)wish width:(CGFloat)width ;
+(CGSize)textSize:(NSString*)text width:(NSInteger)width font:(UIFont*)font;

@end
