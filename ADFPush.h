//
//  ADFPush.h
//  ADFPush
//
//  Created by gwangil on 2015. 9. 7..
//  Copyright (c) 2015년 kamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MqttOCClient.h"
#import <AVFoundation/AVFoundation.h>
#import "QueueFile.h"



@interface ADFPush : NSObject {
    MqttClient *client;
}

@property (nonatomic, retain) MqttClient *client;
@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *userID;


///[sk]
@property (nonatomic, retain) id Responder;
@property (nonatomic, strong) QueueFile *jobQF;
@property (nonatomic, strong) QueueFile *jobLogQF;
@property (nonatomic, retain) NSString *messageADF;
///[sk]


+ (id)sharedADFPush;
- (void)publish:(NSString *)topic payload:(NSString *)payload qos:(int)qos retained:(BOOL)retained;
- (void)subscribeMQTT:(NSString *)topicFilter qos:(int)qos;
- (void)unsubscribeMQTT:(NSString *)topicFilter;
- (void)disconnectMQTT:(int)timeout;
- (void)connectMQTT:(NSArray *)hosts ports:(NSArray *)ports cleanSession:(BOOL)cleanSession;
- (NSString *)registerToken:(NSString *)token;
- (NSString *)getTokenMQTT;
- (NSString *)connectStateMQTT;
- (NSString *)cleanJobQueue;
- (NSString *)getSubscriptions;



@end

