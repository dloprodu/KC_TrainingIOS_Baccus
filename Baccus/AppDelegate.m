//
//  AppDelegate.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 03/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import "SQAWineryTableViewController.h"
#import "SQAWineViewController.h"
#import "SQAWineryModel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Creamos una UIWindows
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SQAWineryModel *model = [[SQAWineryModel alloc] init];
    
    SQAWineryTableViewController *wineryVC = [[SQAWineryTableViewController alloc] initWithModel:model style:UITableViewStylePlain];
    SQAWineViewController *wineVC = [[SQAWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    
    UINavigationController *sideVC = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    sideVC.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    sideVC.navigationBar.backgroundColor = [UIColor colorWithRed:0.5
                                                          green:0
                                                           blue:0.13
                                                          alpha:1];
    UINavigationController *mainVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    mainVC.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    mainVC.navigationBar.backgroundColor = [UIColor colorWithRed:0.5
                                                          green:0
                                                           blue:0.13
                                                          alpha:1];
    

    [wineryVC setDelegate:wineVC];
    
    // Creamos el controlador
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    [splitVC setViewControllers:@[sideVC, mainVC]];
    
    [splitVC setDelegate:wineVC];
    [splitVC setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
    
    self.window.rootViewController = splitVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
