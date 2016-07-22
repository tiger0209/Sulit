//
//  KNThirdViewController.h
//  KNSemiModalViewControllerDemo
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUTableView;

@interface KNThirdViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *_textField;
}
@property (unsafe_unretained, nonatomic) IBOutlet UILabel           *helpLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton          *dismissButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton          *resizeButton;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView       *m_tableView;

@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar                     *toolbar;
@property (nonatomic, strong) UIScrollView                  *scrollView;

@property (nonatomic, strong) NSString                      *m_min_Price;
@property (nonatomic, strong) NSString                      *m_max_Price;
@property (nonatomic, strong) NSString                      *m_Brand;

- (IBAction)dismissButtonDidTouch:(id)sender;
- (IBAction)resizeSemiModalView:(id)sender;

@end
