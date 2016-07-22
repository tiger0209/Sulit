//
//  MHLogInViewController.m
//  MHTextField
//
//  Created by Mehfuz Hossain on 2/27/14.
//  Copyright (c) 2014 Mehfuz Hossain. All rights reserved.
//

#import "MHLogInViewController.h"
#import "AppDelegate.h"

#import "JSON.h"


@interface MHLogInViewController ()

@end

@implementation MHLogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /////////lgilgilgi
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImage *barBackBtnImg = [UIImage imageNamed:@"Back_Icon"];
    barBackBtnImg = [self scaleImageToSize:barBackBtnImg newSize:CGSizeMake(32, 32)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:barBackBtnImg
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];

    
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255. green:242/255. blue:246/255. alpha:1.0]];
    
    // iOS 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeTop];
    
    ////lgilgilgilgi
    [_usernameTextField setRequired:YES];
    //[_usernameTextField setEmailField:YES];
    [_passwordTextField setRequired:YES];
    
}

- (UIImage *)scaleImageToSize:(UIImage*)image newSize:(CGSize)newSize
{
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / image.size.width;
    CGFloat aspectHeight = newSize.height / image.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = image.size.width * aspectRatio;
    scaledImageRect.size.height = image.size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

- (IBAction)logIn:(id)sender {
    
    UIAlertView *alertView;

    if (![self validateInputInView:self.view]){
        
        [alertView setMessage:@"Invalid information please review and try again!"];
        [alertView setTitle:@"Login Failed"];
    }
    
    NSString *v_userNameTxt = _usernameTextField.text;
    NSString *v_pwTxt = _passwordTextField.text;
    
    NSString *strReqeust = [NSString stringWithFormat:@"username=%@&password=%@", v_userNameTxt, v_pwTxt];
    NSData *requestData = [strReqeust dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:LOGIN_URL];
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
    if ([strResult isEqualToString:@"valid"]) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Log In Success!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        [AppDelegate sharedInstance].mb_isLoginAccount = YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([strResult isEqualToString:@"invalid"]){
        alertView = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Log In Fail! Again Retry!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [AppDelegate sharedInstance].mb_isLoginAccount = NO;
    }
    [alertView show];
    
}
-(IBAction)clickSignUpBtn:(id)sender
{
    NSLog(@"Click Sign Up Btn!!!");
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc ;
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MHSignupViewController"];
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
}

@end
