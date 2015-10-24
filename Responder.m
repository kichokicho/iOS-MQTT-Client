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
    NSData *jData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    
    if ([json[@"code"] intValue] == 302200 ) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate updateConnectButton];
    }
    
    
//    NSLog(@"test2: %d.\n", errorCode);
    
//    return self;
}

- (void) connectLostCallBack: (NSString *) data
{
    NSLog(@"connectLostCallBack data: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate updateConnectButton];
        [appDelegate reloadSubscriptionList];
    
//    return self;
}

- (void) onMessageArrivedCallBack: (NSString *) data
{
    NSLog(@"onMessageArrivedCallBack data: %@.\n", data);
    NSData *jData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    
    
//    NSDate *todate = [NSDate date];
    int timestamp = [[NSDate date] timeIntervalSince1970];
    [[ADFPush sharedADFPush] callAck:json[@"msgId"] ackTime:timestamp jobId: [json[@"jobId"] intValue]];

}

- (void) disconnectCallBack: (NSString *) data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate updateConnectButton];

    NSLog(@"disconnectCallBack data: %@.\n", data);
    
//    return self;
}

- (void) subscribeCallBack: (NSString *) data
{
    NSLog(@"subscribeCallBack data: %@.\n", data);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate reloadSubscriptionList];
    
//    return self;
}

- (void) unsubscribeCallBack: (NSString *) data
{
    NSLog(@"unsubscribeCallBack data: %@.\n", data);
    
//    return self;
}

//- (void) ackCallBack: (NSString *) data
//{
//    NSLog(@"ackCallBack data: %@.\n", data);
//    
////    return self;
//}

@end