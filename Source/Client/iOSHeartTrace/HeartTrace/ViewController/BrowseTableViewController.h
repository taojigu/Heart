//
//  BrowseTableViewController.h
//  HeartTrace
//
//  Created by user on 14-1-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ProductDelegate;

typedef enum {
    BrowseScopeProduct=0,
    BrowseScopeOrganization=1,
    BrowseScopeAll=2,
    BrowseScopeNone=-1
} BrowseScope;



@interface BrowseTableViewController : UITableViewController{
    
}


@property(nonatomic,assign)id<ProductDelegate>delegate;
@property(nonatomic,assign)BrowseScope scope;


@end
