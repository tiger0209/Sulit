//
//  JSViewController.h
//  iOS8Style-ImagePicker
//
//  Created by Jake Sieradzki on 09/01/2015.
//  Copyright (c) 2015 Jake Sieradzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@class CategoryTypeSelViewController;

@interface JSViewController : UIViewController<SlideNavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITextField *_textField;
    UITextView  *_m_textView;
    
    CategoryTypeSelViewController * semiVC;
    
    int             m_category_type;
}

- (IBAction)showBtnWasPressed1:(id)sender;
- (IBAction)showBtnWasPressed2:(id)sender;
- (IBAction)showBtnWasPressed3:(id)sender;
- (IBAction)showBtnWasPressed4:(id)sender;
- (IBAction)clickListItemBtn:(id)sender;
- (IBAction)clickCategoryBtn:(id)sender;

@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar                     *toolbar;
@property (nonatomic, strong) UIToolbar                     *toolbar1;

@property (nonatomic, weak)  IBOutlet UIScrollView          *m_scrollView;

@property (nonatomic, weak) IBOutlet UIButton               *imageView1;
@property (nonatomic, weak) IBOutlet UIButton               *imageView2;
@property (nonatomic, weak) IBOutlet UIButton               *imageView3;
@property (nonatomic, weak) IBOutlet UIButton               *imageView4;

@property (nonatomic, weak) IBOutlet UIButton               *listItemsBtn;

@property (nonatomic, weak) IBOutlet UITableView            *m_tableView;

@property (nonatomic, strong) IBOutlet UITextView             *m_textView;

@property (nonatomic, assign) int    m_index;

@property (nonatomic, strong) NSString                      *m_PTitle;
@property (nonatomic, strong) NSString                      *m_PComment;
@property (nonatomic, strong) NSString                      *m_PPrice;
@property (nonatomic, strong) NSString                      *m_PPriceUnit;


@end
