//
//  AppDelegate.m
//  HeartTrace
//
//  Created by user on 13-12-20.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "AppDelegate.h"
#import "ConstConfigure.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "DefaultValueConfigure.h"
#import "IntroductionViewController.h"
#import "WishWallTableViewController.h"
#import "BrowseTableViewController.h"
#import "AccoutViewController.h"

#define UpdatedText @"Updated"

@interface AppDelegate()

-(BOOL)isNetworkAvaliable;
-(void)asyncRequestStartData;

-(BOOL)firstRunApp;
-(void)loadIntroductionViewController;

@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if (![self isNetworkAvaliable]) {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NetworkWarning", nil) message:NSLocalizedString(@"NetworkFailText", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OKText", nil)  otherButtonTitles: nil];
        [alertView show];
        return NO ;
    }
    
    if ([self firstRunApp]) {
        [self loadIntroductionViewController];
        return YES;
    }
   
    [self loadTabBarViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- IntroductionViewController delegate messages

-(void)introductionDidFinish:(UIViewController *)viewController{
    [self loadTabBarViewController];
   
}
#pragma mark -- private messsage
-(BOOL)isNetworkAvaliable{
    return([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable||
           [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]!=NotReachable);
}
-(void)asyncRequestStartData{
    NSString*requestUrlString=StartURLString;
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestUrlString]];
    request.delegate=self;
    [request startAsynchronous];
}
-(BOOL)firstRunApp{

    NSString*updText=[[NSUserDefaults standardUserDefaults]stringForKey:UpdateInfoShownKey];
    if (0==[updText length]) {
        
        return YES;
    }
    return NO;
}
-(void)loadTabBarViewController{
    NSArray*array=[self viewControllerArray];
    UITabBarController*tbvc=[[UITabBarController alloc]init];
    tbvc.viewControllers=array;
    self.window.rootViewController=tbvc;
}
-(void)loadIntroductionViewController{
    [[NSUserDefaults standardUserDefaults] setObject:UpdatedText forKey:UpdateInfoShownKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    IntroductionViewController*idvc=[[IntroductionViewController alloc]init];
    idvc.delegate=self;
    self.window.rootViewController=idvc;
    
    [idvc release];
}

-(NSArray*)viewControllerArray{
    NSMutableArray*resultArray=[[[NSMutableArray alloc]init]autorelease];
    WishWallTableViewController*wtvc=[[WishWallTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController*wishNavi=[[UINavigationController alloc]initWithRootViewController:wtvc];
    [wtvc release];
    [resultArray addObject:wishNavi];
    [wishNavi release];
    
    BrowseTableViewController*bwvc=[[BrowseTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController*browseNavi=[[UINavigationController alloc]initWithRootViewController:bwvc];
    [bwvc release];
    [resultArray addObject:browseNavi];
    [browseNavi release];
    
    AccoutViewController*acvc=[[AccoutViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController*accountNavi=[[UINavigationController alloc]initWithRootViewController:acvc];
    [acvc release];
    [resultArray addObject:accountNavi];
    [accountNavi release];
    return resultArray;
}

@end
