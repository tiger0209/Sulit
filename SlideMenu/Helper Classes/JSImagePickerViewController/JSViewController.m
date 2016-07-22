//
//  JSViewController.m
//  iOS8Style-ImagePicker
//
//  Created by Jake Sieradzki on 09/01/2015.
//  Copyright (c) 2015 Jake Sieradzki. All rights reserved.
//

#import "JSViewController.h"
#import "JSImagePickerViewController.h"

#import "PPrice_TableViewCell.h"
#import "PComment_TableViewCell.h"
#import "PCategory_TableViewCell.h"
#import "PTitle_TableViewCell.h"

#import "AppDelegate.h"

#import "UIViewController+KNSemiModal.h"
#import "CategoryTypeSelViewController.h"

#define kSemiModalDidShowNotification @"kSemiModalDidShowNotification"
#define kSemiModalDidHideNotification @"kSemiModalDidHideNotification"
#define kSemiModalWasResizedNotification @"kSemiModalWasResizedNotification"


@interface JSViewController () <JSImagePickerViewControllerDelegate>

@property (nonatomic) BOOL keyboardIsShown;
@property (nonatomic) CGSize keyboardSize;
@property (nonatomic) BOOL hasScrollView;
@property (nonatomic) BOOL invalid;

@property (nonatomic, setter = setToolbarCommand:) BOOL isToolBarCommand;
@property (nonatomic, setter = setDoneCommand:) BOOL isDoneCommand;


@property (nonatomic , strong) UIBarButtonItem *previousBarButton;
@property (nonatomic , strong) UIBarButtonItem *nextBarButton;

@property (nonatomic, strong) NSMutableArray *textFields;

@property (weak) id keyboardDidShowNotificationObserver;
@property (weak) id keyboardWillHideNotificationObserver;

@end

@implementation JSViewController

@synthesize m_index;

@synthesize m_tableView;


@synthesize required;
@synthesize m_scrollView;
@synthesize toolbar;
@synthesize toolbar1;
@synthesize keyboardIsShown;
@synthesize keyboardSize;
@synthesize invalid;


@synthesize m_PTitle;
@synthesize m_PComment;
@synthesize m_PPrice;
@synthesize m_PPriceUnit;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /////lgilgilgi modal view effect
    semiVC = [[CategoryTypeSelViewController alloc] initWithNibName:@"CategoryTypeSelViewController" bundle:nil];
    // You can optionally listen to notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(semiModalPresented:)
                                                 name:kSemiModalDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(semiModalDismissed:)
                                                 name:kSemiModalDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(semiModalResized:)
                                                 name:kSemiModalWasResizedNotification
                                               object:nil];

    
    [self.m_tableView registerNib:[UINib nibWithNibName:@"PPrice_TableViewCell" bundle:nil]
           forCellReuseIdentifier:@"PPrice_TableViewCell"];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"PTitle_TableViewCell" bundle:nil]
           forCellReuseIdentifier:@"PTitle_TableViewCell"];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"PCategory_TableViewCell" bundle:nil]
           forCellReuseIdentifier:@"PCategory_TableViewCell"];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"PComment_TableViewCell" bundle:nil]
           forCellReuseIdentifier:@"PComment_TableViewCell"];

    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    NSArray *barButtonItems = @[/*self.previousBarButton, self.nextBarButton,*/ flexBarButton, doneBarButton];
    toolbar.items = barButtonItems;
    
    
    
    toolbar1 = [[UIToolbar alloc] init];
    toolbar1.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // set style
    [toolbar1 setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexBarButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done1ButtonIsClicked:)];
    NSArray *barButtonItems1 = @[/*self.previousBarButton, self.nextBarButton,*/ flexBarButton1, doneBarButton1];
    toolbar1.items = barButtonItems1;

    
    self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView1.backgroundColor = [UIColor colorWithRed:0.616 green:0.825 blue:1.000 alpha:1.000];
    self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView2.backgroundColor = [UIColor colorWithRed:0.616 green:0.825 blue:1.000 alpha:1.000];
    self.imageView3.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView3.backgroundColor = [UIColor colorWithRed:0.616 green:0.825 blue:1.000 alpha:1.000];
    self.imageView4.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView4.backgroundColor = [UIColor colorWithRed:0.616 green:0.825 blue:1.000 alpha:1.000];
    
    
    self.imageView1.layer.masksToBounds = YES;
    self.imageView1.layer.cornerRadius = 3;
    self.imageView2.layer.masksToBounds = YES;
    self.imageView2.layer.cornerRadius = 3;
    self.imageView3.layer.masksToBounds = YES;
    self.imageView3.layer.cornerRadius = 3;
    self.imageView4.layer.masksToBounds = YES;
    self.imageView4.layer.cornerRadius = 3;
    
    self.listItemsBtn.layer.masksToBounds = YES;
    self.listItemsBtn.layer.cornerRadius = 5;
    
    [self.m_tableView reloadData];
}

- (void) semiModalResized:(NSNotification *) notification {
    if(notification.object == self){
        NSLog(@"The view controller presented was been resized");
    }
}

- (void)semiModalPresented:(NSNotification *) notification {
    if (notification.object == self) {
        NSLog(@"This view controller just shown a view with semi modal annimation");
    }
}
- (void)semiModalDismissed:(NSNotification *) notification {
    if (notification.object == self) {
        NSLog(@"A view controller was dismissed with semi modal annimation");
        
        m_category_type = semiVC.m_category_type;
        [self.m_tableView reloadData];

    }
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePickerDidSelectImage:(UIImage *)image {
    switch (self.m_index) {
        case 1:
            [self.imageView1 setBackgroundImage:image forState:UIControlStateNormal];
            break;
        case 2:
            [self.imageView2 setBackgroundImage:image forState:UIControlStateNormal];
            break;
        case 3:
            [self.imageView3 setBackgroundImage:image forState:UIControlStateNormal];
            break;
        case 4:
            [self.imageView4 setBackgroundImage:image forState:UIControlStateNormal];
            break;            
        default:
            break;
    }
}

- (IBAction)showBtnWasPressed1:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    self.m_index = 1;
}

- (IBAction)showBtnWasPressed2:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    self.m_index = 2;
}

- (IBAction)showBtnWasPressed3:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    self.m_index = 3;
}

- (IBAction)showBtnWasPressed4:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    self.m_index = 4;
}

- (IBAction)clickListItemBtn:(id)sender {
    NSLog(@"=======Click List Item Btn==========");
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];
 
}


#pragma TableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}



#pragma TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    NSLog(@"===indexPath.section %d indexPath.row = %d=====", indexPath.section, indexPath.row);
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        PTitle_TableViewCell* cell = (PTitle_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PTitle_TableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.m_titleField setDelegate:self];
        return cell;
    }
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        PComment_TableViewCell* cell1 = (PComment_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PComment_TableViewCell" forIndexPath:indexPath];
//        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell1.m_Comment setDelegate:self];
//        return cell1;
//    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        PCategory_TableViewCell* cell2 = (PCategory_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PCategory_TableViewCell" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (m_category_type == 0) {
            [cell2.m_CategoryName setTitle:@"Select your category" forState:UIControlStateNormal];
        }else{
            NSDictionary *v_dic = [[AppDelegate sharedInstance].m_newCategoryName objectAtIndex:m_category_type-1];
//            int v_id = [[v_dic objectForKey:@"id"] integerValue];
            NSString *v_catName = [v_dic objectForKey:@"category"];
            
            [cell2.m_CategoryName setTitle:v_catName forState:UIControlStateNormal];
        }
        
        
        [cell2.m_CategoryName setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cell2.m_CategoryName addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell2;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {         PPrice_TableViewCell* cell3 = (PPrice_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PPrice_TableViewCell" forIndexPath:indexPath];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell3.m_priceField setDelegate:self];
        [cell3.m_priceUnitField setDelegate:self];
        return cell3;
    }
    //return cell;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    NSString *v_title;
//    return v_title;
//}

- (void)scrollToField
{
    CGRect textFieldRect = [[_textField superview] convertRect:_textField.frame toView:self.view];
    CGRect aRect = self.view.bounds;
    
    NSLog(@"m_tableView.contentOffset.y = %f", m_scrollView.contentOffset.y);
    NSLog(@"keyboardSize.height = %f", keyboardSize.height);
    NSLog(@"self.toolbar.frame.size.height = %f", self.toolbar.frame.size.height);
    
    
    aRect.origin.y = -m_scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + self.toolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || m_scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0f, self.m_scrollView.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0)
            scrollPoint.y = 0;
        
        [self.m_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)scrollToTextView
{
    CGRect textFieldRect = [[_m_textView superview] convertRect:_m_textView.frame toView:self.view];
    CGRect aRect = self.view.bounds;
    
    NSLog(@"m_tableView.contentOffset.y = %f", m_scrollView.contentOffset.y);
    NSLog(@"keyboardSize.height = %f", keyboardSize.height);
    NSLog(@"self.toolbar.frame.size.height = %f", self.toolbar.frame.size.height);
    
    
    aRect.origin.y = -m_scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + self.toolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || m_scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0f, self.m_scrollView.frame.origin.y + _m_textView.frame.origin.y + _m_textView.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0)
            scrollPoint.y = 0;
        
        scrollPoint.y -= 30;
        [self.m_scrollView setContentOffset:scrollPoint animated:YES];
    }
}


#pragma mark - UIKeyboard notifications

- (void) keyboardDidShow:(NSNotification *) notification{
    if (_textField== nil && _m_textView == nil)
        return;
    if (keyboardIsShown)
        return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    if (_textField != nil) {
        [self scrollToField];
    }
    else if (_m_textView != nil) {
        [self scrollToTextView];
    }
    
    self.keyboardIsShown = YES;
}

- (void) keyboardWillHide:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (_isDoneCommand){
            [self.m_scrollView setContentOffset:CGPointMake(0, -m_scrollView.contentInset.top) animated:NO];
        }
    }];
    
    keyboardIsShown = NO;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardDidShowNotificationObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardWillHideNotificationObserver];
}

#pragma mark - UITextField notifications

- (void)setBarButtonNeedsDisplayAtTag:(NSInteger)tag{
    BOOL previousBarButtonEnabled = NO;
    BOOL nexBarButtonEnabled = NO;
    
    for (int index = 0; index < [self.textFields count]; index++) {
        
        UITextField *textField = [self.textFields objectAtIndex:index];
        
        if (index < tag)
            previousBarButtonEnabled |= textField.isEnabled;
        else if (index > tag)
            nexBarButtonEnabled |= textField.isEnabled;
    }
    
    self.previousBarButton.enabled = previousBarButtonEnabled;
    self.nextBarButton.enabled = nexBarButtonEnabled;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _textField = textField;
    
    [self setKeyboardDidShowNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardDidShow:notification];
    }]];
    
    [self setKeyboardWillHideNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardWillHide:notification];
    }]];
    
    //[self setBarButtonNeedsDisplayAtTag:textField.tag];
    
    
    //self.m_scrollView = (UIScrollView*)self.m_tableView;
    
    //[self selectInputView:textField];
    [textField setInputAccessoryView:toolbar];
    
    [self setToolbarCommand:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //[self validate];
    
    [self setDoneCommand:NO];
    
    
    //////Title
    if (_textField.tag >= 1000 && _textField.tag < 2000) {
        m_PTitle = _textField.text;
    }
    //////Price
    if (_textField.tag >= 2000 && _textField.tag < 3000) {
        m_PPrice = _textField.text;
    }
    //////Price Unit
    if (_textField.tag >= 3000 && _textField.tag < 4000) {
        m_PPriceUnit = _textField.text;
    }
    
    _textField = nil;
}

- (void) doneButtonIsClicked:(id)sender{
    [self setDoneCommand:YES];
    [_textField resignFirstResponder];
    [self setToolbarCommand:YES];
}

#pragma UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _m_textView = textView;
    
    [self setKeyboardDidShowNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardDidShow:notification];
    }]];
    
    [self setKeyboardWillHideNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardWillHide:notification];
    }]];

    //[self setBarButtonNeedsDisplayAtTag:_m_textView.tag];
    
    //self.m_scrollView = (UIScrollView*)self.m_tableView;
    
    //[self selectInputView:_m_textView];
    [_m_textView setInputAccessoryView:toolbar];
    
    [self setToolbarCommand:NO];

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self setDoneCommand:NO];
    m_PComment = _m_textView.text;
    _m_textView = nil;

}

- (void) done1ButtonIsClicked:(id)sender{
    [self setDoneCommand:YES];
    [_m_textView resignFirstResponder];
    [self setToolbarCommand:YES];
}

- (IBAction)clickCategoryBtn:(id)sender
{
    /////// Modal Effect
    [self presentSemiViewController:semiVC withOptions:@{
                                                         KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                         KNSemiModalOptionKeys.animationDuration : @(0.3),
                                                         KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                         }];

}
@end
