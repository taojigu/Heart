//
//  WishTableViewCell.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "WishTableViewCell.h"
#import "Wish.h"

#define CELL_LEfT_MARGIN 20
#define CELL_RIGHT_MARGIN 10
#define CELL_HEIGHT_MARGIN 5

#define DEFAULT_CELL_HEIGHT 44
#define DEFAULT_CELL_WIDTH 320
#define FONT_SIZE 14

#define ICON_IMAGE_LENGTH 40

#define IMAGE_WIDTH 150
#define IMAGE_HEIGHT 100
@implementation WishTableViewCell

@synthesize wish;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    [self.wish release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)heightForCell:(Wish *)wish{
    NSAssert(nil!=wish, @"no cell height for nil cell");
    
    CGFloat headerHeight=0;
    
    NSDictionary*attriDict=[NSDictionary dictionaryWithObject:NSFontAttributeName forKey:[UIFont systemFontOfSize:14]];
    CGSize constraintSize=CGSizeMake(DEFAULT_CELL_WIDTH-CELL_LEfT_MARGIN-CELL_RIGHT_MARGIN, 200000 );
    
    NSAttributedString*attriString=[[NSAttributedString alloc]initWithString:nil attributes:attriDict];
    CGRect rect=[attriString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat height=MAX(rect.size.height, DEFAULT_CELL_HEIGHT);
    
                                    
    return height=2*CELL_HEIGHT_MARGIN;
}


@end
