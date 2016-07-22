//
//  KNThirdViewController.m
//  KNSemiModalViewControllerDemo
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import "KNThirdViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#import "Brand_TableViewCell.h"
#import "Category_TableViewCell.h"
#import "Price_TableViewCell.h"
#import "DemoTextField.h"

@interface KNThirdViewController ()
{
    //UITextField *_textField;
    BOOL _disabled;
    BOOL _enabled;
}

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

@implementation KNThirdViewController
@synthesize helpLabel;
@synthesize dismissButton;
@synthesize resizeButton;
@synthesize m_tableView;

@synthesize required;
@synthesize scrollView;
@synthesize toolbar;
@synthesize keyboardIsShown;
@synthesize keyboardSize;
@synthesize invalid;

@synthesize m_Brand;
@synthesize m_min_Price;
@synthesize m_max_Price;

- (void)viewDidLoad {
  [super viewDidLoad];
  
    // iOS 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeTop];

    
    [self.m_tableView registerNib:[UINib nibWithNibName:@"Price_TableViewCell" bundle:nil]
         forCellReuseIdentifier:@"Price_TableViewCell"];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"Brand_TableViewCell" bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:@"Brand_TableViewCell"];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"Category_TableViewCell" bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:@"Category_TableViewCell"];
    
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    
//    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Previous", @"Previous") style:UIBarButtonItemStyleBordered target:self action:@selector(previousButtonIsClicked:)];
//    self.nextBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"Next") style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonIsClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    
    NSArray *barButtonItems = @[/*self.previousBarButton, self.nextBarButton,*/ flexBarButton, doneBarButton];
    
    toolbar.items = barButtonItems;
    
    

}

- (void)viewDidUnload {
  [self setHelpLabel:nil];
  [self setDismissButton:nil];
  [self setResizeButton:nil];
  [super viewDidUnload];
}

//- (BOOL)validateInputInView:(UIView*)view
//{
//    for(UIView *subView in view.subviews){
//        if ([subView isKindOfClass:[UIScrollView class]])
//            return [self validateInputInView:subView];
//        
//        if ([subView isKindOfClass:[DemoTextField class]]){
//            if (![(MHTextField*)subView validate]){
//                return NO;
//            }
//        }
//    }
//    
//    return YES;
//}
//

- (IBAction)dismissButtonDidTouch:(id)sender {

    
  // Here's how to call dismiss button on the parent ViewController
  // be careful with view hierarchy
  UIViewController * parent = [self.view containingViewController];
  if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
    [parent dismissSemiModalView];
  }

}

- (IBAction)resizeSemiModalView:(id)sender {
    
    NSLog(@"RRRRRRRRRRRRRRRRRRRRRRRrrrrrrrrrrr");
    
    //////Category Reset
    int v_categoryNum = [[AppDelegate sharedInstance].m_newCategoryName count];
    [AppDelegate sharedInstance].m_checkValArray = [[NSMutableArray alloc] initWithCapacity:v_categoryNum];
    for (int i = 0; i < v_categoryNum; i++) {
        [[AppDelegate sharedInstance].m_checkValArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.m_tableView reloadData];

}

#pragma TableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float v_height;
    if (indexPath.section == 2) {
        v_height = 55.0f;
    }else{
        v_height = 45.0f;
    }
    return v_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}



#pragma TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger v_num;
    if (section == 0) {
         v_num = [[AppDelegate sharedInstance].m_newCategoryName count];
    }
    if (section == 1) {
        v_num = 1;
    }
    if (section == 2) {
        v_num = 1;
    }
//    if (section == 3) {
//        v_num = 1;
//    }
    return v_num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (indexPath.section == 0) {
        Category_TableViewCell* cell = (Category_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Category_TableViewCell" forIndexPath:indexPath];

        NSDictionary *v_dic = [[AppDelegate sharedInstance].m_newCategoryName objectAtIndex:indexPath.row];
//        int v_id = [[v_dic objectForKey:@"id"] integerValue];
        NSString *v_catName = [v_dic objectForKey:@"category"];
        v_catName = [NSString stringWithFormat:@"  %@", v_catName ];
        cell.m_CategoryName.text = v_catName;
        //cell.m_CategoryCheckBox = [[M13Checkbox alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BOOL v_checkFlag = [[[AppDelegate sharedInstance].m_checkValArray objectAtIndex:indexPath.row] boolValue];
        [cell.m_CategoryCheckBox setCheckState:v_checkFlag];
        [cell.m_CategoryCheckBox setTag:500 + indexPath.row ];
        //////
        [cell.m_CategoryCheckBox addTarget:self action:@selector(checkChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    if (indexPath.section == 1) {
        Price_TableViewCell* cell1 = (Price_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Price_TableViewCell" forIndexPath:indexPath];
        //[cell1.m_minPriceField setRequired:YES];
        //[cell1.m_maxPriceField setRequired:YES];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell1.m_minPriceField setDelegate:self];
        [cell1.m_maxPriceField setDelegate:self];
        
        
        return cell1;
    }
    if (indexPath.section == 2) {
        Brand_TableViewCell* cell2 = (Brand_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Brand_TableViewCell" forIndexPath:indexPath];
        //[cell2.m_BrandField setRequired:YES];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell2.m_BrandField setDelegate:self];
        return cell2;
    }
//    if (indexPath.section == 3) {
//        //UITableViewCell* cell3 = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//        //return cell3;
//    }
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *v_title;
    
    if (section == 0) {
        v_title = @"Categories";
    }
    if (section == 1) {
        v_title = @"Price";
    }
    if (section == 2) {
        v_title = @"Brand";
    }
//    if (section == 3) {
//        v_title = @"Location";
//    }

    return v_title;
}

- (void)scrollToField
{
    CGRect textFieldRect = [[_textField superview] convertRect:_textField.frame toView:self.view];
    CGRect aRect = self.view.bounds;
    
    NSLog(@"m_tableView.contentOffset.y = %f", m_tableView.contentOffset.y);
    NSLog(@"keyboardSize.height = %f", keyboardSize.height);
    NSLog(@"self.toolbar.frame.size.height = %f", self.toolbar.frame.size.height);
    
    
    aRect.origin.y = -m_tableView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + self.toolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0f, self.m_tableView.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0)
            //scrollPoint.y = 0;
            scrollPoint.y = -scrollPoint.y;
        
        ///////lgilgilgi
        if (_textField.tag >=3000) {
            scrollPoint.y += 500;
        }else{
            scrollPoint.y += 420;
        }
        [self.m_tableView setContentOffset:scrollPoint animated:YES];
    }
}

#pragma mark - UIKeyboard notifications

- (void) keyboardDidShow:(NSNotification *) notification{
    if (_textField== nil)
        return;
    if (keyboardIsShown)
        return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];
    
    self.keyboardIsShown = YES;
}

- (void) keyboardWillHide:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (_isDoneCommand){
            [self.scrollView setContentOffset:CGPointMake(0, -scrollView.contentInset.top) animated:NO];
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
    
    [self setBarButtonNeedsDisplayAtTag:textField.tag];
    
    
    self.scrollView = (UIScrollView*)self.m_tableView;
    
    
    //[self selectInputView:textField];
    [textField setInputAccessoryView:toolbar];
    
    [self setToolbarCommand:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //[self validate];
    
    [self setDoneCommand:NO];
    
    
    
    //////min price
    if (_textField.tag >= 1000 && _textField.tag < 2000) {
        m_min_Price = _textField.text;
        [AppDelegate sharedInstance].m_min_Price = _textField.text;
    }
    //////min price
    if (_textField.tag >= 2000 && _textField.tag < 3000) {
        m_max_Price = _textField.text;
        [AppDelegate sharedInstance].m_max_Price = _textField.text;
    }
    //////min price
    if (_textField.tag >= 3000 && _textField.tag < 4000) {
        m_Brand = _textField.text;
        [AppDelegate sharedInstance].m_Brand = _textField.text;
    }
    
    _textField = nil;
}

- (void) doneButtonIsClicked:(id)sender{
    [self setDoneCommand:YES];
    [_textField resignFirstResponder];
    [self setToolbarCommand:YES];
}

//- (void) nextButtonIsClicked:(id)sender{
//    NSInteger tagIndex = self.tag;
//    MHTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
//    
//    while (!textField.isEnabled && tagIndex < [self.textFields count])
//        textField = [self.textFields objectAtIndex:++tagIndex];
//    
//    [self becomeActive:textField];
//}
//
//- (void) previousButtonIsClicked:(id)sender{
//    NSInteger tagIndex = self.tag;
//    
//    MHTextField *textField =  [self.textFields objectAtIndex:--tagIndex];
//    
//    while (!textField.isEnabled && tagIndex < [self.textFields count])
//        textField = [self.textFields objectAtIndex:--tagIndex];
//    
//    [self becomeActive:textField];
//}


//////Combo Box
- (void)checkChangedValue:(id)sender
{
    M13Checkbox *v_chkBox = (M13Checkbox*)sender;
    int v_idx = v_chkBox.tag - 500;
    
    int v_categoryNum = [[AppDelegate sharedInstance].m_newCategoryName count];
    for (int i = 0; i < v_categoryNum; i++) {
        [[AppDelegate sharedInstance].m_checkValArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
    }
    [[AppDelegate sharedInstance].m_checkValArray replaceObjectAtIndex:v_idx withObject:[NSNumber numberWithBool:YES]];
    
    [self.m_tableView reloadData];
    
    NSLog(@"Changed Value %d", v_idx);
    
}

@end
