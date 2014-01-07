//
//  WishTableViewCell.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "WishTableViewCell.h"
#import "Wish.h"
#import "Product.h"
#import "User.h"
#import "Organization.h"
#import "ImageInfo.h"

#define DefaultCellWidth 320
#define DefaultCellHeight 44

#define WishTextFontSize 14
#define ProductTextFontSize 16
#define UserButtonFontSize 14
#define TimeFontSize 12

#define CELL_LEfT_MARGIN 20
#define CELL_RIGHT_MARGIN 10

#define FONT_SIZE 14

#define ICON_IMAGE_LENGTH 40

#define WISH_IMAGE_VIEW_HEIGHT 80
#define PRODUCT_HEIGHT 60

//#define IMAGE_WIDTH 150
//#define IMAGE_HEIGHT 150
#define ProfileImageViewWidth 80
#define ProfileImageViewHeight 80

#define TimeLabelHeight 20

#define ProductViewInnerMargin 4

@interface WishTableViewCell (){
    @private
    UIImageView*imageViewProfile;
    UIButton*btnUser;
    UILabel*labelWishText;
    UIImageView*imageViewWish;
    UIButton*btnProduct;
    //UIImageView*imageViewProduct;
    //UILabel*labelProductText;
    UILabel*labelTime;
}


-(void)reloadCellData;
-(void)layoutCellDataViews;
-(void)initSubviews;
-(IBAction)productButtonClicked:(id)sender;

@end

@implementation WishTableViewCell

@synthesize wish;
@synthesize imageViewProfile;
@synthesize btnUser;
@synthesize labelWishText;
@synthesize imageViewWish;
@synthesize btnProduct;
//@synthesize imageViewProduct;
//@synthesize labelProductText;
@synthesize labelTime;

#define Header_Distance 2
#define User_WishText_Distance 2
#define Header_WishImage_Distance 5
#define Header_UserButton_Distance 7
#define WishImage_Product_Distance 5
#define Product_Time_Distance 4
#define Footer_Distance 5




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
  
    [self.wish release];
    [self.imageViewProfile release];
    [self.btnUser release];
    [self.labelWishText release];
    [self.imageViewWish release];
    [self.btnProduct release];
    //[self.imageViewProduct release];
    //[self.labelProductText release];
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
    [self layoutCellDataViews];
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


-(void)layoutCellDataViews{
    CGRect profileRect=CGRectMake(CELL_LEfT_MARGIN,Header_Distance,ProfileImageViewWidth,ProfileImageViewHeight);
    //profileRect=CGRectInset(profileRect, 0, );
    self.imageViewProfile.frame=profileRect;
    
    CGFloat left=CGRectGetWidth(profileRect)+2*CELL_LEfT_MARGIN;
    CGFloat width=DefaultCellWidth-left-CELL_RIGHT_MARGIN;
    
    CGSize btnSize=[WishTableViewCell userNameButtonSize:self.wish.user.nickName width:width font:[UIFont systemFontOfSize:UserButtonFontSize]];
    //CGSize btnSize=[WishTableViewCell textSize:self.wish.user.nickName width:width font:[UIFont systemFontOfSize:UserButtonFontSize]];
    CGRect userNameRect=CGRectMake(left,Header_UserButton_Distance, btnSize.width, btnSize.height);
    self.btnUser.frame=userNameRect;
    
    //CGSize wishTextSize=[self.wish.text sizeWithFont:self.labelWishText.font forWidth:width lineBreakMode:NSLineBreakByWordWrapping];
    CGSize wishTextSize=[WishTableViewCell wishTextSize:self.wish width:width font:self.labelWishText.font];
    CGFloat nextTop=CGRectGetMaxY(btnUser.frame)+User_WishText_Distance;
    CGRect wishTextRect=CGRectMake(left, nextTop, wishTextSize.width, wishTextSize.height);
    self.labelWishText.frame=wishTextRect;
    
    nextTop=CGRectGetMaxY(self.labelWishText.frame)+Header_WishImage_Distance;
    CGSize wishImageSize=[WishTableViewCell wishImageSize:self.wish];
    self.imageViewWish.frame=CGRectMake(left, nextTop, wishImageSize.width, wishImageSize.height);
    
    
    nextTop=CGRectGetMaxY(self.imageViewWish.frame)+WishImage_Product_Distance;
    CGSize productViewSize=[WishTableViewCell productViewSize:self.wish width:width];
    btnProduct.frame=CGRectMake(left , nextTop, productViewSize.width, productViewSize.height);
    
    nextTop=CGRectGetMaxY(self.btnProduct.frame)+Product_Time_Distance;
    CGSize timeLabelSize=[WishTableViewCell timeLabelSize:self.wish width:width];
    labelTime.frame=CGRectMake(left, nextTop, timeLabelSize.width,timeLabelSize.height);
    
    CGRect productImageRect=CGRectInset(btnProduct.bounds, ProductViewInnerMargin, ProductViewInnerMargin);
    productImageRect.size.width=productImageRect.size.height;
   
    
    CGRect productLabelRect=CGRectInset(btnProduct.bounds, ProductViewInnerMargin, ProductViewInnerMargin);
    left=CGRectGetMaxX(productImageRect)+ProductViewInnerMargin;
    productLabelRect.origin.x=left;
    productLabelRect.size.width=CGRectGetWidth(btnProduct.frame)-CGRectGetWidth(productImageRect)-3*ProductViewInnerMargin;


    CGFloat imageRightInset=CGRectGetWidth(btnProduct.frame)-CGRectGetMaxX(productImageRect);
    [btnProduct setImageEdgeInsets:UIEdgeInsetsMake(ProductViewInnerMargin ,ProductViewInnerMargin ,ProductViewInnerMargin, imageRightInset)];
    
    [btnProduct setTitleEdgeInsets:UIEdgeInsetsMake(ProductViewInnerMargin, -120, ProductViewInnerMargin, ProductViewInnerMargin)];
    
    
}
-(void)initSubviews{

    imageViewProfile=[[UIImageView alloc]initWithFrame:CGRectZero];
    imageViewProfile.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:imageViewProfile];
    btnUser=[[UIButton alloc]initWithFrame:CGRectZero];
    btnUser.titleLabel.font=[UIFont systemFontOfSize:UserButtonFontSize];
    [btnUser setBackgroundColor:[UIColor grayColor]];
    btnUser.titleLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:btnUser];
    [btnUser setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
   
    labelWishText=[[UILabel alloc]initWithFrame:CGRectZero];
    labelWishText.font=[UIFont systemFontOfSize:WishTextFontSize];
    labelWishText.lineBreakMode=NSLineBreakByWordWrapping;
    labelWishText.textAlignment=NSTextAlignmentLeft;
    labelWishText.numberOfLines=0;
    
    [self.contentView addSubview:labelWishText];
    
    imageViewWish=[[UIImageView alloc]initWithFrame:CGRectZero];
    imageViewWish.userInteractionEnabled=NO;
    imageViewWish.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:imageViewWish];
    
    btnProduct=[[UIButton alloc]initWithFrame:CGRectZero];
    btnProduct.backgroundColor=[UIColor grayColor];
    btnProduct.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    btnProduct.titleLabel.numberOfLines=2;
    [btnProduct addTarget:self action:@selector(productButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.contentView addSubview:btnProduct];
   

    labelTime=[[UILabel alloc]initWithFrame:CGRectZero];
    labelTime.font=[UIFont systemFontOfSize:TimeFontSize];
    labelTime.textColor=[UIColor blueColor];
    [self.contentView addSubview:labelTime];
    
}

+(CGFloat)heightForCell:(Wish *)wish{
    CGFloat cellHeight=0;
    NSAssert(nil!=wish, @"no cell height for nil wish");
    CGFloat rightWidth=DefaultCellWidth-ProfileImageViewWidth-2*CELL_LEfT_MARGIN-CELL_RIGHT_MARGIN;
   
    CGFloat rightHeight=Header_UserButton_Distance;
    //CGSize sz=[wish.user.nickName sizeWithFont:[UIFont systemFontOfSize:UserButtonFontSize]];
    //CGSize sz=[WishTableViewCell textSize:wish.user.nickName width:rightWidth font:[UIFont systemFontOfSize:UserButtonFontSize]];
    CGSize sz=[WishTableViewCell userNameButtonSize:wish.user.nickName width:rightWidth font:[UIFont systemFontOfSize:UserButtonFontSize]];
    rightHeight+=sz.height+User_WishText_Distance;
    sz=[WishTableViewCell wishTextSize:wish width:rightWidth font:[UIFont systemFontOfSize:WishTextFontSize]];
    
    rightHeight+=sz.height;
    
    CGFloat headerHeight=rightHeight;
    cellHeight+=headerHeight;
    cellHeight+=Header_WishImage_Distance;
    
    cellHeight+=[WishTableViewCell wishImageSize:wish].height;
    cellHeight+=[WishTableViewCell productViewSize:wish width:rightWidth].height;
    cellHeight+=Product_Time_Distance;
    cellHeight+=[WishTableViewCell timeLabelSize:wish width:rightWidth].height;
    cellHeight+=Footer_Distance;
    return  cellHeight;

}

+(CGSize)wishImageSize:(Wish*)wish{
    if ([wish.imageInfoArray count]==0) {
        return CGSizeZero;
    }
    ImageInfo*info=[wish.imageInfoArray objectAtIndex:0];
    return CGSizeMake(info.width, info.height);
}
+(CGSize)productViewSize:(Wish*)wish width:(CGFloat)width{

    return CGSizeMake(width,PRODUCT_HEIGHT);
}
+(CGSize)timeLabelSize:(Wish*)wish width:(CGFloat)width {
    return [wish.time sizeWithFont:[UIFont systemFontOfSize:TimeFontSize]];
    //return [WishTableViewCell textSize:wish.time width:width font:[UIFont systemFontOfSize:TimeFontSize]];
}

+(CGSize)textSize:(NSString*)text width:(NSInteger)width font:(UIFont*)font{
    if (0==[text length]) {
        return CGSizeZero;
    }
    NSMutableDictionary*attriDict=[NSMutableDictionary dictionaryWithObject:NSFontAttributeName forKey:font];
    
    NSMutableParagraphStyle *titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    //titleParagraphStyle.lineHeightMultiple = 0.9f;
    titleParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //titleParagraphStyle.tailIndent=10;
    //titleParagraphStyle.headIndent=12;
    
    [attriDict setObject:titleParagraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString*attriString=[[NSMutableAttributedString alloc]initWithString:text attributes:attriDict];
    
    
    CGSize constraintSize=CGSizeMake(width, MAXFLOAT);
    CGRect rect=[attriString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    [attriString release];
    return  rect.size;
}
+(CGSize)userNameButtonSize:(NSString*)userName width:(CGFloat)width font:(UIFont*)font{
    NSAssert([userName length]>0, @"User name should not be nil");
    CGSize sz=CGSizeZero;
    sz=[WishTableViewCell textSize:userName width:width font:[UIFont systemFontOfSize:WishTextFontSize]];
    sz=[userName sizeWithFont: font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return sz;
    //return [WishTableViewCell textSize:userName width:width font:[UIFont systemFontOfSize:WishTextFontSize]];
}
+(CGSize)wishTextSize:(Wish*)wish width:(NSInteger)width font:(UIFont*)font{
   
    //return [WishTableViewCell textSize:wish.text width:width font:[UIFont systemFontOfSize:WishTextFontSize]];
    //CGSize sz=[wish.text sizeWithAttributes:attriDict];
    CGSize sz=[wish.text sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return sz;
}

-(IBAction)productButtonClicked:(id)sender{
    
}




@end
