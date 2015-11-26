//
//  Responder.m
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 9. 17..
//  Copyright (c) 2015년 Bryan Boyd. All rights reserved.
//

#import "Responder.h"
#import "AppDelegate.h"
#import "ADFPush.h"


@implementation Responder
- (void) connectCallBack: (NSString *) data ;
{
    NSLog(@"test1: %@.\n", data);
   
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultConnectView:data];
    
    
}


- (void) connectLostCallBack: (NSString *) data
{
    NSLog(@"connectLostCallBack data: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultConnectView:data];

}

- (void) onMessageArrivedCallBack: (NSString *) data
{
    NSLog(@"onMessageArrivedCallBack data: %@.\n", data);
    NSData *jData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultConnectView:data];
//    NSDate *todate = [NSDate date];
    int timestamp = [[NSDate date] timeIntervalSince1970];
    [[ADFPush sharedADFPush] callAck:json[@"msgId"] ackTime:timestamp jobId: [json[@"jobId"] intValue]];

}

- (void) disconnectCallBack: (NSString *) data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultConnectView:data];

    NSLog(@"disconnectCallBack data: %@.\n", data);
    
//    return self;
}

- (void) subscribeCallBack: (NSString *) data
{
    NSLog(@"subscribeCallBack data: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate reloadSubscriptionList];
    [appDelegate resultSubscribeView:data];
    
//    return self;
}

- (void) unsubscribeCallBack: (NSString *) data
{
    NSLog(@"unsubscribeCallBack data: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultSubscribeView:data];
//    return self;
}

- (void) getSubscriptionsCallBack: (NSString *) data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resultGetSubscriptionsView:data];
    NSLog(@"getSubscriptionsCallBack data: %@.\n", data);
    

}

@end