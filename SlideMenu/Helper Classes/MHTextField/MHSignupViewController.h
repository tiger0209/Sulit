//
//  MHSignupViewController.h
//  MHTextField
//
//  Created by Mehfuz Hossain on 2/27/14.
//  Copyright (c) 2014 Mehfuz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"
#import "SlideNavigationController.h"

@interface MHSignupViewController : UIViewController<SlideNavigationControllerDelegate>
{
    NSMutableData      *receivedHomeViewData;
    NSMutableArray     *m_newData;

}
@property (strong, nonatomic) IBOutlet DemoTextField *emailTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *phoneTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *ageTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *zipTextField;

- (IBAction)createAccount:(id)sender;

@end
