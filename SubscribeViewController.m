//
//  SubscribeViewController.m
//  MQTTTest
//
//  Created by Bryan Boyd on 12/8/13.
//  Copyright (c) 2013 Bryan Boyd. All rights reserved.
//

#import "SubscribeViewController.h"
#import "ADFPush.h"
#import "Subscription.h"
#import "AppDelegate.h"

@interface SubscribeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *topicInput;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qos;
@property (weak, nonatomic) IBOutlet UIButton *unsubscribeButton;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end

@implementation SubscribeViewController

- (void)setResultText:(NSString *)setResultText{
    
    self.resultTextView.text = setResultText;
}

- (IBAction)subscribePressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    
//    NSString *topic = self.topicInput.text;
    
    [[ADFPush sharedADFPush] subscribeMQTT:self.topicInput.text qos:(int)self.qos.selectedSegmentIndex];
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
    appDelegate.subscribeView = self;
//    appDelegate.subListView = self.subListTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Text Field delegate implementations
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

# pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
//    ADFPush *ADFPush = [ADFPush sharedADFPush];
//    return [ADFPush.subscriptionData count];
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubscriptionPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    ADFPush *ADFPush = [ADFPush sharedADFPush];
//    Subscription *subscription = [ADFPush.subscriptionData objectAtIndex:indexPath.row];
//    cell.textLabel.text = subscription.topicFilter;
    cell.textLabel.text = @"test";
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        ADFPush *ADFPush = [ADFPush sharedADFPush];
//        Subscription *sub = [ADFPush.subscriptionData objectAtIndex:indexPath.row];
//        
//        [ADFPush unsubscribe:sub.topicFilter];
//        
//        [self.subListTable deselectRowAtIndexPath:indexPath animated:TRUE];
//
//        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        [appDelegate reloadSubscriptionList];
    }
}
- (IBAction)unsubscribePressed:(id)sender {
//    NSArray* rows = [self.subListTable indexPathsForSelectedRows];
//    for (id idx in rows) {
//        NSIndexPath *index = (NSIndexPath *)idx;
//        [self tableView:self.subListTable commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:index];
//    }
    [[ADFPush sharedADFPush] unsubscribeMQTT:self.topicInput.text];
}

@end
