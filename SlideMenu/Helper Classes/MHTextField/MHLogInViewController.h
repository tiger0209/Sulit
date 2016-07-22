//
//  MHLogInViewController.h
//  MHTextField
//
//  Created by Mehfuz Hossain on 2/27/14.
//  Copyright (c) 2014 Mehfuz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"
#import "SlideNavigationController.h"

@interface MHLogInViewController : UIViewController<SlideNavigationControllerDelegate>
{
    NSMutableData      *receivedHomeViewData;
    NSMutableArray     *m_newData;

}
@property (strong, nonatomic) IBOutlet DemoTextField *usernameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton      *m_SignUpBtn;
@property (strong, nonatomic) IBOutlet UILabel       *m_quesLabel;

- (IBAction)logIn:(id)sender;
- (IBAction)clickSignUpBtn:(id)sender;

@end
