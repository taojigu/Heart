//
//  WishTableViewCell.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "WishTableViewCell.h"
#import "Wish.h"

#define WishTextFontSize 14
#define ProductTextFontSize 12

#define CELL_LEfT_MARGIN 20
#define CELL_RIGHT_MARGIN 10
#define CELL_HEIGHT_MARGIN 5

#define DEFAULT_CELL_HEIGHT 44
#define DEFAULT_CELL_WIDTH 320
#define FONT_SIZE 14

#define ICON_IMAGE_LENGTH 40

#define WISH_IMAGE_VIEW_HEIGHT 80
#define PRODUCT_HEIGHT 40

#define IMAGE_WIDTH 150
#define IMAGE_HEIGHT 100
#define HEADER_HEIGHT 40

@interface WishTableViewCell (){
    @private
    UIImageView*imageViewProfile;
    UIButton*btnUser;
    UILabel*labelWishText;
    UIImageView*imageViewWish;
    UIView*viewProduct;
    UIImageView*imageViewProduct;
    UILabel*labelProductText;
    UILabel*labelTime;
}
@property(nonatomic,retain)UIImageView*imageViewProfile;
@property(nonatomic,retain)UIButton*btnUser;
@property(nonatomic,retain)UILabel*labelWishText;
@property(nonatomic,retain)UIImageView* imageViewWish;
@property(nonatomic,retain)UIView*viewProduct;
@property(nonatomic,retain)UIImageView*imageViewProduct;
@property(nonatomic,retain)UILabel*labelProductText;
@property(nonatomic,retain)UILabel*labelTime;


-(void)reloadCellData;
-(void)layoutCellDataViews;
-(void)initSubviews;

@end

@implementation WishTableViewCell

@synthesize wish;
@synthesize imageViewProfile;
@synthesize btnUser;
@synthesize labelWishText;
@synthesize imageViewWish;
@synthesize viewProduct;
@synthesize imageViewProduct;
@synthesize labelProductText;
@synthesize labelTime;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

-(void)dealloc{
   /*
    @synthesize wish;
    @synthesize imageViewProfile;
    @synthesize btnUser;
    @synthesize labelWishText;
    @synthesize imageViewWish;
    @synthesize viewProduct;
    @synthesize imageViewProduct;
    @synthesize labelProduct;
    @synthesize labelTime;
    */
    [self.wish release];
    [self.imageViewProfile release];
    [self.btnUser release];
    [self.labelWishText release];
    [self.imageViewWish release];
    [self.viewProduct release];
    [self.imageViewProduct release];
    [self.labelProductText release];
    [self.labelTime release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setWish:(Wish *)ws{
    if (nil!=wish) {
        [wish release];
    }
    wish=ws;
    [wish retain];
    [self reloadCellData];
    [self setNeedsDisplay];
}


-(void)reloadCellData{
    
}
#define ProFileWidth 70

-(void)layoutCellDataViews{
    CGRect profileRect=CGRectMake(CELL_LEfT_MARGIN,0,ProFileWidth,HEADER_HEIGHT);
    profileRect=CGRectInset(profileRect, 0, 4);
    self.imageViewProfile.frame=profileRect;
    
    CGFloat left=CGRectGetWidth(profileRect)+2*CELL_LEfT_MARGIN;
    CGFloat width=CGRectGetWidth(self.frame)-left;
    CGRect userNameRect=CGRectMake(left, 0, width, HEADER_HEIGHT);
    userNameRect=CGRectInset(userNameRect, 0, 8);
    self.btnUser.frame=userNameRect;
    
    
}
-(void)initSubviews{

    imageViewProfile=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageViewProfile];
    btnUser=[[UIButton alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:btnUser];
    [btnUser setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
   
    labelWishText=[[UILabel alloc]initWithFrame:CGRectZero];
    labelWishText.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:labelWishText];
    
    imageViewWish=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageViewWish];
    
    viewProduct=[[UIView alloc]initWithFrame:CGRectZero];
    viewProduct.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:viewProduct];
   
    labelProductText=[[UILabel alloc]initWithFrame:CGRectZero];
    labelProductText.font=[UIFont systemFontOfSize:12];
    [viewProduct addSubview:labelProductText];
    
    imageViewProduct=[[UIImageView alloc]initWithFrame:CGRectZero];
    [viewProduct addSubview:imageViewProduct];
    labelTime=[[UILabel alloc]initWithFrame:CGRectZero];
    labelTime.textColor=[UIColor blueColor];
    
    
}

+(CGFloat)heightForCell:(Wish *)wish{
    NSAssert(nil!=wish, @"no cell height for nil cell");
    
    CGFloat headerHeight=0;
    
    CGFloat wishTextHeight=[WishTableViewCell wishTextHeight:wish.text];
    
    CGFloat imageHieght=[WishTableViewCell imageHeight:wish.imageUrl];
    
    CGFloat productHeight=[WishTableViewCell productHeight:wish.product];
    
    CGFloat tailHeight=0;
    
    return  headerHeight+wishTextHeight+imageHieght+productHeight+tailHeight;

}
+(CGFloat)productHeight:(Product*)product{
    if(nil==product){
        return 0;
    }
    return  PRODUCT_HEIGHT;
}
+(CGFloat)imageHeight:(NSString*)imageUrlString{
    if (0==[imageUrlString length]) {
        return 0;
    }
    return WISH_IMAGE_VIEW_HEIGHT;
}
+(CGFloat)wishTextHeight:(NSString*)text{
    
    if ([text length]==0) {
        return 0;
    }
    
    NSDictionary*attriDict=[NSDictionary dictionaryWithObject:NSFontAttributeName forKey:[UIFont systemFontOfSize:14]];
    CGSize constraintSize=CGSizeMake(DEFAULT_CELL_WIDTH-CELL_LEfT_MARGIN-CELL_RIGHT_MARGIN, 200000 );
    
    NSAttributedString*attriString=[[NSAttributedString alloc]initWithString:text attributes:attriDict];
    CGRect rect=[attriString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat height=MAX(rect.size.height, DEFAULT_CELL_HEIGHT);
    
    return height+2*CELL_HEIGHT_MARGIN;
}


@end
