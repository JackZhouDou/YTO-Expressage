//
//  AppDelegate.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "AppDelegate.h"
#import "CheckViewController.h"
#import "UserViewController.h"
#import "NearbyViewController.h"
#import "YSerViceViewController.h"
@interface AppDelegate ()
@property (nonatomic, copy) void (^block)(NSString *user);

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *barControler = [[UITabBarController alloc]init];
//    barControler.tabBar.barTintColor = [UIColor colorWithRed:91.0 / 255 green:189.0 / 255 blue:43.0 / 255 alpha:1];
    CheckViewController *checkView = [[CheckViewController alloc]init];
    
    
    
//    创建一个本地存储字符串；
//    static dispatch_once_t once_token;
//    dispatch_once(&once_token, ^{
//        
//        NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
//        if (dic) {
//            [dic setObject:@"chaince" forKey:@"languge"];
//            [dic synchronize];
//        }
//        
//        NSLog(@"dskj");
//    });
    

    
    
//    创建一个通知者中心；
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(BlockUser:) name:@"change" object:nil];
    
    
    
    
    
    UINavigationController *checkBar = [[UINavigationController alloc]initWithRootViewController:checkView];

    
    
    
    
   
    UIImage *imageCheck =[UIImage imageNamed:@"checke1"];
    imageCheck = [imageCheck imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageCheck1 = [UIImage imageNamed:@"checke2"];
    imageCheck1 = [imageCheck1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    checkBar.tabBarItem.image = imageCheck;
    
    checkBar.tabBarItem.selectedImage = imageCheck1;
    
//    checkView.view.backgroundColor  = [UIColor blackColor];
//    checkBar.tabBarItem.selectedImage = [UIImage imageWithCGImage:@""];
    
    
    NearbyViewController *nearby = [[NearbyViewController alloc]init];
    UINavigationController *nearbyBar = [[UINavigationController alloc]initWithRootViewController:nearby];
    
    
    UIImage *imageNearby = [UIImage imageNamed:@"nearby"];
    imageNearby = [imageNearby imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageNearby1 = [UIImage imageNamed:@"nearby1"];
    imageNearby1 = [imageNearby1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    nearbyBar.tabBarItem.image = imageNearby;
    nearbyBar.tabBarItem.selectedImage = imageNearby1;
    
    
    
    
    
    
    
    UserViewController *userView = [[UserViewController alloc]init];
    UINavigationController *userBar = [[UINavigationController alloc]initWithRootViewController:userView];
    
    UIImage *imageUser = [UIImage imageNamed:@"user"];
    imageUser = [imageUser imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageUser1 = [UIImage imageNamed:@"user1"];
    imageUser1 = [imageUser1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    userBar.tabBarItem.image = imageUser;
    userBar.tabBarItem.selectedImage = imageUser1;
//    userBar.toolbar.tintColor = [UIColor colorWithRed:240.0 / 255 green:188.0 / 255 blue:9.0 / 255 alpha:1];
    
    
    
    
    YSerViceViewController *serviceView = [[YSerViceViewController alloc]init];
    
    UINavigationController *serviceBar = [[UINavigationController alloc]initWithRootViewController:serviceView];
    
   
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
             checkBar.title = @"查";
            userBar.title = @"管理";
            nearbyBar.title = @"附近";
            serviceBar.title = @"服务";
        } else {
            checkBar.title = @"Check";
            userBar.title = @"Manager";
            nearbyBar.title = @"Nearby";
            serviceBar.title = @"Service";
            
            
        }
        
    };
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    block([dic objectForKey:@"languge"]);
    
    self.block = block;
    
    
    
    UIImage *serImage = [UIImage imageNamed:@"service"];
    serImage = [serImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceBar.tabBarItem.image =serImage;
    
    UIImage *serImage1 = [UIImage imageNamed:@"service1"];
   serImage1 =  [serImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceBar.tabBarItem.selectedImage = serImage1;
    
    
    barControler.viewControllers = @[checkBar, nearbyBar, serviceBar, userBar];
    
    
    
    
    
    
    self.window.rootViewController = barControler;
    
    return YES;
}


- (void)BlockUser:(NSNotification *)noi{
    self.block(noi.object);
    
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   
}


@end
