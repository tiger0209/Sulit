//
//  MHSignupViewController.m
//  MHTextField
//
//  Created by Mehfuz Hossain on 2/27/14.
//  Copyright (c) 2014 Mehfuz Hossain. All rights reserved.
//

#import "MHSignupViewController.h"
#import "AppDelegate.h"

#import "JSON.h"


@interface MHSignupViewController ()

@end

@implementation MHSignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /////////lgilgilgi
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:nil
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];

    
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255. green:242/255. blue:246/255. alpha:1.0]];
    
    // iOS 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeTop];
    
    ////lgilgilgilgi
    [_emailTextField setRequired:YES];
    //[_emailTextField setEmailField:YES];
    [_passwordTextField setRequired:YES];
    [_ageTextField setDateField:YES];
    
    [_firstNameTextField setEnabled:NO];
    [_lastNameTextField setEnabled:NO];
    [_phoneTextField setEnabled:NO];
    [_ageTextField setEnabled:NO];
    [_zipTextField setEnabled:NO];
}

- (IBAction)createAccount:(id)sender {
    
    UIAlertView *alertView;

    if (![self validateInputInView:self.view]){
        
        [alertView setMessage:@"Invalid information please review and try again!"];
        [alertView setTitle:@"Login Failed"];
    }
    
    NSString *v_emailTxt = _emailTextField.text;
    NSString *v_pwTxt = _passwordTextField.text;
//    NSString *v_fNTxt = _firstNameTextField.text;
//    NSString *v_eNTxt = _lastNameTextField.text;
//    NSString *v_phoneTxt = _phoneTextField.text;
//    NSString *v_ageTxt = _ageTextField.text;
//    NSString *v_zipTxt = _zipTextField.text;
    
    NSString *strReqeust = [NSString stringWithFormat:@"username=%@&password=%@", v_emailTxt, v_pwTxt];
    NSData *requestData = [strReqeust dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:SIGNUP_URL];
    [theRequest setHTTPBody:requestData];
    [theRequest setHTTPMethod:@"POST"];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    [alertView show];
}


- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews){
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[DemoTextField class]]){
            if (![(MHTextField*)subView validate]){
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark Json
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedHomeViewData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data != nil)
    {
        [receivedHomeViewData appendData:data];
    }
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString     *strResult = [[NSString alloc] initWithData:receivedHomeViewData encoding:NSUTF8StringEncoding];
    //strResult = [strResult componentsSeparatedByCharactersInSet:];
    //strResult = [strResult substringWithRange:NSMakeRange(1, [strResult length]-1)];
    //strResult =  [strResult substringToIndex:[strResult length]-1];
    
    UIAlertView *alertView;
    if ([strResult isEqualToString:@"success"]) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Sign Up Success!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [AppDelegate sharedInstance].mb_isExistAccount = YES;
        
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Duplicate Account!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [AppDelegate sharedInstance].mb_isExistAccount = NO;
    }
    [alertView show];
    
}
@end
