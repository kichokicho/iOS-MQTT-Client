//
//  ADFPush.m
//  ADFPush
//
//  Created by gwangil on 2015. 9. 7..
//  Copyright (c) 2015년 kamy. All rights reserved.
//

#import "ADFPush.h"
//#import "MqttOCClient.h"
//#import "LogMessage.h"
//#import "Subscription.h"
//#import "MappingJson.h"
//#import "MessageBean.h"
//#import "JsonUtil.h"
//#import "ADFBean.h"
//#import "AppDelegate.h"









@interface MessageBean : NSObject

@property int id;
@property (nonatomic, retain) NSString *userid;
@property int ack;
@property int type;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *receivedate;
@property int  read;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *sendDate;

@end

@implementation MessageBean

@synthesize id;
@synthesize userid;
@synthesize ack;
@synthesize type;
@synthesize content;
@synthesize receivedate;
@synthesize read;
@synthesize category;
@synthesize sendDate;

@end



// Connect Callbacks
@interface ConnectCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation ConnectCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
//    NSLog(@"- invocationContext=%@", invocationContext);
    //    [[ADFPush sharedADFPush] addLogMessage:@"Connected to server!" type:@"Action"];
    
//        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        [appDelegate updateConnectButton];
    
    
    ///[sk]
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"connectCallBack:";
    
//    [aDFBean setMessage:@"Connected"];
    NSString *result = @"{\"status\": \"ok\",\"code\": 302200,\"message\": \"MQTT 서버에 접속이 되었습니다.\"}";
    
    SEL sel = NSSelectorFromString(tempMethord);
//    NSLog(@"Caller invoking method %@ \n", tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'connectCallBack' not defind \n");
        return;
    }
    
    
//    QueueFile  *queueFile = [[ADFPush sharedADFPush] queueFile];
    
//    NSLog(@"QueueTest Length1 : %d", [queueFile size]);
//    [queueFile add:dataForString(@"foo")];
//    NSLog(@"QueueTest Length2 : %d", [queueFile size]);
    
    return;
    
    ///[sk]
    
    
}

NSData *dataForString(NSString *text)
{
    const char *s = [text UTF8String];
    return [NSData dataWithBytes:s length:strlen(s) + 1];
}

- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"- invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    //    [[ADFPush sharedADFPush] addLogMessage:@"Failed to connect!" type:@"Action"];
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"connectCallBack:";
    
    //    [aDFBean setMessage:@"Connected"];
    NSString *result = @"{\"status\": \"fail\",\"code\": 302400,\"message\": \"MQTT 서버에 접속이 실패 되었습니다.\"}";
    
    SEL sel = NSSelectorFromString(tempMethord);
    NSLog(@"Caller invoking method %@ \n", tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'connectCallBack' not defind \n");
        return;
    }
}
@end

// disConnect Callbacks
@interface DisConnectCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation DisConnectCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
//    NSLog(@"- invocationContext=%@", invocationContext);
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"disconnectCallBack:";
    
    //    [aDFBean setMessage:@"Connected"];
    NSString *result = @"{\"status\": \"ok\",\"code\": 303200,\"message\": \"MQTT 서버에 접속종료가 완료 되었습니다.\"}";
    
    SEL sel = NSSelectorFromString(tempMethord);
    NSLog(@"Caller invoking method %@ \n", tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'disconnectCallBack' not defind \n");
        return;
    }
    
    //    [[ADFPush sharedADFPush] addLogMessage:@"DisConnected to server!" type:@"Action"];
    
    //    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //    [appDelegate updateConnectButton];
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"- invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    //    [[ADFPush sharedADFPush] addLogMessage:@"Failed to disconnect!" type:@"Action"];
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"disconnectCallBack:";
    
    //    [aDFBean setMessage:@"Connected"];
    NSString *result = @"{\"status\": \"fail\",\"code\": 303400,\"message\": \"MQTT 서버에 접속종료가 실패되었습니다\"}";
    
    SEL sel = NSSelectorFromString(tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'disconnectCallBack' not defind \n");
        return;
    }
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

// Subscribe Callbacks
@interface SubscribeCallbacks : NSObject <InvocationComplete>
- (void) onSuccess:(NSObject*) invocationContext;
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage;
@end
@implementation SubscribeCallbacks
- (void) onSuccess:(NSObject*) invocationContext
{
//    NSLog(@"- invocationContext=%@", invocationContext);

    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"subscribeCallBack:";
    
    NSMutableString * resultMu;
    resultMu = [[NSMutableString alloc]init];
    
    [resultMu appendFormat:@"{\"status\": \"ok\",\"code\": 305200,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독신청이 완료되었습니다\"}",invocationContext];
    NSString * result = resultMu;
    

    
    SEL sel = NSSelectorFromString(tempMethord);
    NSLog(@"Caller invoking method %@ \n", tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'subscribeCallBack' not defind \n");
        return;
    }
    
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
     NSLog(@"[ADFPush] SubscribeCallbacks - invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"subscribeCallBack:";
    
    NSMutableString * resultMu;
    resultMu = [[NSMutableString alloc]init];
    
    [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 305400,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독신청이 실패했습니다\"}",invocationContext];
    NSString * result = resultMu;
    
    
    
    SEL sel = NSSelectorFromString(tempMethord);
    NSLog(@"Caller invoking method %@ \n", tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'subscribeCallBack' not defind \n");
        return;
    }
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
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"unsubscribeCallBack:";
    
    NSMutableString * resultMu;
    resultMu = [[NSMutableString alloc]init];
    
    [resultMu appendFormat:@"{\"status\": \"ok\",\"code\": 306200,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독해제가 완료되었습니다\"}",invocationContext];
    NSString * result = resultMu;
    
    
    
    SEL sel = NSSelectorFromString(tempMethord);
   
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'unsubscribeCallBack' not defind \n");
        return;
    }
}
- (void) onFailure:(NSObject*) invocationContext errorCode:(int) errorCode errorMessage:(NSString*) errorMessage
{
    NSLog(@"[ADFPush] UnsubscribeCallbacks - invocationContext=%@  errorCode=%d  errorMessage=%@", invocationContext, errorCode, errorMessage);
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"subscribeCallBack:";
    
    NSMutableString * resultMu;
    resultMu = [[NSMutableString alloc]init];
    
    [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 306400,\"data\" : {\"topic\" : \"%@\"}, \"message\": \"구독해제가 실패했습니다\"}",invocationContext];
    NSString * result = resultMu;
    
    
    
    SEL sel = NSSelectorFromString(tempMethord);
    
    if ([tempResponder respondsToSelector:sel]) {
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, result);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'unsubscribeCallBack' not defind \n");
        return;
    }
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
    NSLog(@"errorMessage :%@", errorMessage);
//    [[[ADFPush sharedADFPush] subscriptionData] removeAllObjects];
    NSLog(@"errorMessage :%@", errorMessage);
    //    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //    [appDelegate updateConnectButton];
    //    [appDelegate reloadSubscriptionList];
}
- (void) onMessageArrived:(NSObject*)invocationContext message:(MqttMessage*)msg
{
    int qos = msg.qos;
    BOOL retained = msg.retained;
    //    NSString *payload = [[NSString alloc] initWithBytes:msg.payload length:msg.payloadLength encoding:NSASCIIStringEncoding];
    NSString *payload = [[NSString alloc] initWithBytes:msg.payload length:msg.payloadLength encoding:NSUTF8StringEncoding];
    //    NSString* aString = [[[NSString alloc] initWithString:payload encoding:0×80000840] autorelease];
    
    NSString *topic = msg.destinationName;
    NSString *retainedStr = retained ? @" [retained]" : @"";
    NSString *logStr = [NSString stringWithFormat:@"[%@ QoS:%d] %@%@", topic, qos, payload, retainedStr];
    NSLog(@"- %@", logStr);
    NSLog(@"GeneralCallbacks - onMessageArrived!");
    
    ///[sk]
    
    id tempResponder = [[ADFPush sharedADFPush] Responder];
    NSString *tempMethord = @"onMessageArrivedCallBack:";
    
    SEL sel = NSSelectorFromString(tempMethord);
    NSLog(@"Caller invoking method %@ \n", tempMethord);
//    [tempResponder performSelector: sel withObject: logStr];
    
    if ([tempResponder respondsToSelector:sel]) {
//        NSLog(@" SEL OK \n");
        IMP imp = [tempResponder methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *) imp;
        func(tempResponder, sel, logStr);
    } else {
        NSLog(@"[ADFPush] Warning : Method 'onMessageArrivedCallBack' not defind \n");
        return;
    }
    
    
    QueueFile  *queueFile = [[ADFPush sharedADFPush] jobQF];
    
    NSLog(@"QueueTest Length1 : %d", [queueFile size]);
    [queueFile add:dataForString(logStr)];
    NSLog(@"QueueTest Length2 : %d", [queueFile size]);
    
    
 
    return;
    
    ///[sk]

    

    //    [[ADFPush sharedADFPush] addLogMessage:logStr type:@"Subscribe"];
    
//    JsonUtil *jUtil = [[JsonUtil alloc]init];
    NSDictionary *dContent;
//    MappingJson *mJson = [[MappingJson alloc]init];
    NSString *userid = [[ADFPush sharedADFPush] userID];
    MessageBean *messageBean = [self messageToObjectMapping:payload userID:userid];
    
    if (messageBean == NULL) {
        return;
    }
    
    NSMutableString *tmpMS = [[NSMutableString alloc]init];
    //    PushDataBase *pDB = [[PushDataBase alloc]init];
//    PushDataBase *pDB = [[ADFPush sharedADFPush] pDB];
//    JobBean *job = [[JobBean alloc]init];
//    NSDictionary *pushInfo;
    //    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    NSArray *groups;
    NSMutableArray *subscribeList;
//    Subscription *sub;
    //    TopicBean *topicBean = [[TopicBean alloc]init];
    //    UIWebView *pWebView = [[ADFPush sharedADFPush] pWebView];
//    NSMutableString *javascriptFuntion = [[NSMutableString alloc]init];
    NSDate *today;
//    NSDate *dateNoti;
    
    NSMutableString *sendDate;
    NSDateFormatter *formatter;
    NSDate *pSendDate;
    NSDate *pSendDateAddOneDay;
    
    
    @try {
        // Message Insert
        //        [pDB insertMessage:messageBean];
        
        
        switch (messageBean.type) {
            case 0: // 개인메시지
            case 1: // 전체메시지
            case 2: // 그룹메시지(계열사)
            case 3: // 그룹메시지(부서)
            case 4: // 그룹메시지(직급)
                
                today = [NSDate date];
                sendDate = [[NSMutableString alloc]init];
                [sendDate appendFormat:@"%@ +0900",messageBean.sendDate];
                NSLog(@"======== sendDate:  %@", sendDate);
                
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss Z"];
                
                pSendDate = [[NSDate alloc] init];
                pSendDate = [formatter dateFromString:sendDate];
                NSLog(@"======== pSendDate:  %@", [pSendDate description]);
                
                // sendDate + 1 Day (24 * 3600 = 86400
                pSendDateAddOneDay = [NSDate dateWithTimeInterval:86400 sinceDate:pSendDate];
                NSLog(@"======== pSendDateAddOneDay:  %@", [pSendDateAddOneDay description]);
                
                // 두 날짜 비교 Compare - 하루가 지난 메세지 skip
                NSComparisonResult compareResult = [today compare:pSendDateAddOneDay];
                if(compareResult == -1) {
                    
                    NSLog(@"=======   today < pSendDateAddOneDay");
                    
                    messageBean.read = 1;
//                    [pDB insertMessage:messageBean];
                    if (messageBean.ack) {
                        [tmpMS appendFormat:@"{\"userID\":\"%@\",\"id\":%d}",userid, messageBean.id];
//                        [job setType:0]; //PUBLISH
//                        [job setTopic:@"/push/ack"];
//                        [job setContent:tmpMS];
                        
//                        [pDB insertJob:job];
                    }
                    
                    // WebView Load Finish Check
//                    if (!([[ADFPush sharedADFPush] webViewLoadFinish])) {
//                        NSLog(@"WebView가 아직 로드 되지 않았습니다.");
//                        break;
//                    }
                    
 
                    
                }
                
                
                break;
            case 100:
                // command msg
                // (토픽=/users/nadir93,메시지={"id":5,"ack":false,"type":1,"content":{"userID":"nadir93","groups":["dev","adflow"]}},qos=2)
                
                
                //기존 topic 가져와 unsubscribe 처리 - start
                messageBean.read = 0;
//                [pDB insertMessage:messageBean];
                
//                subscribeList = [[ADFPush sharedADFPush] subscriptionData];
                for (int i=0; i < subscribeList.count; i++) {
                    
//                    sub = [subscribeList objectAtIndex:i];
//                    [job setType:101]; //UNSUBSCRIBE
//                    [job setTopic:sub.topicFilter];
//                    [job setContent:@""];
                    
//                    [pDB insertJob:job];
                }
                //기존 topic 가져와 unsubscribe 처리 - end
                
                dContent = [self jSonToObject:messageBean.content];
                groups = dContent[@"groups"];
                
                for (int i=0; i < groups.count; i++) {
                    tmpMS = [[NSMutableString alloc]init];
                    [tmpMS appendFormat:@"/groups/%@", [groups objectAtIndex:i]];
//                    [job setType:100]; //SUBSCRIBE
//                    [job setTopic:tmpMS];
//                    [job setContent:@""];
                    
//                    [pDB insertJob:job];
                }
                
                
                break;
                
            case 101:
                // command msg
                // (토픽=/users/nadir93,메시지={"id":5,"ack":false,"type":1,"content":{"userID":"nadir93","groups":["dev","adflow"]}},qos=2)
                messageBean.read = 0;
//                [pDB insertMessage:messageBean];
                
                
                dContent = [self jSonToObject:messageBean.content];
                
                groups = dContent[@"groups"];
                
                for (int i=0; i < groups.count; i++) {
                    [tmpMS appendFormat:@"/groups/%@", [groups objectAtIndex:i]];
//                    [job setType:101]; //UNSUBSCRIBE
//                    [job setTopic:tmpMS];
//                    [job setContent:nil];
                    
//                    [pDB insertJob:job];
                }
                
                
                break;
                
            default:
                break;
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"onMessageArrived exceptionName %@, reason %@", [exception name], [exception reason]);
    }
}

- (void) onMessageDelivered:(NSObject*)invocationContext messageId:(int)msgId
{
    NSLog(@"GeneralCallbacks - onMessageDelivered!, messageID:%d", msgId);
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

-(MessageBean *) messageToObjectMapping:(NSString *)pPushMessage userID:(NSString *)userid{
    
    //    pPushMessage = @"{\"id\":6,\"ack\":true,\"type\":0,\"content\":{\"notification\":{\"notificationStyle\":1,\"contentTitle\":\"교육장소공지\",\"contentText\":\"교육장소공지입니다.\",\"ticker\":\"부산은행교육장소알림장소: 수림연수원 시간: 3월 22일 오전: 12시\",\"summaryText\":\"장소: 수림연수원 시간: 3월 22일 오전:1시\",\"image\":\"\"} } }";
    
    MessageBean *pMessage = [[MessageBean alloc]init];
//    JsonUtil *jUil = [[JsonUtil alloc]init];
    
    NSDictionary *dMessage = [self jSonToObject:pPushMessage];
    
    NSString *content = [self objectToJSon:dMessage[@"content"]];
    NSString *category = dMessage[@"category"];
    NSString *sendDate = dMessage[@"sendDate"];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date]; //현재 날짜로 객체 생성
    
    @try {
        [pMessage setId:[dMessage[@"id"] intValue]];
        [pMessage setUserid:userid];
        [pMessage setAck:[dMessage[@"ack"] intValue]];
        [pMessage setType:[dMessage[@"type"] intValue]];
        [pMessage setContent:content];
        [pMessage setReceivedate:[dateFormat stringFromDate:now]];
        [pMessage setRead:1];
        [pMessage setCategory:category];
        [pMessage setSendDate:sendDate];
    }
    @catch (NSException *exception) {
        NSLog(@"Mapping exceptionName %@, reason %@", [exception name], [exception reason]);
        return NULL;
    }
    
    return pMessage;
    
}



@end





@implementation ADFPush
@synthesize client;

static float JOBINTERVAL = 10.0f;
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
        self.userID = nil;
        self.Responder = nil;
        self.client.callbacks = [[GeneralCallbacks alloc] init];

        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath =
        [documentsDirectory stringByAppendingPathComponent:@"job.q"];
        self.jobQF = [QueueFile queueFileWithPath:filePath];
        filePath = [documentsDirectory stringByAppendingPathComponent:@"jobLog.q"];
        self.jobLogQF = [QueueFile queueFileWithPath:filePath];
        self.messageADF = nil;
        
        
        
        //Job Background loop run - start
        [NSTimer scheduledTimerWithTimeInterval:JOBINTERVAL target:self selector:@selector(jobAgent) userInfo:nil repeats:YES];
        //Job Background loop run - start
        
        NSLog(@"============   Background start");
        
    }
    return self;
}


- (void)connectMQTT:(NSArray *)hosts ports:(NSArray *)ports cleanSession:(BOOL)cleanSession
{
    // Job Logging
    [self addJobLog:@"connectMQTT" param1:hosts[1] param2:ports[1] param3:(cleanSession)? @"true" : @"false"];
    
    NSString * clientId = [[ADFPush sharedADFPush] getTokenMQTT];
    client = [client initWithHosts:hosts ports:ports clientId:clientId];
    ConnectOptions *opts = [[ConnectOptions alloc] init];
    opts.timeout = 3600;
    opts.cleanSession = cleanSession;
    
//    SSLOptions *ssloti = [[SSLOptions alloc] init];
//    ssloti.enableServerCertAuth = FALSE;
//    opts.sslProperties = ssloti;
    
    
    NSLog(@"host=%@, port=%@, clientId=%@, cleanSession=%@", hosts, ports, clientId,  (cleanSession)? @"true" : @"false");
    [client connectWithOptions:opts invocationContext:self onCompletion:[[ConnectCallbacks alloc] init]];
}



- (void)disconnectMQTT:(int)timeout {
    
    // Job Logging
    [self addJobLog:@"disconnectMQTT" param1:[NSString stringWithFormat: @"%d", timeout]  param2:@"" param3:@""];
    
    DisconnectOptions *opts = [[DisconnectOptions alloc] init];
    [opts setTimeout:timeout];
    
    [client disconnectWithOptions:opts invocationContext:self onCompletion:[[DisConnectCallbacks alloc] init]];
}

- (void)publish:(NSString *)topic payload:(NSString *)payload qos:(int)qos retained:(BOOL)retained
{
    
    // Job Logging
    [self addJobLog:@"publish" param1:topic  param2:[NSString stringWithFormat: @"%d", qos] param3:(retained)? @"true" : @"false"];
    
    NSLog(@"=========== playload1 :%@", payload);
    
    NSString *retainedStr = retained ? @" [retained]" : @"";
    NSString *logStr = [NSString stringWithFormat:@"[%@] %@%@", topic, payload, retainedStr];
    NSLog(@"- %@", logStr);
    //    [[ADFPush sharedADFPush] addLogMessage:logStr type:@"Publish"];
    
    NSLog(@"=========== playload2 :%@", payload);
    MqttMessage *msg = [[MqttMessage alloc] initWithMqttMessage:topic payload:(char*)[payload UTF8String] length:(int)payload.length qos:qos retained:retained duplicate:NO];
    NSLog(@"=========== msg :%@", msg);
    
//    [client send:msg invocationContext:self onCompletion:[[PublishCallbacks alloc] init]];
    [client send:msg invocationContext:@"test" onCompletion:[[PublishCallbacks alloc] init]];
}

- (void)subscribeMQTT:(NSString *)topicFilter qos:(int)qos
{
    // Job Logging
    [self addJobLog:@"subscribeMQTT" param1:topicFilter param2:[NSString stringWithFormat: @"%d", qos]   param3:@""];
    
    NSLog(@"topicFilter=%@, qos=%d", topicFilter, qos);
    NSLog(@"=====  subscribe start");
    
    
    [client subscribe:topicFilter qos:qos invocationContext:topicFilter onCompletion:[[SubscribeCallbacks alloc] init]];
    
    NSLog(@"=====  subscribe end");
    
}

- (void)unsubscribeMQTT:(NSString *)topicFilter
{
    // Job Logging
    [self addJobLog:@"unsubscribeMQTT" param1:topicFilter  param2:@"" param3:@""];
    
    NSLog(@"topicFilter=%@", topicFilter);
    [client unsubscribe:topicFilter invocationContext:topicFilter onCompletion:[[UnsubscribeCallbacks alloc] init]];
}

-(void)jobAgent {
    
    QueueFile  *queueFile = [[ADFPush sharedADFPush] jobQF];
    
    int qSize = [queueFile size];
    for (int i=0; i < qSize; i++) {
        
        NSLog(@"QueueTest Length1 : %d", [queueFile size]);
        
        NSString *queMsg = [NSString stringWithUTF8String:[[queueFile peek] bytes]];
        
        NSLog(@"QueueTest msg : %@", queMsg);
        
        [queueFile remove];
        
        NSLog(@"QueueTest Length2 : %d", [queueFile size]);
    }
    
//    if ([queueFile size] > 0) {
//        
//        NSLog(@"QueueTest Length1 : %d", [queueFile size]);
//        
//        NSString *queMsg = [NSString stringWithUTF8String:[[queueFile peek] bytes]];
//        
//        NSLog(@"QueueTest msg : %@", queMsg);
//        
//        [queueFile remove];
//        
//        NSLog(@"QueueTest Length2 : %d", [queueFile size]);
//    }
    
    
}

- (NSString *)registerToken:(NSString *)token{
    
    // Job Logging
    [self addJobLog:@"unsubscribeMQTT" param1:token  param2:@"" param3:@""];
    
     NSString * result = nil;
    
    if (token.length < 24) {
        
        @try {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath =
            [documentsDirectory stringByAppendingPathComponent:@"token.q"];
            QueueFile  * tokenQ = [QueueFile queueFileWithPath:filePath];
            
            [tokenQ clear];
            // token Queue insert
            [tokenQ add:dataForString(token)];
            
            
            
            result = @"{\"status\": \"ok\",\"code\": 301200,\"message\": \"토큰등록이 완료되었습니다\"}";
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"[ADFError] NSException: %@", exception);
//            result = @"{\"status\": \"fail\",\"code\": 301400,\"message\": \"토큰등록이 실패되었습니다\"}";
            NSMutableString * resultMu;
            resultMu = [[NSMutableString alloc]init];
            
            [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 301500,\"message\": \"%@\"}",exception];
            result = resultMu;
        }
        @finally {
            
        }
    } else {
        
        NSLog(@"[ADFError] token length error - token: %@", token);
        result = @"{\"status\": \"fail\",\"code\": 301401,\"message\": \"토큰길이가 큽니다.\"}";
    }
    
    
    return result;
}

- (NSString *)getTokenMQTT{
    
    // Job Logging
    [self addJobLog:@"getTokenMQTT" param1:@""  param2:@"" param3:@""];
    
    NSString * result;
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath =
        [documentsDirectory stringByAppendingPathComponent:@"token.q"];
        QueueFile  * tokenQ = [QueueFile queueFileWithPath:filePath];
        
        // token Queue read
        NSString *token = [NSString stringWithUTF8String:[[tokenQ peek] bytes]];
        
        NSMutableString * resultMu;
        resultMu = [[NSMutableString alloc]init];
        
        [resultMu appendFormat:@"{\"status\": \"ok\",\"data\":{ \"token\":\"%@\"},\"code\": 310200,\"message\": \"토큰 가져오기가  완료 되었습니다\"}",token];
        result = resultMu;
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);

        NSMutableString * resultMu;
        resultMu = [[NSMutableString alloc]init];
        
        [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 301500,\"message\": \"%@\"}",exception];
        result = resultMu;
    }
    @finally {
        
    }
    
    
    return result;
}

- (NSString *)connectStateMQTT{
    
    // Job Logging
    [self addJobLog:@"connectStateMQTT" param1:@""  param2:@"" param3:@""];
    
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

        NSMutableString * resultMu;
        resultMu = [[NSMutableString alloc]init];
        
        [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 304500,\"message\": \"%@\"}",exception];
        result = resultMu;
    }
    @finally {
        
    }
    return result;
}

- (NSString *)cleanJobQueue{
    // Job Logging
    [self addJobLog:@"cleanJobQueue" param1:@""  param2:@"" param3:@""];
    
    NSString * result;
    
    @try {
        
        QueueFile  * jobQ = [ [ADFPush sharedADFPush] jobQF];
        
        [jobQ clear];
        
        result = @"{\"status\": \"ok\",\"code\": 308200,\"message\": \"작업큐 초기화가 완료되었습니다\"}";
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
        //            result = @"{\"status\": \"fail\",\"code\": 301400,\"message\": \"토큰등록이 실패되었습니다\"}";
        NSMutableString * resultMu;
        resultMu = [[NSMutableString alloc]init];
        
        [resultMu appendFormat:@"{\"status\": \"fail\",\"code\": 308500,\"message\": \"%@\"}",exception];
        result = resultMu;
    }
    @finally {
        
    }
    return result;
}

- (void) addJobLog:(NSString *)jobName param1:(NSString *) param1 param2:(NSString *) param2 param3:(NSString *) param3{
    
    @try {
        NSMutableString * resultMu;
        resultMu = [[NSMutableString alloc]init];
        NSDate *now = [NSDate date]; //현재 날짜로 객체 생성
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss:SS"];
        NSString *dateString = [dateFormat stringFromDate:now];
        
        [resultMu appendFormat:@"{\"date\": \"%@\",\"jobName\": \"%@=%@=%@=%@\"}",dateString, jobName,param1,param2,param3];
        
        
        QueueFile * jobLogQF = [ [ADFPush sharedADFPush] jobLogQF];
        if ([jobLogQF size] > 3000) {
            [jobLogQF remove];
        }
        [jobLogQF add:dataForString(resultMu)];
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
    }
}


@end


