//
//  JobBean.h
//  CertTest2
//
//  Created by gwangil on 2014. 6. 26..
//  Copyright (c) 2014년 kamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobBean : NSObject

@property int id;
@property int msgtype;
@property int ack;
@property int qos;
@property (nonatomic, retain) NSString *msgid;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *contenttype;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSString *serviceid;

@end
