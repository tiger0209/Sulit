//
//  ProfileDetailViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/25/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "HMSegmentedControl.h"
#import <MessageUI/MessageUI.h>


@interface ProfileDetailViewController : UIViewController <SlideNavigationControllerDelegate, MFMailComposeViewControllerDelegate>
{
    NSMutableData           *receivedHomeViewData;
    NSMutableArray     *m_newData;
    NSMutableArray     *m_img_array;
    BOOL               mb_fromProfileBtn;
}

@property (nonatomic, assign)     BOOL                          mb_fromProfileBtn;
@property (weak, nonatomic)       IBOutlet UICollectionView     *cv;

@property (nonatomic, readwrite)  IBOutlet UIButton             *m_btn_email;
@property (nonatomic, readwrite)  IBOutlet UIButton             *m_btn_facebook;
@property (nonatomic, readwrite)  IBOutlet UIButton             *m_btn_phone;
@property (nonatomic, readwrite)  IBOutlet UIButton             *m_btn_twitter;

@property (nonatomic, readwrite)  IBOutlet UITextView           *m_textView_About;
@property (nonatomic, readwrite)  IBOutlet UITextView           *m_textView_Review;

@property (nonatomic, readwrite)  IBOutlet UIImageView           *m_photoView;

//////lgilgilgi
- (IBAction)clickEmailIconBtn:(id)sender;
- (IBAction)clickPhoneIconBtn:(id)sender;
- (IBAction)clickFacebookIconBtn:(id)sender;
- (IBAction)clickTwitterIconBtn:(id)sender;
- (IBAction)clickUploadBtn:(id)sender;

- (void)clickSettingBtn;
@end
