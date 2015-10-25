//
//  Responder.h
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 9. 17..
//  Copyright (c) 2015년 Bryan Boyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Responder : NSObject
- (void) connectCallBack: (NSString *) data;
- (void) connectLostCallBack: (NSString *) data;
- (void) onMessageArrivedCallBack: (NSString *) data;
- (void) disconnectCallBack: (NSString *) data;
- (void) subscribeCallBack: (NSString *) data;
- (void) unsubscribeCallBack: (NSString *) data;
//- (void) ackCallBack: (NSString *) data;
@end
