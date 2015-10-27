//
//  TestViewController.h
//  MQTTTest
//
//  Created by Bryan Boyd on 12/5/13.
//  Copyright (c) 2013 Bryan Boyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

- (void)setResultText:(NSString *)setResultText;
@end
