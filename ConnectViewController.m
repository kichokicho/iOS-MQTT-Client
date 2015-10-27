//
//  TestViewController.m
//  MQTTTest
//
//  Created by Bryan Boyd on 12/5/13.
//  Copyright (c) 2013 Bryan Boyd. All rights reserved.
//

#import "ConnectViewController.h"
#import "ADFPush.h"
#import "AppDelegate.h"
#include <stdlib.h>
//#import "Responder.h"

@implementation ConnectViewController

+ (NSString*) uniqueId {
    return [NSString stringWithFormat: @"MQTTTest.%d", arc4random_uniform(10000)];
}

+ (NSArray*) parseCommaList:(NSString*)field {
    return [field componentsSeparatedByString:@","];
}

- (void)setResultText:(NSString *)setResultText{
    
    self.resultTextView.text = setResultText;
}

- (IBAction)connectPressed:(id)sender {
    // sender will always be self.testButton
     [[ADFPush sharedADFPush] connectMQTT];
   

}
- (IBAction)isConnectPressed:(id)sender {
    
    NSString *result = [[ADFPush sharedADFPush] connectStateMQTT];
    
    self.resultTextView.text = result;
}

- (IBAction)disconnectPressed:(id)sender {
    
     [[ADFPush sharedADFPush] disconnectMQTT:5];
}


- (IBAction)cleanSessionChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
//    NSLog(@"cleanSession changed to: %d", self.cleanSession.isOn);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.connectView = self;
    
    NSLog(@"%s:%d", __func__, __LINE__);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    if (textField.tag == 1) {
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
