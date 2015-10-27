//
//  ADFPushEnvViewController.m
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 10. 26..
//  Copyright © 2015년 Bryan Boyd. All rights reserved.
//

#import "ADFPushEnvViewController.h"
#import "ADFPush.h"

@implementation ADFPushEnvViewController

+ (NSArray*) parseCommaList:(NSString*)field {
    return [field componentsSeparatedByString:@","];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerADFPushEnvPressed:(id)sender {
    
    NSArray *servers = [ADFPushEnvViewController parseCommaList:self.serverInput.text];
    NSArray *ports = [ADFPushEnvViewController parseCommaList:self.portInput.text];
    NSString *token = self.tokenInput.text;
    NSString *adfPushServerUrl = self.adfPushUrl.text;
    
    NSString * result = [[ADFPush sharedADFPush] registerADFPushEnv:servers ports:ports cleanSesstion:self.cleanSession.isOn token:token adfPushServerUrl:adfPushServerUrl];
    
    NSLog(@"result : %@",result);
    
}
- (IBAction)clearPressed:(id)sender {
    
     NSLog(@"clearPressed");
    
    self.serverInput.text = @"";
    self.portInput.text = @"";
    self.keepAliveLabel.text = @"0";
    self.tokenInput.text = @"";
    self.adfPushUrl.text = @"";
    [self.cleanSession setOn:true];
    
    
}
- (IBAction)getPressed:(id)sender {
    
     NSLog(@"getPressed");
    
    @try {
        NSString * result = [[ADFPush sharedADFPush] getAdfPushEnv];
        NSLog(@"result : %@",result);
        
        NSData *jData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"hosts] : %@",json[@"data"][@"hosts"][0]);
        //    [self.serverInput setText:json[@"data"][@"hosts"][0]];
        self.serverInput.text = json[@"data"][@"hosts"][0];
        self.portInput.text = json[@"data"][@"ports"][0];
        self.keepAliveLabel.text = [NSString stringWithFormat:@"%d",[json[@"data"][@"mqttKeepAliveInterval"]intValue]];
        self.tokenInput.text = json[@"data"][@"token"];
        self.adfPushUrl.text = json[@"data"][@"adfPushServerUrl"];
        [self.cleanSession setOn:[json[@"data"][@"cleanSesstion"]boolValue]];
    }
    @catch (NSException *exception) {
        NSLog(@"[ADFError] NSException: %@", exception);
    }
    
    

    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
