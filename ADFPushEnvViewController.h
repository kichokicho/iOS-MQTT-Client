//
//  ADFPushEnvViewController.h
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 10. 26..
//  Copyright © 2015년 Bryan Boyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADFPushEnvViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *serverInput;
@property (weak, nonatomic) IBOutlet UITextField *portInput;
@property (weak, nonatomic) IBOutlet UITextField *tokenInput;
@property (weak, nonatomic) IBOutlet UITextField *adfPushUrl;
@property (weak, nonatomic) IBOutlet UISwitch *cleanSession;
@property (weak, nonatomic) IBOutlet UILabel *keepAliveLabel;

@end
