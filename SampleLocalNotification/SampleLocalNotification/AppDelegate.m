//
//  AppDelegate.m
//  SampleLocalNotification
//
//  Created by Hunter Peterson on 5/23/16.
//  Copyright © 2016 adobe. All rights reserved.
//

#import "AppDelegate.h"
#import "ADBMobile.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /* 
     Adobe - Collect lifecycle data
     */
    [ADBMobile setDebugLogging:YES];
    [ADBMobile collectLifecycleData];
    
    // configure notification settings
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert)
                                                                             categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    
    return YES;
}

#pragma mark - Local Notification handlers
- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification {
    [self handleLocalNotification:notification];
}

- (void) handleLocalNotification:(UILocalNotification *)notification {
    if (notification) {
        /*
         Adobe - Track local notification click through event
         */
        [ADBMobile trackLocalNotificationClickThrough:notification.userInfo];
        
        // handle local notification link
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:notification.userInfo[@"adb_deeplink"]]];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    
    return YES;
}
@end
