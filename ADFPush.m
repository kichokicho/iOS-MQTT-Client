//
//  ADFPush.m
//  ADFPush
//
//  Created by gwangil on 2015. 9. 7..
//  Copyright (c) 2015년 kamy. All rights reserved.
//

#import "ADFPush.h"
//#import "JobBean.h"


@interface ADFPushEnv : NSObject

@property (nonatomic, retain) NSArray *hosts;
@property (nonatomic, retain) NSArray *posts;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *topic;
@property (nonatomic, retain) NSString *adfPushServerUrl;
@property int mqttKeepAliveInterval;

@end

@implementation ADFPushEnv

@synthesize hosts;
@synthesize posts;
@synthesize token;
@synthesize topic;
@synthesize adfPushServerUrl;
@synthesize mqttKeepAliveInterval;

@end



// Connect Callbacks
@interface ConnectCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation ConnectCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
    
    [[ADFPush sharedADFPush] setLoginMQTT:true];
    NSString *tempMethord = @"connectCallBack:";
    NSString *result = @"{\"status\": \"ok\",\"code\": 302200,\"message\": \"MQTT 서버에 접속이 되었습니다.\"}";
    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}


- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"- invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    NSString *tempMethord = @"connectCallBack:";
    
    NSString *result = nil;
    if (errorCode == 5) {
        result = @"{\"status\": \"fail\",\"code\": 302405,\"message\": \"MQTT 서버에 유요하지 않은 토큰으로 접속을 시도 했습니다.\"}";
    } else {
        result = @"{\"status\": \"fail\",\"code\": 302400,\"message\": \"MQTT 서버에 접속이 실패 되었습니다.\"}";
    }
    
    [[ADFPush sharedADFPush] addJobLog:@"ConnectCallbacks" param1:@"onFailure" param2:@"" jsonYn:true data:result jogTypeError: true];

    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}


@end

NSData *dataForString(NSString *text)
{
    const char *s = [text UTF8String];
    return [NSData dataWithBytes:s length:strlen(s) + 1];
}


// disConnect Callbacks
@interface DisConnectCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation DisConnectCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
//    NSLog(@"- invocationContext=%@", invocationContext);
    
    [[ADFPush sharedADFPush] setLoginMQTT:false];
    
    NSString *tempMethord = @"disconnectCallBack:";
    NSString *result = @"{\"status\": \"ok\",\"code\": 303200,\"message\": \"MQTT 서버에 접속종료가 완료 되었습니다.\"}";
    
    
    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
    
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"- invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    NSString *tempMethord = @"disconnectCallBack:";
    
    NSString *result = @"{\"status\": \"fail\",\"code\": 303400,\"message\": \"MQTT 서버에 접속종료가 실패되었습니다\"}";
    
    [[ADFPush sharedADFPush] addJobLog:@"disconnectCallBack" param1:@"onFailure" param2:@"" jsonYn:true data:result jogTypeError: true];
    
    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}
@end

// Publish Callbacks
@interface PublishCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage;
@end
@implementation PublishCallbacks
- (void) onSuccess:(NSObject *) invocationContext
{
    NSLog(@"PublishCallbacks - onSuccess, invocationContext:%@", invocationContext);
}
- (void) onFailure:(NSObject *) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage
{
    NSLog(@"PublishCallbacks - onFailure");
}
@end

// ack Callbacks
//@interface AckCallbacks : NSObject <InvocationComplete>
//- (void) onSuccess:(NSObject*) invocationContext;
//- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage;
//@end
//@implementation AckCallbacks
//- (void) onSuccess:(NSObject *) invocationContext
//{
//    NSLog(@"AckCallbacks - onSuccess, invocationContext:%@", invocationContext);
//    NSString *tempMethord = @"ackCallBack:";
//    
//    NSString *result = @"{\"status\": \"ok\",\"code\": 309200,\"message\": \"수신확인 메세지 전달이 완료 되었습니다.\"}";
//    
//    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
//}
//- (void) onFailure:(NSObject *) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage
//{
//    NSLog(@"-AckCallbacks  invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
//    NSString *tempMethord = @"ackCallBack:";
//    
//    NSString *result = @"{\"status\": \"fail\",\"code\": 309400,\"message\": \"수신확인 메세지 전달이 실패 했습니다\"}";
//    
//    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
//
//}
//@end

// agent Ack Callbacks
@interface AgentAckCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage;
@end
@implementation AgentAckCallbacks
- (void) onSuccess:(NSObject *) invocationContext
{
    
    NSLog(@"AgentAckCallbacks - onSuccess, invocationContext:%@", invocationContext);
    [[ADFPush sharedADFPush] setMessageADF:@"AckCallbackOK"];
    
}
- (void) onFailure:(NSObject *) invocationContext errorCode:(int) errorCode errorMessage:(NSString *)errorMessage
{
    NSLog(@"AgentAckCallbacks  invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    [[ADFPush sharedADFPush] addJobLog:@"AgentAckCallbacks" param1:@"onFailure" param2:@"" jsonYn:false data:errorMessage  jogTypeError: true];
    [[ADFPush sharedADFPush] setMessageADF:@"AckCallbackFail"];
}
@end


// Subscribe Callbacks
@interface SubscribeCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation SubscribeCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
//    NSLog(@"- invocationContext=%@", invocationContext);

    NSString *tempMethord = @"subscribeCallBack:";
    NSString * result = [NSString stringWithFormat:@"{\"status\": \"ok\",\"code\": 305200,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독신청이 완료되었습니다\"}",invocationContext];
    
    
    if ([[ADFPush sharedADFPush] AUTOSUBSCRIBE]) {
        
        [[[ADFPush sharedADFPush] autoSubscribeAgentTimer] invalidate];
        [[ADFPush sharedADFPush] setAutoSubscribeAgentTimer:nil];
        [[ADFPush sharedADFPush] setAUTOSUBSCRIBE:false];
        
         NSLog(@"- autoSubscribeAgentTimer stop");
        
        //// adfEnv 수정하여 저장.
        QueueFile * adfEnv = [ [ADFPush sharedADFPush] adfEnv];
        NSString *envJson;
        
        NSString *adfEnvJson = [NSString stringWithUTF8String:[[adfEnv peek] bytes]];
        NSData *jData = [adfEnvJson dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        [jsonDic removeObjectForKey:@"autoSubscribe"];
        [jsonDic setObject:[NSNumber numberWithBool:NO] forKey:@"autoSubscribe"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
        envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [adfEnv clear];
        [adfEnv add:dataForString(envJson)];
    }

    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
    
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
     NSLog(@"[ADFPush] SubscribeCallbacks - invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    
    NSString *tempMethord = @"subscribeCallBack:";
    NSString * result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 305400,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독신청이 실패했습니다\"}",invocationContext];
    
    [[ADFPush sharedADFPush] addJobLog:@"SubscribeCallbacks" param1:@"onFailure" param2:@"" jsonYn:true data:result jogTypeError: true];

    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}
@end

// Unsubscribe Callbacks
@interface UnsubscribeCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation UnsubscribeCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
    NSString *tempMethord = @"unsubscribeCallBack:";
    NSString * result = [NSString stringWithFormat:@"{\"status\": \"ok\",\"code\": 306200,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독해제가 완료되었습니다\"}",invocationContext];
    
    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"[ADFPush] UnsubscribeCallbacks - invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    NSString *tempMethord = @"subscribeCallBack:";
    NSString * result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 306400,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독해제가 실패했습니다\"}",invocationContext];
    
    [[ADFPush sharedADFPush] addJobLog:@"UnsubscribeCallbacks" param1:@"onFailure" param2:@"" jsonYn:true data:result jogTypeError: true];
    
    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}




@end

@interface GeneralCallbacks : NSObject <MqttCallbacks>
- (void) onConnectionLost:(NSObject*)invocationContext errorMessage:(NSString*)errorMessage;
- (void) onMessageArrived:(NSObject*)invocationContext message:(MqttMessage*)msg;
- (void) onMessageDelivered:(NSObject*)invocationContext messageId:(int)msgId;
@end
@implementation GeneralCallbacks
- (void) onConnectionLost:(NSObject*)invocationContext errorMessage:(NSString*)errorMessage
{
//    NSString *tempMethord = @"connectLostCallBack:";
//    NSString *result = @"{\"status\": \"fail\",\"code\": 302401,\"message\": \"MQTT 연결이 끊어졌습니다\"}";
//    
//    [[ADFPush sharedADFPush] addJobLog:@"GeneralCallbacks" param1:@"onConnectionLost" param2:@"" jsonYn:true data:result jogTypeError: true];
//    
//    [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
}
- (void) onMessageArrived:(NSObject*)invocationContext message:(MqttMessage*)msg
{
    
    @try {
        int qos = msg.qos;
        
        NSString *payload = [[NSString alloc] initWithBytes:msg.payload length:msg.payloadLength encoding:NSUTF8StringEncoding];
        NSString *topic = msg.destinationName;
        
//            BOOL retained = msg.retained;
//            NSString *retainedStr = retained ? @" [retained]" : @"";
//            NSString *logStr = [NSString stringWithFormat:@"[%@ QoS:%d] %@%@", topic, qos, payload, retainedStr];
//            NSLog(@"- %@", logStr);
            NSLog(@"GeneralCallbacks - onMessageArrived!");
    
        PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
        JobBean *job;
        JobBean *job2;

        NSData *jData = [payload dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    
        [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:@"onMessageArrived" param2:json[@"msgId"] jsonYn:true data:payload jogTypeError: false];

        NSString *tempMethord;
        NSString *result;
        int timestamp;
        NSString *content;
        int jobId;

        
        //// 필수 값 체크
        if (json[@"msgType"] == nil) {
            NSLog(@"[ADFPush] MessageArrived - ERROR : onMessageArrived msgType=nil Error\n");
            [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"onMessageArrived msgType=nil Error" param2:@"" jsonYn:true data:payload jogTypeError: true];
            return;
        } else if (json[@"msgId"] == nil) {
             NSLog(@"[ADFPush] MessageArrived - ERROR : onMessageArrived msgId=nil Error\n");
            [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"onMessageArrived msgId=nil Error" param2:@"" jsonYn:true data:payload jogTypeError: true];
            return;
        } else if (json[@"content"] == nil) {
             NSLog(@"[ADFPush] MessageArrived - ERROR : onMessageArrived content=nil Error\n");
            [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"onMessageArrived content=nil Error" param2:@"" jsonYn:true data:payload jogTypeError: true];
            return;
        }
        
        
        int msgType = [json[@"msgType"] intValue];
        
        // Agent Ack send
        NSLog(@"job.ack : %d",[json[@"ack"] intValue]);
        if ([json[@"ack"] intValue] > 0) {
            
            // job Table - agent ack insert
            timestamp = [[NSDate date] timeIntervalSince1970];
            job2 = [[JobBean alloc]init];
            [job2 setMsgType:300];
            [job2 setAck:[json[@"ack"] intValue]];
            [job2 setQos:qos];
            [job2 setContent:@""];
            [job2 setMsgId:json[@"msgId"]];
            [job2 setContentType:json[@"contentType"]];
            [job2 setTopic:topic];
            [job2 setServiceId:json[@"serviceId"]];
            [job2 setIssueTime:timestamp];
            
            [pushDataDB insertJob:job2];
        }
//
        switch (msgType) {
            case 100:
//
//                //일반 메세지 DB 저장
                job = [[JobBean alloc]init];

                timestamp = [[NSDate date] timeIntervalSince1970];
                
                [job setMsgType:[json[@"msgType"] intValue]];
                [job setAck:[json[@"ack"] intValue]];
                [job setQos:qos];
                [job setContent:json[@"content"]];
                [job setMsgId:json[@"msgId"]];
                [job setContentType:json[@"contentType"]];
                [job setTopic:topic];
                [job setServiceId:json[@"serviceId"]];
                [job setIssueTime:timestamp];
                
                
                jobId = [pushDataDB insertJob:job];
                
                if (jobId == -1) {
                    NSLog(@"[ADFPush] MessageArrived - ERROR : insert Job Error \n");
                    [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"MessageArrived insert Job Error" param2:@"" jsonYn:true data:payload jogTypeError: true];
                    return;
                }

                
                // onMessageArrivedCallBack Call
                tempMethord = @"onMessageArrivedCallBack:";
                result = [NSString stringWithFormat:@"{\"content\": \"%@\",\"msgId\":\"%@\",\"contentType\":\"%@\",\"topic\":\"%@\",\"qos\":%d,\"jobId\":%d}",job.content,job.msgId, job.contentType, job.topic, job.qos, jobId];
                
                //
                [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:@"MessageDelivery" param2:json[@"msgId"] jsonYn:false data:@"" jogTypeError: false];
                [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
                break;
                
            case 200:

                //mqttKeepAliveInterval setting
                job = [[JobBean alloc]init];
                
                timestamp = [[NSDate date] timeIntervalSince1970];
                [job setMsgType:[json[@"msgType"] intValue]];
                //            [job setAck:[json[@"ack"] intValue]];
                [job setQos:qos];
                content = [NSString stringWithFormat:@"{\"keepAliveTime\":%d}",[json[@"content"][@"keepAliveTime"]intValue]];
                [job setContent:content];
                [job setMsgId:json[@"msgId"]];
                [job setContentType:json[@"contentType"]];
                [job setTopic:topic];
                [job setServiceId:json[@"serviceId"]];
                [job setIssueTime:timestamp];
                
                [pushDataDB insertJob:job];
                
                break;
            case 201:
                
                //mqttKeepAliveInterval setting
                job = [[JobBean alloc]init];
                
                timestamp = [[NSDate date] timeIntervalSince1970];
                [job setMsgType:[json[@"msgType"] intValue]];
                [job setQos:qos];
                content = [NSString stringWithFormat:@"{\"hostUrl\":\"%@\"}",json[@"content"][@"hostInfo"]];
                [job setContent:content];
                [job setMsgId:json[@"msgId"]];
                [job setContentType:json[@"contentType"]];
                [job setTopic:topic];
                [job setServiceId:json[@"serviceId"]];
                [job setIssueTime:timestamp];
                
                [pushDataDB insertJob:job];
                
                break;
                
            case 202:
                
                //echo ack
                job = [[JobBean alloc]init];
                
                timestamp = [[NSDate date] timeIntervalSince1970];
                [job setMsgType:[json[@"msgType"] intValue]];
                [job setQos:qos];
                [job setContent:@""];
                [job setMsgId:json[@"msgId"]];
                [job setContentType:@""];
                [job setTopic:topic];
                [job setServiceId:@""];
                [job setIssueTime:timestamp];
                
                [pushDataDB insertJob:job];
                
                break;
                
            default:
                [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"onMessageArrived msgType Error" param2:@"" jsonYn:true data:payload jogTypeError: true];
                break;
        }
//
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] connectMQTT - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"connectMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

}


- (void) onMessageDelivered:(NSObject*)invocationContext messageId:(int)msgId
{
//    NSLog(@"GeneralCallbacks - onMessageDelivered!, messageID:%d", msgId);
}


- (NSDictionary *)jSonToObject:(NSString *)jSonData
{
    
    NSData *jData = [jSonData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    
    return json;
}
- (NSString *)objectToJSon:(NSDictionary *)jObjectData
{
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jObjectData options:0 error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end





////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//////////////////   ADFPUSH   /////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


@implementation ADFPush
@synthesize client;

static float JOBINTERVAL = 10.0f;
NSArray *MQTTHOSTS;
NSArray *MQTTPORTS;
NSString *MQTTTOKEN;
NSString *ADFPUSHHOST;
bool CLEANSESSION;
int MQTTKEEPALIVEINTERVAL;
//bool AUTOSUBSCRIBE;
//
//NSTimer *autoSubscribeAgentTimer = nil;


#pragma mark Singleton Methods

+ (id)sharedADFPush {
    static ADFPush *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init {
    if (self = [super init]) {
        self.client = [MqttClient alloc];
        self.clientId = nil;
        self.loginMQTT = nil;
        self.Responder = nil;
        self.client.callbacks = [[GeneralCallbacks alloc] init];
        self.pushDataDB = [[PushDataBase alloc]init];
        [self.pushDataDB initWithDataBase];
        self.autoSubscribeAgentTimer = nil;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath =
        [documentsDirectory stringByAppendingPathComponent:@"adfEvn.q"];

        self.adfEnv = [QueueFile queueFileWithPath:filePath];

        
        if ([self.adfEnv size] > 0) {
            
            NSString *adfEnvJson = [NSString stringWithUTF8String:[[self.adfEnv peek] bytes]];
            NSData *jData = [adfEnvJson dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"====== adfEnvJson :: %@", adfEnvJson);
//            NSLog(@"====== CLEANSESSION44444 :: %@",json[@"cleanSesstion"]);
            
            MQTTHOSTS = json[@"hosts"];
            MQTTPORTS = json[@"ports"];
            CLEANSESSION = [json[@"cleanSesstion"]boolValue];
            MQTTTOKEN = json[@"token"];
            ADFPUSHHOST = json[@"adfPushServerUrl"];
            MQTTKEEPALIVEINTERVAL = [json[@"mqttKeepAliveInterval"] intValue];
            self.AUTOSUBSCRIBE = [json[@"autoSubscribe"]boolValue];
            NSLog(@"====== AUTOSUBSCRIBE :: %@", (self.AUTOSUBSCRIBE)? @"true" : @"false");
//
//            NSLog(@"====== MQTTHOSTS :: %@, MQTTPORTS :: %@,CLEANSESSION :: %@,MQTTTOKEN :: %@,ADFPUSHHOST :: %@,",MQTTHOSTS, MQTTPORTS,  (CLEANSESSION)? @"true" : @"false", MQTTTOKEN, ADFPUSHHOST);
            
        } else {
            
            MQTTHOSTS = nil;
            MQTTPORTS = nil;
            MQTTTOKEN = nil;
            ADFPUSHHOST = nil;
            MQTTKEEPALIVEINTERVAL = 30;
            CLEANSESSION = false;
            self.AUTOSUBSCRIBE = true;
            NSLog(@"====== CLEANSESSION22222 :: %@", (CLEANSESSION)? @"true" : @"false");
        }

        // Transaction log
        filePath = [documentsDirectory stringByAppendingPathComponent:@"adfTranLog.q"];
        self.adfTranLogQF = [QueueFile queueFileWithPath:filePath];
        // Error log
        filePath = [documentsDirectory stringByAppendingPathComponent:@"adfErrorLog.q"];
        self.adfErrorLogQF = [QueueFile queueFileWithPath:filePath];
        
        self.messageADF = nil;
        
        
        
        //Job Background loop run
        [NSTimer scheduledTimerWithTimeInterval:JOBINTERVAL target:self selector:@selector(jobAgent) userInfo:nil repeats:YES];
//        //autoSubscribeAgentTimer Background loop run
//        self.autoSubscribeAgentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoSubscribe) userInfo:nil repeats:YES];
        
        
        NSLog(@"============   Background start");
        
    }
    return self;
}


/// 자동으로 subscribe 함, 자동 상황이므로 subscribeMQTT(), unsubscribeMQTT()은 추가 로직 생각안함.
-(void) autoSubscribe {
    NSLog(@"bbbbbbbb");
    MqttClient *mClient = [[ADFPush sharedADFPush] client];
    if (self.AUTOSUBSCRIBE) {
        NSLog(@"====== AUTOSUBSCRIBE :: %@", (self.AUTOSUBSCRIBE)? @"true" : @"false");
        if (MQTTTOKEN != nil && [mClient isConnected]) {
            [[ADFPush sharedADFPush] subscribeMQTT:[NSString stringWithFormat:@"users/%@",MQTTTOKEN] qos:2];
        }
        
    } else {
        [self.autoSubscribeAgentTimer invalidate];
        self.autoSubscribeAgentTimer = nil;
    }
}


- (void)connectMQTT
{
    @try {
         //Job Logging
        if (MQTTHOSTS.count > 0 && MQTTPORTS.count >0) {
            [[ADFPush sharedADFPush] addJobLog:@"connectMQTT" param1:MQTTHOSTS[0] param2:MQTTPORTS[0] jsonYn:false data:(CLEANSESSION)? @"true" : @"false" jogTypeError: false];
        }
        
        if (MQTTHOSTS == nil || MQTTPORTS == nil || MQTTTOKEN == nil) {
            
            NSString *result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 302402,\"message\": \"호스트=%@, 포트=%@ 또는 토큰=%@이 유효하지 않습니다.\"}", MQTTHOSTS, MQTTPORTS, MQTTTOKEN];
            NSString *tempMethord = @"connectCallBack:";
            
            [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
            return;
        }
        

        NSLog(@"====== MQTTTOKEN :: %@", MQTTTOKEN);
        NSLog(@"====== CLEANSESSION :: %@", (CLEANSESSION)? @"true" : @"false");
        client = [client initWithHosts:MQTTHOSTS ports:MQTTPORTS clientId:MQTTTOKEN];
        ConnectOptions *opts = [[ConnectOptions alloc] init];
        opts.timeout = 3600;
        opts.cleanSession = CLEANSESSION;
        opts.keepAliveInterval = 30;
        
        SSLOptions *ssloti = [[SSLOptions alloc] init];
        ssloti.enableServerCertAuth = FALSE;
        opts.sslProperties = ssloti;
        
        if (self.AUTOSUBSCRIBE && self.autoSubscribeAgentTimer == nil) {
            //autoSubscribeAgentTimer Background loop run
            self.autoSubscribeAgentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoSubscribe) userInfo:nil repeats:YES];
        }
        
//        NSLog(@"host=%@, port=%@, clientId=%@, cleanSession=%@", MQTTHOSTS, MQTTPORTS, MQTTTOKEN,  (CLEANSESSION)? @"true" : @"false");
        [client connectWithOptions:opts invocationContext:self onCompletion:[[ConnectCallbacks alloc] init]];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"[ADFError] connectMQTT - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"connectMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
        
        NSString *result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 302500,\"message\": \"%@\"}",exception];
        NSString *tempMethord = @"connectCallBack:";

        [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
    }
    
}



- (void)disconnectMQTT:(int)timeout {
    
    @try {
        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"disconnectMQTT" param1:[NSString stringWithFormat: @"%d", timeout]  param2:@"" jsonYn:false data:@"" jogTypeError: false];
        
        DisconnectOptions *opts = [[DisconnectOptions alloc] init];
        [opts setTimeout:timeout];
        
        [client disconnectWithOptions:opts invocationContext:self onCompletion:[[DisConnectCallbacks alloc] init]];
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] disconnectMQTT - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"disconnectMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

    

}

- (void)publish:(NSString *)topic payload:(NSString *)payload qos:(int)qos retained:(BOOL)retained
{
    @try {
        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"publish" param1:topic  param2:[NSString stringWithFormat: @"%d", qos] jsonYn:false data:(retained)? @"true" : @"false" jogTypeError: false];
        
        NSLog(@"=========== playload1 :%@", payload);
        
        NSString *retainedStr = retained ? @" [retained]" : @"";
        NSString *logStr = [NSString stringWithFormat:@"[%@] %@%@", topic, payload, retainedStr];
        NSLog(@"- %@", logStr);
        //    [[ADFPush sharedADFPush] addLogMessage:logStr type:@"Publish"];
        
        NSLog(@"=========== playload2 :%@", payload);
        MqttMessage *msg = [[MqttMessage alloc] initWithMqttMessage:topic payload:(char*)[payload UTF8String] length:(int)payload.length qos:qos retained:retained duplicate:NO];
        NSLog(@"=========== msg :%@", msg);
        
        [client send:msg invocationContext:self onCompletion:[[PublishCallbacks alloc] init]];
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] publish - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"publish" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }
    

    
    
}

- (void)subscribeMQTT:(NSString *)topicFilter qos:(int)qos
{
    @try {
        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"subscribeMQTT" param1:topicFilter param2:[NSString stringWithFormat: @"%d", qos]   jsonYn:false data:@"" jogTypeError: false];
        
        // 2015-11-04 개발자 요청으로 isConnected 추가
        MqttClient *mClient = [[ADFPush sharedADFPush] client];
        if ([mClient isConnected]) {
            NSLog(@"topicFilter=%@, qos=%d", topicFilter, qos);
            NSLog(@"=====  subscribe start");
            [client subscribe:topicFilter qos:qos invocationContext:topicFilter onCompletion:[[SubscribeCallbacks alloc] init]];
        } else {
            NSString *tempMethord = @"subscribeCallBack:";
            NSString * result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 305401,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"MQTT 연결이 안되어 있습니다.\"}",topicFilter];
            
            [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] subscribeMQTT - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"subscribeMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }
    
    
    
    
}

- (void)unsubscribeMQTT:(NSString *)topicFilter
{
    @try {
        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"unsubscribeMQTT" param1:topicFilter  param2:@"" jsonYn:false data:@"" jogTypeError: false];
        
        // 2015-11-04 개발자 요청으로 isConnected 추가
        MqttClient *mClient = [[ADFPush sharedADFPush] client];
        if ([mClient isConnected]) {
            
            ////  기본 토픽 구독 해제 방지 로지 --> 사용 안하기로 함.
//            if ([topicFilter isEqualToString:[NSString stringWithFormat:@"users/%@",MQTTTOKEN]]) {
//                NSString *tempMethord = @"unsubscribeCallBack:";
//                NSString * result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 306402,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"기본 토픽은 구독해제를 할 수 없습니다.\"}",topicFilter];
//                
//                [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
//            } else {
//                NSLog(@"topicFilter=%@", topicFilter);
//                [client unsubscribe:topicFilter invocationContext:topicFilter onCompletion:[[UnsubscribeCallbacks alloc] init]];
//            }
            
            NSLog(@"topicFilter=%@", topicFilter);
            [client unsubscribe:topicFilter invocationContext:topicFilter onCompletion:[[UnsubscribeCallbacks alloc] init]];
            
        } else {
            NSString *tempMethord = @"unsubscribeCallBack:";
            NSString * result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 306401,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"MQTT 연결이 안되어 있습니다.\"}",topicFilter];
            
            [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] unsubscribeMQTT - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"unsubscribeMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];

    }
    
    
}

- (NSString *)registerToken:(NSString *)token{
    
    // Job Logging
    [[ADFPush sharedADFPush] addJobLog:@"registerToken" param1:token  param2:@"" jsonYn:false data:@"" jogTypeError: false];
    
     NSString * result = nil;
    
    if (token.length < 24) {
        
        @try {
            QueueFile * adfEnv = [ [ADFPush sharedADFPush] adfEnv];
            NSString *envJson;
            if ([adfEnv size] > 0) {
                // token Queue read
                NSString *adfEnvJson = [NSString stringWithUTF8String:[[self.adfEnv peek] bytes]];
                
                NSData *jData = [adfEnvJson dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
                
                [jsonDic removeObjectForKey:@"token"];
                [jsonDic setObject:token forKey:@"token"];
                [jsonDic removeObjectForKey:@"autoSubscribe"];
                [jsonDic setObject:[NSNumber numberWithBool:YES] forKey:@"autoSubscribe"];
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
                envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

            }else {
                NSArray * temp = [[NSArray alloc] init];
                NSNumber *mqttKeepAliveInterval = [[NSNumber alloc] initWithInt:MQTTKEEPALIVEINTERVAL];
                NSNumber *cleanSesstionBool = [NSNumber numberWithBool:CLEANSESSION];
                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      temp,@"hosts",
                                      temp,@"ports",
                                      cleanSesstionBool,@"cleanSesstion",
                                      token,@"token",
                                      @"",@"adfPushServerUrl",
                                      mqttKeepAliveInterval,@"mqttKeepAliveInterval",
                                      [NSNumber numberWithBool:YES],@"autoSubscribe",
                                      nil];
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
                envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
               
            }
             NSLog(@"envJson : %@", envJson);
            
            [adfEnv clear];
            [adfEnv add:dataForString(envJson)];
            MQTTTOKEN = token;
            self.AUTOSUBSCRIBE = true;
            
            result = @"{\"status\": \"ok\",\"code\": 301200,\"message\": \"토큰등록이 완료되었습니다\"}";
            
            
            //연결이 되어 있을때, 연결 종료.
            MqttClient *mClient = [[ADFPush sharedADFPush] client];
            if ([mClient isConnected]) {
                [[ADFPush sharedADFPush] disconnectMQTT:2];
            }
            
//            [[[ADFPush sharedADFPush] autoSubscribeAgentTimer] invalidate];
//            [[ADFPush sharedADFPush] setAutoSubscribeAgentTimer:nil];
            
//            if (self.autoSubscribeAgentTimer == nil) {
//                //autoSubscribeAgentTimer Background loop run
//                self.autoSubscribeAgentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoSubscribe) userInfo:nil repeats:YES];
//            }

            
        }
        @catch (NSException *exception) {
            NSLog(@"[ADFError] NSException: %@", exception);
            result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 301500,\"message\": \"%@\"}",exception];
            [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"registerToken" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
        }

    } else {
        
        NSLog(@"[ADFError] token length error - token: %@", token);
        result = @"{\"status\": \"fail\",\"code\": 301401,\"message\": \"토큰길이가 큽니다.\"}";
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"registerToken" param2:@"" jsonYn:true data:result jogTypeError: true];
    }
    
   
    
    return result;
}

- (NSString *)getTokenMQTT{
    
    // Job Logging
    [[ADFPush sharedADFPush] addJobLog:@"getTokenMQTT" param1:@""  param2:@"" jsonYn:false data:@"" jogTypeError: false];
    
    NSString * result;
    
    @try {
        result = [NSString stringWithFormat:@"{\"status\": \"ok\",\"data\":{ \"token\":\"%@\"},\"code\": 310200,\"message\": \"토큰 가져오기가  완료 되었습니다\"}",MQTTTOKEN];
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 301500,\"message\": \"%@\"}",exception];
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"getTokenMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }
    
    
    return result;
}

- (NSString *)connectStateMQTT{
    
    // Job Logging
    [[ADFPush sharedADFPush] addJobLog:@"connectStateMQTT" param1:@""  param2:@"" jsonYn:false data:@"" jogTypeError: false];
    
    NSString * result;
    
    @try {
        MqttClient *mClient = [[ADFPush sharedADFPush] client];
        
        
        if ([mClient isConnected]) {
            result = @"{\"status\": \"ok\",\"code\": 304200,\"message\": \"MQTT 서버에 연결된 상태입니다.\"}";
        } else {
            result = @"{\"status\": \"fail\",\"code\": 304400,\"message\": \"MQTT 서버에 연결되어 있지 않습니다.\"}";
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 304500,\"message\": \"%@\"}",exception];
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"connectStateMQTT" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

    return result;
}

- (NSString *)cleanJobQueue{
    // Job Logging
    [[ADFPush sharedADFPush] addJobLog:@"cleanJobQueue" param1:@""  param2:@"" jsonYn:false data:@"" jogTypeError: false];
    
    NSString * result;
    
    
    PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
    NSString * sqlResult = [pushDataDB deleteJobAll]; //Job 삭제
    
    
    if ([sqlResult isEqualToString:@"OK"]) {
        result = @"{\"status\": \"ok\",\"code\": 308200,\"message\": \"작업큐 초기화가 완료되었습니다\"}";
    } else {
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 308500,\"message\": \"%@\"}",sqlResult];
    }
    
    return result;
}

- (void) addJobLog:(NSString *)jobName param1:(NSString *) param1 param2:(NSString *) param2 jsonYn:(BOOL)jsonYn data:(NSString *) data jogTypeError:(BOOL) jobTypeError{
    
//    NSLog(@"==== addJobLog: %@", param1);
    
    @try {
        NSDate *now = [NSDate date]; //현재 날짜로 객체 생성
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss:SS"];
        NSString *dateString = [dateFormat stringFromDate:now];
        
//        NSString *result = [NSString stringWithFormat:@"{\"date\": \"%@\",\"jobName\": \"[%@][%@][%@]\", \"data\":%@}",dateString, jobName,param1,param2,data];
        NSString *result;
        if (jsonYn) {
            result = [NSString stringWithFormat:@"{\"date\": \"%@\",\"jobName\": \"%@\", \"param1\":\"%@\", \"param2\":\"%@\", \"data\":%@}",dateString, jobName,param1,param2,data];
        } else {
            result = [NSString stringWithFormat:@"{\"date\": \"%@\",\"jobName\": \"%@\", \"param1\":\"%@\", \"param2\":\"%@\", \"data\":\"%@\"}",dateString, jobName,param1,param2,data];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            @try {
//                NSLog(@"==== addJobLog dispatch_async :%@ ", result);
                if (jobTypeError) {
                    QueueFile * adfErrorLogQF = [ [ADFPush sharedADFPush] adfErrorLogQF];
//                    NSLog(@"[adfErrorLogQF size] : %d", [adfErrorLogQF size]);
                    if ([adfErrorLogQF size] > 500) {
                        [adfErrorLogQF remove];
                    }
                    [adfErrorLogQF add:dataForString(result)];
                } else {
                    QueueFile * adfTranLogQF = [ [ADFPush sharedADFPush] adfTranLogQF];
//                    NSLog(@"[adfTranLogQF size] : %d", [adfTranLogQF size]);
                    if ([adfTranLogQF size] > 3000) {
                        [adfTranLogQF remove];
                    }
                    [adfTranLogQF add:dataForString(result)];
                }
                
            }
            @catch (NSException *exception) {
                NSLog(@"[ADFError] addJobLog - NSException: %@", exception);
            }
        });
    
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] addJobLog - NSException: %@", exception);
    }
}

- (void)getSubscriptions{
    // Job Logging
    [[ADFPush sharedADFPush] addJobLog:@"getSubscriptions" param1:@""  param2:@"" jsonYn:false data:@"" jogTypeError: false];

    NSString *host = ADFPUSHHOST;
    
    @try {
        
        NSString *urlString = [NSString stringWithFormat:@"%@/v1/token/subscriptions/%@",host,MQTTTOKEN];
        
        NSLog(@"urlMu :%@", urlString);
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        [request setURL:url];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
        [request setTimeoutInterval:5.0];
        [request setHTTPMethod:@"GET"];
        [request addValue:MQTTTOKEN forHTTPHeaderField:@"X-Application-Key"];
        
        //    [NSURLConnection connectionWithRequest:request delegate:self];
//        NSHTTPURLResponse * response;
//        NSError * error = nil;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                      NSString * result;
                                          
                                                      if (error != nil) {
                                                          NSLog(@"[ADFPush] Error on load = %@", [error localizedDescription]);
                                                          NSString *tempMethord = @"getSubscriptionsCallBack:";
                                          
                                                          result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"%@\"}",[error localizedDescription]];
                                          
                                                          NSLog(@"=====result = %@", result);
                                                          [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
                                          
                                                      } else {
                                                          //HTTP 상태를 검사한다.
                                                          if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                              NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
                                          
                                                              if (httpResponse.statusCode != 200) {
                                                                  NSLog(@"[ADFPush] httpResponse statusCode  = %ld", (long) httpResponse.statusCode);
                                          
                                                                  result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"httpResponse statusCode  = %ld\"}",(long) httpResponse.statusCode];
                                                                  NSString *tempMethord = @"getSubscriptionsCallBack:";
                                                                  
                                                                  [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
                                                                  return ;
                                                              }
                                                          }
                                                          
                                                          NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                          
                                                          NSLog(@" content : %@",content);
                                                          
                                                          NSString *tempMethord = @"getSubscriptionsCallBack:";
                                           
                                                          [[ADFPush sharedADFPush] callBackSelector:tempMethord data:content];
                                                      }
                                      }];
        
        [task resume];
        


//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            
//             NSLog(@"================ddfff================");
//            NSString * result;
//
//            if (error != nil) {
//                NSLog(@"[ADFPush] Error on load = %@", [error localizedDescription]);
//                NSString *tempMethord = @"getSubscriptionsCallBack:";
//                
//                result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"%@\"}",[error localizedDescription]];
//                
//                NSLog(@"=====result = %@", result);
//                [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
//                
//            } else {
//                //HTTP 상태를 검사한다.
//                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
//                    
//                    if (httpResponse.statusCode != 200) {
//                        NSLog(@"[ADFPush] httpResponse statusCode  = %ld", (long) httpResponse.statusCode);
//                        
//                        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"httpResponse statusCode  = %ld\"}",(long) httpResponse.statusCode];
//                        NSString *tempMethord = @"getSubscriptionsCallBack:";
//                        
//                        [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
//                        return ;
//                    }
//                }
//                
//                NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                
//                NSLog(@" content : %@",content);
//                
//                NSString *tempMethord = @"getSubscriptionsCallBack:";
// 
//                [[ADFPush sharedADFPush] callBackSelector:tempMethord data:content];
//            }
//        }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"getSubscriptions" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
        
        NSString *result2 = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"%@\"}",exception];
        NSString *tempMethord = @"connectLostCallBack:";
        
        [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result2];
    }
}

//- (NSString *)getSubscriptions{
//    // Job Logging
//    [[ADFPush sharedADFPush] addJobLog:@"getTokenMQTT" param1:@""  param2:@"" param3:@""];
//    
//    NSString * result;
//    
//    //    NSURL *url = [[NSURL alloc] initWithString:@"https://14.63.217.141:8081/v1/pms/adm/cmm/auth"];
//    //    NSURL *url = [[NSURL alloc] initWithString:@"http://127.0.0.1:8080/v1/pms/adm/cmm/auth"];
//    //    NSURL *url = [[NSURL alloc] initWithString:@"https://easy-message.co.kr/v1/pms/adm/cmm/auth"];
//    
//    NSString *host = @"http://112.223.76.75:18080";
//    
//    @try {
//        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//        //                                                             NSUserDomainMask, YES);
//        //        NSString *documentsDirectory = [paths objectAtIndex:0];
//        //        NSString *filePath =
//        //        [documentsDirectory stringByAppendingPathComponent:@"token.q"];
//        //        QueueFile  * tokenQ = [QueueFile queueFileWithPath:filePath];
//        //
//        //        // token Queue read
//        //        NSString *token = [NSString stringWithUTF8String:[[tokenQ peek] bytes]];
//        
//        NSString *urlString = [NSString stringWithFormat:@"%@/v1/token/subscriptions/%@",host,MQTTTOKEN];
//        
//        NSLog(@"urlMu :%@", urlString);
//        
//        NSURL *url = [[NSURL alloc] initWithString:urlString];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        
//        //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
//        
//        [request setURL:url];
//        [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
//        [request setTimeoutInterval:30.0];
//        [request setHTTPMethod:@"GET"];
//        [request addValue:MQTTTOKEN forHTTPHeaderField:@"X-Application-Key"];
//        
//        //    [NSURLConnection connectionWithRequest:request delegate:self];
//        NSHTTPURLResponse * response;
//        NSError * error = nil;
//        
//        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        
//        if (error != nil) {
//            NSLog(@"[ADFPush] Error on load = %@", [error localizedDescription]);
//            
//            result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"%@\"}",[error localizedDescription]];
//            
//            return result;
//        }
//        
//        //HTTP 상태를 검사한다.
//        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//            //        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
//            
//            if ([response statusCode] != 200) {
//                NSLog(@"[ADFPush] httpResponse statusCode  = %ld", (long)[response statusCode]);
//                
//                result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"httpResponse statusCode  = %ld\"}",(long)[response statusCode]];
//                return result;
//            }
//        }
//        
//        //     NSLog(@"[ADFPush] httpResponse statusCode  = %ld", (long)[response statusCode]);
//        
//        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSLog(@" content : %@",content);
//        result = content;
//    }
//    @catch (NSException *exception) {
//        NSLog(@"[ADFError] NSException: %@", exception);
//        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 307500,\"message\": \"%@\"}",exception];
//    }
//    @finally {
//        
//    }
//    
//    return result;
//}


- (NSString *)callAck:(NSString *)msgId ackTime:(int)ackTime jobId:(int) jobId{
    
    NSLog(@"callAck - start");
    NSString *result;
    
    @try {
        PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
        int ackValue = [pushDataDB getAck:jobId]; //0=ackNo, 1=ackOK, 2=DB not found

        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:@"callAck" param2:msgId jsonYn:false data:[NSString stringWithFormat:@"%d",ackTime] jogTypeError: false];
        
        if (ackValue == 1) {
            JobBean *job = [[JobBean alloc]init];
            
            [job setMsgType:301];
            [job setAck:0];
            [job setQos:0];
            [job setContent:@""];
            [job setMsgId:msgId];
            [job setContentType:@""];
            [job setTopic:@""];
            [job setServiceId:@""];
            [job setIssueTime:ackTime];
            
            [pushDataDB insertJob:job];
            
//            PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
            [pushDataDB deleteJobId:jobId]; //Job 삭제
        } else if (ackValue == 0) {
//            PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
            [pushDataDB deleteJobId:jobId]; //Job 삭제
        }
        result = @"{\"status\": \"ok\",\"code\": 309200,\"message\": \"수신확인 메세지가 작업 DB에 저장이 되었습니다.\"}";
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 309500,\"message\": \"%@\"}",exception];
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"callAck" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

    
    return result;
}



- (void)agentAck:(NSString *)msgId ackTime:(int)ackTime ackType:(NSString *) ackType {

    NSLog(@"agentAck - start");
    
    @try {
        
        
        // Job Logging
        [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:ackType param2:msgId jsonYn:false data:@"" jogTypeError: false];
        long long  currentTimeMillis = (long long) ackTime*1000;
        NSString *payload = [NSString stringWithFormat:@"{\"msgId\": \"%@\",\"ackTime\": %lld,\"token\": \"%@\",\"ackType\": \"%@\"}",msgId,currentTimeMillis,MQTTTOKEN,ackType];
        
        NSLog(@"=========== playload :%@", payload);
        NSString *topic = @"adfpush/ack";
        
        
        MqttMessage *msg = [[MqttMessage alloc] initWithMqttMessage:topic payload:(char*)[payload UTF8String] length:(int)payload.length qos:1 retained:false duplicate:NO];
        
        //    NSLog(@"=========== msg :%@", msg);
        
        [client send:msg invocationContext:self onCompletion:[[AgentAckCallbacks alloc] init]];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] agentAck - NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"agentAck" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }
    
}




-(void)jobAgent {
    @try {
        NSLog(@"jobAgent Run");
        
        PushDataBase *pushDataDB = [[ADFPush sharedADFPush] pushDataDB];
        NSArray *jobList = [pushDataDB getJobList];
        JobBean *job = [[JobBean alloc]init];
        
        
        // 연결체크 후 연결이 안되어 있으면 다시 연결 시도.
        MqttClient *mClient = [[ADFPush sharedADFPush] client];
        if (![mClient isConnected] && [[ADFPush sharedADFPush] loginMQTT]) {
            [[ADFPush sharedADFPush] connectMQTT];
        }
        
        //    [self fileUpload:@"http://112.223.76.75:9329"];
        
        NSString *tempMethord;
        NSString * result;
        
        NSString *queMsg;
        QueueFile * adfEnv;
        NSString *envJson;
        NSNumber *mqttKeepAliveInterval;
        NSArray * temp;
        NSData *jData=nil;
        NSData *contentData=nil;
        NSData *jsonData=nil;
        NSMutableDictionary *jsonDic=nil;
        NSDictionary *dict=nil;
        NSDictionary *contentDict=nil;
        NSString *adfEnvJson;
        NSString *hostUrl;
        int timestamp;
        
        
        for (int i=0; i < jobList.count; i++) {
            job = [jobList objectAtIndex:i];
            
            switch (job.msgType) {
                    
                    ///// 일반메세지
                case 100:
                    timestamp = [[NSDate date] timeIntervalSince1970] - JOBINTERVAL;
                    NSLog(@"====== timestamp: %d, JOBINTERVAL : %f",timestamp,JOBINTERVAL);
                    if (job.issueTime < timestamp) {
                        tempMethord = @"onMessageArrivedCallBack:";
                        result = [NSString stringWithFormat:@"{\"content\": \"%@\",\"msgId\":\"%@\",\"contentType\":\"%@\",\"topic\":\"%@\",\"qos\":%d,\"jobId\":%d}",job.content,job.msgId, job.contentType, job.topic, job.qos, job.jobId];
                        [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:@"Retry MessageDelivery" param2:job.msgId jsonYn:false data:@"" jogTypeError: false];
                        [[ADFPush sharedADFPush] callBackSelector:tempMethord data:result];
                    }
                    
                    
                    break;
                    
                    ////// keepAliveTime
                case 200:
                    
                    adfEnv = [ [ADFPush sharedADFPush] adfEnv];
                    //시스템 명령 읽기
                    
                    NSLog(@"===== content : %@",job.content);
                    
                    contentData = [job.content dataUsingEncoding:NSUTF8StringEncoding];
                    contentDict = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableContainers error:nil];
                    mqttKeepAliveInterval = [[NSNumber alloc] initWithInt:[contentDict[@"keepAliveTime"] intValue]];
                    NSLog(@"===== mqttKeepAliveInterval : %d",[contentDict[@"keepAliveTime"] intValue]);
                    
                    if ([adfEnv size] > 0) {
                        
                        // 기존 환경설정 읽기
                        adfEnvJson = [NSString stringWithUTF8String:[[self.adfEnv peek] bytes]];
                        
                        jData = [adfEnvJson dataUsingEncoding:NSUTF8StringEncoding];
                        jsonDic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
                        
                        [jsonDic removeObjectForKey:@"mqttKeepAliveInterval"];
                        [jsonDic setObject:mqttKeepAliveInterval forKey:@"mqttKeepAliveInterval"];
                        
                        jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
                        envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                    }else {
                        temp = [[NSArray alloc] init];
                        dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                temp,@"hosts",
                                temp,@"ports",
                                @"",@"token",
                                @"",@"adfPushServerUrl",
                                mqttKeepAliveInterval,@"mqttKeepAliveInterval",
                                nil];
                        
                        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
                        envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                        
                    }
                    NSLog(@"envJson : %@", envJson);
                    
                    [adfEnv clear];
                    [adfEnv add:dataForString(envJson)];
                    MQTTKEEPALIVEINTERVAL = [contentDict[@"mqttKeepAliveInterval"] intValue];
                    
                    //연결이 되어 있을때, 연결 종료.
                    if ([mClient isConnected]) {
                        
                        [[ADFPush sharedADFPush] disconnectMQTT:2];
                        [[ADFPush sharedADFPush] connectMQTT];
                    }
                    [pushDataDB deleteJobId:job.jobId];
                    
                    
                    [[ADFPush sharedADFPush] addJobLog:@"TranLog" param1:@"keepAliveTime" param2:job.msgId jsonYn:false data:@"" jogTypeError: false];
                    
                    break;
                    
                    ///// logfile upload
                case 201:
                    
                    NSLog(@"===== content : %@",job.content);
                    
                    contentData = [job.content dataUsingEncoding:NSUTF8StringEncoding];
                    contentDict = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableContainers error:nil];
                    hostUrl = contentDict[@"hostUrl"];
                    NSLog(@"===== hostUrl : %@",hostUrl);
                    
                    
                    [self fileUpload:hostUrl];
                    [pushDataDB deleteJobId:job.jobId];
                    
                    break;
                    
                    
                    ///// echoAck
                case 202:
                    
                    [self echoAck:job.msgId];
                    [pushDataDB deleteJobId:job.jobId];
                    
                    break;
                    
                    ///// Agent Ack
                case 300:
                    if ([mClient isConnected]) {
                        [[ADFPush sharedADFPush] agentAck:job.msgId ackTime:job.issueTime ackType:@"agent"];
                        [pushDataDB deleteJobId:job.jobId];
                    }
                    
                    
                    break;
                    
                    ////// App Ack
                case 301:
                    if ([mClient isConnected]) {
                        [[ADFPush sharedADFPush] agentAck:job.msgId ackTime:job.issueTime ackType:@"app"];
                        [pushDataDB deleteJobId:job.jobId];
                    }
                    break;
                    
                    
                default:
                    
                    [[ADFPush sharedADFPush] addJobLog:@"JobError" param1:@"msgType error" param2:[NSString stringWithFormat:@"%d",job.msgType] jsonYn:false data:@"" jogTypeError: true];
                    NSLog(@"[ADFPush] jobAgent msgType error  : %@", queMsg);
                    [pushDataDB deleteJobId:job.jobId];
                    break;
            }
        }

    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"jobAgent" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

    
    
    
    
    
}

- (NSString *)registerADFPushEnv:(NSArray *)hosts ports:(NSArray *)ports cleanSesstion:(BOOL)cleanSesstion token:(NSString *)token adfPushServerUrl:(NSString *)adfPushServerUrl{
    NSString *result;
    
    NSNumber *mqttKeepAliveInterval = [[NSNumber alloc] initWithInt:MQTTKEEPALIVEINTERVAL]; //defult 30 sec
    NSNumber *cleanSesstionBool = [NSNumber numberWithBool:cleanSesstion];
    NSNumber *autoSubscribeBool = [NSNumber numberWithBool:YES];

    
    
    @try {
    
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              hosts,@"hosts",
                              ports,@"ports",
                              cleanSesstionBool,@"cleanSesstion",
                              token,@"token",
                              adfPushServerUrl,@"adfPushServerUrl",
                              mqttKeepAliveInterval,@"mqttKeepAliveInterval",
                              autoSubscribeBool,@"autoSubscribe",
                              nil];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *envJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"envJson : %@", envJson);
        
        QueueFile * adfEnv = [ [ADFPush sharedADFPush] adfEnv];
        [adfEnv clear];
        [adfEnv add:dataForString(envJson)];
        MQTTHOSTS = hosts;
        MQTTPORTS = ports;
        MQTTTOKEN = token;
        ADFPUSHHOST = adfPushServerUrl;
        CLEANSESSION = cleanSesstion;
        self.AUTOSUBSCRIBE = true;
        
        result = @"{\"status\": \"ok\",\"code\": 312200,\"message\": \"ADFPUSH 환경이 설정되었습니다.\"}";
        
        //연결이 되어 있을때, 연결 종료.
        MqttClient *mClient = [[ADFPush sharedADFPush] client];
        if ([mClient isConnected]) {
            [[ADFPush sharedADFPush] disconnectMQTT:2];
        }
        
//        if (self.autoSubscribeAgentTimer == nil) {
//            //autoSubscribeAgentTimer Background loop run
//            self.autoSubscribeAgentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoSubscribe) userInfo:nil repeats:YES];
//        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 312500,\"message\": \"%@\"}",exception];
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"registerADFPushEnv" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }

    
    return result;
}

- (NSString *)getAdfPushEnv {
    NSString *result;
    
//    NSLog(@"=== MQTTKEEPALIVEINTERVAL : %d", MQTTKEEPALIVEINTERVAL);
    
    @try {
        
        QueueFile * adfEnv = [ [ADFPush sharedADFPush] adfEnv];
        if ([adfEnv size] > 0) {
            // token Queue read
            NSString *adfEnvJson = [NSString stringWithUTF8String:[[self.adfEnv peek] bytes]];
            result = [NSString stringWithFormat:@"{\"status\": \"ok\",\"code\": 313200,\"message\": \"ADFPUSH 환경정보를 가져왔습니다.\", \"data\": %@}",adfEnvJson];
        }else {
            result = @"{\"status\": \"fail\",\"code\": 313400,\"message\": \"ADFPUSH 환경정보가 없습니다.\"}";
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        result = [NSString stringWithFormat:@"{\"status\": \"fail\",\"code\": 313500,\"message\": \"%@\"}",exception];
        [[ADFPush sharedADFPush] addJobLog:@"JobNSException" param1:@"getAdfPushEnv" param2:@"" jsonYn:false data:[exception description] jogTypeError: true];
    }
    
    
    return result;
}

- (void) callBackSelector:(NSString *)tempMethord data:(NSString *) data
{
    id tempResponder = [[ADFPush sharedADFPush] Responder];
//    NSString *tempMethord = @"connectLostCallBack:";
    
    SEL sel = NSSelectorFromString(tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, data);
    } else {
        NSLog(@"[ADFPush] Warning : Method '%@' not defind \n",tempMethord);
        return;
    }
    
}


-(void)fileUpload:(NSString *) hostUrl{
    @try {
        NSFileManager *FileManager;
        FileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *fileNameTran = @"adfTranLog.q";
        NSString *fileNameTranNew = [NSString stringWithFormat:@"%@_backup",fileNameTran];
        NSString *fileNameErr = @"adfErrorLog.q";
        NSString *fileNameErrNew = [NSString stringWithFormat:@"%@_backup",fileNameErr];
        
        NSString *fileTranPath = [documentsDirectory stringByAppendingPathComponent:fileNameTran];
        NSString *fileErrPath = [documentsDirectory stringByAppendingPathComponent:fileNameErr];
        
        /** 현재 디렉토리에 test.txt 파일이 있는지 검사 */
        if ([FileManager fileExistsAtPath:fileTranPath] == NO) {
            NSLog(@"[1]%@ file not exist", fileNameTran);
        } else {
            NSLog(@"[1]%@ file OK", fileNameTran);
            NSString *fileTranNewPath =
            [documentsDirectory stringByAppendingPathComponent:fileNameTranNew];
            NSString *fileErrNewPath =
            [documentsDirectory stringByAppendingPathComponent:fileNameErrNew];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                /** test.txt 파일을 test2 밑에 new_test.txt로 복사 */
                [FileManager copyItemAtPath:fileTranPath toPath:fileTranNewPath error:nil];
                [FileManager copyItemAtPath:fileErrPath toPath:fileErrNewPath error:nil];
                
                if ([FileManager fileExistsAtPath:fileTranNewPath] == NO) {
                    NSLog(@"[2]%@ file not exist",fileTranNewPath);
                } else {
                    NSLog(@"[2]%@ file OK",fileTranNewPath);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //file Read
                        NSData *fileTranNewData = [FileManager contentsAtPath:fileTranNewPath];
                        NSData *fileErrNewData = [FileManager contentsAtPath:fileErrNewPath];
                        //                NSString *host = @"http://112.223.76.75:9329";
                        //                NSString *MQTTTOKEN = @"640095551c223b18b384311";
                        
                        NSString *urlString = [NSString stringWithFormat:@"%@/cts/v1/users/%@",hostUrl,MQTTTOKEN];
                        
                        NSLog(@"urlMu :%@", urlString);
                        
                        NSURL *url = [[NSURL alloc] initWithString:urlString];
                        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                        
                        //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
                        
                        [request setURL:url];
                        [request setHTTPMethod:@"POST"];
                        
                        
                        
                        //////////
                        NSString *boundary = [NSString stringWithFormat:@"ADEDFEDFEDEDAAAAa1233448577888"];
                        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                        [request addValue:contentType forHTTPHeaderField:@"Content-type"];
                        NSMutableData *body = [[NSMutableData data] init];
                        
                        ////////구분자 표시
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        ////// 첫번째 파일 전송
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileNameTranNew] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Type:application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding] ];
                        
                        NSLog(@"전송 바이트1 : %lu", (unsigned long)[body length]);
                        
                        //////실제 전송할 파일내용
                        [body appendData:[NSData dataWithData:fileTranNewData]];
                        
                        ////////구분자 표시
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        ////// 두번째 파일 전송
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileNameErrNew] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Type:application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding] ];
                        
                        NSLog(@"전송 바이트2 : %lu", (unsigned long)[body length]);
                        
                        //////실제 전송할 파일내용
                        [body appendData:[NSData dataWithData:fileErrNewData]];
                        
                        ////////구분자 표시
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

                        
                        
                        [request setHTTPBody:body];
                        
                        NSLog(@"전송 바이트3 : %lu", (unsigned long)[body length]);
                        
                        NSURLSession *session = [NSURLSession sharedSession];
                        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                                completionHandler:
                                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                          if (error != nil) {
                                                              NSLog(@"[ADFPush] Error on load = %@", [error localizedDescription]);
                                                              
                                                          } else {
                                                              //HTTP 상태를 검사한다.
                                                              if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                                  NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
                                                                  
                                                                  if (httpResponse.statusCode != 200) {
                                                                      NSLog(@"[ADFPush] httpResponse statusCode  = %ld", (long) httpResponse.statusCode);
                                                                  }else{
                                                                      NSLog(@"[ADFPush] file upload OK");
                                                                  }
                                                              }
                                                          }
                                                      }];
                        
                        [task resume];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ///// 복사된 파일 삭제
                            [FileManager removeItemAtPath:fileTranNewPath error:nil];
                            [FileManager removeItemAtPath:fileErrNewPath error:nil];
                            if ([FileManager fileExistsAtPath:fileTranNewPath] == NO) {
                                NSLog(@"[3]%@ file delete OK",fileTranNewPath);
                            } else {
                                NSLog(@"[3]%@ file delete Fail",fileTranNewPath);
                            }
                            
                        });
                        
                        
                    });
                    
                    
                }

            });
            
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] connectMQTT - NSException2: %@", [exception description]);
    }
}


- (void)echoAck:(NSString *)msgId {
    
    NSLog(@"echoAck - start");
    
    @try {
        
        int timestamp = [[NSDate date] timeIntervalSince1970];
        long long  currentTimeMillis = (long long) timestamp*1000;
        NSString *payload = [NSString stringWithFormat:@"{\"msgId\": \"%@\",\"ackTime\": %lld,\"tokenId\":\"%@\"}",msgId,currentTimeMillis,MQTTTOKEN];
        
//        NSLog(@"=========== playload :%@", payload);
        NSString *topic = @"adfpush/ping";
        
        
        MqttMessage *msg = [[MqttMessage alloc] initWithMqttMessage:topic payload:(char*)[payload UTF8String] length:(int)payload.length qos:1 retained:false duplicate:NO];
        
        //    NSLog(@"=========== msg :%@", msg);
        
        [client send:msg invocationContext:self onCompletion:[[AgentAckCallbacks alloc] init]];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] echoAck - NSException: %@", exception);
    }
    
}



@end


