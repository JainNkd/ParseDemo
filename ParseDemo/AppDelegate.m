//
//  AppDelegate.m
//  ParseDemo
//
//  Created by Naveen Kumar Dungarwal on 6/17/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Parse
    [Parse setApplicationId:@""
                  clientKey:@""];
    
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    [[[UIAlertView alloc]initWithTitle:@"launchOptions" message:[NSString stringWithFormat:@"userInfo :%@",launchOptions] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
    
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        NSLog(@"AppDelegate didFinishLaunchingWithOptions");
        [[[UIAlertView alloc]initWithTitle:@"launchOptions" message:[NSString stringWithFormat:@"userInfo :%@",notification.userInfo] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
        [application setApplicationIconBadgeNumber:0];
//        [application cancelAllLocalNotifications];
        
        
    }


    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken *******");
    NSLog(@"My token is: %@", deviceToken);
    
    NSString *dToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dToken = [dToken stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    dToken = [dToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"STR: %@",dToken);

}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Error in registration. Error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [PFPush handlePush:userInfo];
    [[[UIAlertView alloc]initWithTitle:@"ReceiveRemoteNotification" message:[NSString stringWithFormat:@"userInfo :%@",userInfo] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    NSLog(@"didReceiveRemoteNotification fetchCompletionHandler **********************");
    NSLog(@"userInfo background: %@", userInfo);
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:@"IS_NOTIFICATION"];\
     [[[UIAlertView alloc]initWithTitle:@"UIBackgroundFetchResult" message:[NSString stringWithFormat:@"userInfo :%@",userInfo] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
    //    [CommonMethods showAlertWithTitle:@"LUK" message:@"New Video Reciceved from LUK"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSInteger count = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (count>0) {
        [[[UIAlertView alloc]initWithTitle:@"applicationWillEnterForeground" message:[NSString stringWithFormat:@"userInfo :%d",count] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:@"IS_NOTIFICATION"];
        

            //        [CommonMethods showAlertWithTitle:@"LUK" message:@"New Video Reciceved from LUK"];
    }
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[[UIAlertView alloc]initWithTitle:@"didbecomeactive" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
