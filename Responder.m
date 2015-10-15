//
//  Responder.m
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 9. 17..
//  Copyright (c) 2015년 Bryan Boyd. All rights reserved.
//

#import "Responder.h"
#import "AppDelegate.h"


@implementation Responder
- (void) connectCallBack: (NSString *) data ;
{
    NSLog(@"test1: %@.\n", data);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate updateConnectButton];
//    NSLog(@"test2: %d.\n", errorCode);
    
//    return self;
}

- (void) connectLostCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate updateConnectButton];
        [appDelegate reloadSubscriptionList];
    
//    return self;
}

- (void) onMessageArrivedCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) disconnectCallBack: (NSString *) data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate updateConnectButton];

    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) subscribeCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate reloadSubscriptionList];
    
//    return self;
}

- (void) unsubscribeCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) ackCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

@end