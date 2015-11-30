//
//  CommandViewController.m
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 10. 26..
//  Copyright © 2015년 Bryan Boyd. All rights reserved.
//

#import "CommandViewController.h"
#import "ADFPush.h"
#import "AppDelegate.h"

@implementation CommandViewController
- (IBAction)registerTokenPressed:(id)sender {
    NSString * result = [[ADFPush sharedADFPush] registerToken:self.tokenText.text];
    
    self.resultTextView.text = result;
    
}
- (IBAction)getTokenMQTTPressed:(id)sender {
    NSString * result = [[ADFPush sharedADFPush] getTokenMQTT];
    
    self.resultTextView.text = result;
}
- (IBAction)cleanJobQueuePressed:(id)sender {
    
    NSString * result = [[ADFPush sharedADFPush] cleanJobQueue];
    
    self.resultTextView.text = result;
}
- (IBAction)getSubscriptionsPressed:(id)sender {
    
    [[ADFPush sharedADFPush] getSubscriptions];
    
//    self.resultTextView.text = result;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s:%d", __func__, __LINE__);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.commandView = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResultText:(NSString *)setResultText{
    
    self.resultTextView.text = setResultText;
}

@end
