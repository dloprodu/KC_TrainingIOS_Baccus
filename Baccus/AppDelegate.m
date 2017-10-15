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
    [self customiseAppeareance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Creamos una UIWindows
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SQAWineryModel *winery = [[SQAWineryModel alloc] init];
    
    SQAWineryTableViewController *wineryVC = [[SQAWineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain];
        
    SQAWineViewController *wineVC = [[SQAWineViewController alloc] initWithModel:nil];
        
    UINavigationController *masterVC = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    UINavigationController *detailVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    // Creamos el controlador
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    [splitVC setViewControllers:@[masterVC, detailVC]];
    
    // Delegates
    [wineryVC setDelegate:wineVC];
    [splitVC setDelegate:wineryVC];
    
    self.window.rootViewController = splitVC;
    [self.window makeKeyAndVisible];
    
    [winery load];
    
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

- (void)customiseAppeareance {
    UIColor *oldBurgundy = [UIColor colorWithRed:0.26
                                           green:0.19
                                            blue:0.18
                                           alpha:1.0];
    
    if (IS_PHONE) {
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBackgroundPortrait.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2) resizingMode: UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBackgroundLandscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2) resizingMode: UIImageResizingModeStretch] forBarMetrics:UIBarMetricsCompact];
    }
    else {
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBackgroundPortraitiPad.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2) resizingMode: UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navBarBackgroundLandscapeiPad.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2) resizingMode: UIImageResizingModeStretch] forBarMetrics:UIBarMetricsCompact];
    }
    
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Valentina-Regular" size:20]}];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Valentina-Regular" size:12]} forState:UIControlStateNormal];
    
    // Color de los separadores de sección en las las tablas
    [[UITableViewHeaderFooterView appearance] setTintColor:oldBurgundy];
    
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setTextColor:[UIColor whiteColor]];
    
    // Botón de hacia atrás con la Elasticina del Profesor Saturnino Bacterio
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"backBtn"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];
}

@end
