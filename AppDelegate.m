//
//  AppDelegate.m
//  MQTTTest
//
//  Created by Bryan Boyd on 12/5/13.
//  Copyright (c) 2013 Bryan Boyd. All rights reserved.
//

#import "AppDelegate.h"
#import "ADFPush.h"
#import "Responder.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Responder * res = [[Responder alloc] init];
    [[ADFPush sharedADFPush] setResponder:res];
//    NSString *clientID = @"fff9e7cec59c4e4fb2b70c6";
//    NSString *clientID = @"640095551c223b18b384311";
//    NSString * result = [[ADFPush sharedADFPush] registerToken:clientID];
    
    self.tabBar = (UITabBarController *)self.window.rootViewController;
    return YES;
}

- (void)switchToConnect
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:0];
}

- (void)switchToPublish
{
    // TODO: can't do this from a callback
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:1];
}

- (void)switchToSubscribe
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:2];
}

- (void)switchToLog
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:3];
}

- (void)clearLog
{
//    ADFLib *ADFLib = [ADFLib sharedADFLib];
//    [ADFLib clearLog];
    [self reloadLog];
}

- (void)reloadLog
{
    // must do this on the main thread, since we are updating the UI
    dispatch_async(dispatch_get_main_queue(), ^{
//        ADFLib *ADFLib = [ADFLib sharedADFLib];
//        NSString *badge = [NSString stringWithFormat:@"%lu", (unsigned long)[ADFLib.logMessages count]];
//        if ([badge isEqualToString:@"0"]) {
//            badge = nil;
//        }
//        self.logView.navigationController.tabBarItem.badgeValue = badge;
//        
        [self.logView.tableView reloadData];
    });
}

- (void)updateConnectButton
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *currentTitle = [[[self connectView] connectButton] currentTitle];
        if ([currentTitle isEqualToString:@"Connect"]) {
            [[[self connectView] connectButton] setTitle:@"Disconnect" forState:UIControlStateNormal];
        } else {
            [[[self connectView] connectButton] setTitle:@"Connect" forState:UIControlStateNormal];
        }
    });
}

- (void)reloadSubscriptionList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subListView reloadData];
    });
}

- (void)resultConnectView:(NSString *)setResultText
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.connectView setResultText:setResultText];
    });
}

- (void)resultSubscribeView:(NSString *)setResultText
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subscribeView setResultText:setResultText];
    });
}

- (void)resultGetSubscriptionsView:(NSString *)setResultText
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.commandView setResultText:setResultText];
    });
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
//    NSArray *servers = [[NSArray alloc] initWithObjects:@"adflow.net", nil];
//    NSArray *ports = [[NSArray alloc] initWithObjects:@"2883", nil];
    
    
//    [[ADFLib sharedADFLib] connectWithHosts:servers ports:ports clientId:clientID cleanSession:TRUE];
    [[ADFPush sharedADFPush] connectMQTT];
    
    NSLog(@"mqtt connect ");
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

@end
