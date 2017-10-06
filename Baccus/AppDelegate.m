//
//  AppDelegate.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 03/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import "SQAWineViewController.h"
#import "SQAWebViewController.h"
#import "SQAWineModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIImage* photo = [UIImage imageNamed:@"bembibre.jpg"];
    
    // Creamos un modelo
    SQAWineModel *tintorro = [SQAWineModel wineWithName:@"Bembibre"
                                                   type:@"tinto"
                                                  photo:photo
                                        wineCompanyName:@"Dominio de Tares"
                                         wineCompanyWeb:[NSURL URLWithString:@"https://www.dominiodetares.com/index.php/es/vinos/baltos/74-bembibrevinos"]
                                                  notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                                 origin:@"El Bierzo"
                                                 rating:5
                                                 grapes:@[@"Mencía"]];
    
    // Creamos una UIWindows
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SQAWineViewController *wineVC = [[SQAWineViewController alloc] initWithModel:tintorro];
    //SQAWebViewController *webVC = [[SQAWebViewController alloc] initWithModel:tintorro];
    
    // Creamos el combinador
    // - UITabBarController
    //UITabBarController *tabVC = [[UITabBarController alloc] init];
    //tabVC.viewControllers = @[ wineVC, webVC ];
    
    // - UINavigationViewController
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    self.window.rootViewController = navVC;
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
