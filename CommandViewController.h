//
//  CommandViewController.h
//  iOS-MQTT-Client
//
//  Created by gwangil on 2015. 10. 26..
//  Copyright © 2015년 Bryan Boyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommandViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UITextField *tokenText;

- (void)setResultText:(NSString *)setResultText;
@end
