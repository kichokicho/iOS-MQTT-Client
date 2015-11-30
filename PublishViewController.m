//
//  PublishViewController.m
//  MQTTTest
//
//  Created by Bryan Boyd on 12/8/13.
//  Copyright (c) 2013 Bryan Boyd. All rights reserved.
//

#import "PublishViewController.h"
#import "ADFPush.h"
#import "AppDelegate.h"

@interface PublishViewController ()
@property (weak, nonatomic) IBOutlet UITextField *topicInput;
@property (weak, nonatomic) IBOutlet UITextField *payloadInput;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UISwitch *retainedSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qos;

@end

@implementation PublishViewController

- (IBAction)publishPressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    
    NSString *topic = self.topicInput.text;
    NSString *payload = self.payloadInput.text;
    
    [[ADFPush sharedADFPush] publish:topic payload:payload qos:(int)self.qos.selectedSegmentIndex retained:self.retainedSwitch.isOn];
}

- (IBAction)retainedChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"retained changed to: %d", self.retainedSwitch.isOn);
}

- (IBAction)qosSegmentChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"qos changed to: %ld", (long)self.qos.selectedSegmentIndex);
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
    
    NSLog(@"%s:%d", __func__, __LINE__);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.publishView = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
