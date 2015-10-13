//
//  Responder.m
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 9. 17..
//  Copyright (c) 2015년 Bryan Boyd. All rights reserved.
//

#import "Responder.h"


@implementation Responder
- (void) connectCallBack: (NSString *) data ;
{
    NSLog(@"test1: %@.\n", data);
//    NSLog(@"test2: %d.\n", errorCode);
    
//    return self;
}

- (void) connectLostCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) onMessageArrivedCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) disconnectCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
//    return self;
}

- (void) subscribeCallBack: (NSString *) data
{
    NSLog(@"Responder.my_callback called with greeting: %@.\n", data);
    
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