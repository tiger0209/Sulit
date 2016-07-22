//
//  ProfileDetailViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/25/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LogInOutController : UIViewController <SlideNavigationControllerDelegate>

@property (nonatomic, readwrite) IBOutlet UIButton       *m_LogInBtn;

-(IBAction)clickLogOInBtn:(id)sender;

@end
