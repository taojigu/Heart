//
//  WishTableViewCell.h
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Wish;

@interface WishTableViewCell : UITableViewCell

@property(nonatomic,retain)Wish*wish;
+(CGFloat)heightForCell:(Wish*)wish;

@end
