//
//  AppDelegate.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "AppDelegate.h"
#import "JSON.h"


@implementation AppDelegate

@synthesize m_newCategoryName;
@synthesize m_checkValArray;
@synthesize m_CategoryType;
@synthesize m_min_Price;
@synthesize m_max_Price;
@synthesize m_Brand;
@synthesize mb_isExistAccount;
@synthesize mb_isLoginAccount;


+(AppDelegate*) sharedInstance
{
    return (AppDelegate*)([UIApplication sharedApplication].delegate);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
															 bundle: nil];
	
	BasicViewController *leftMenu = (BasicViewController*)[mainStoryboard
													   instantiateViewControllerWithIdentifier: @"BasicViewController"];
	
	RightMenuViewController *rightMenu = (RightMenuViewController*)[mainStoryboard
														   instantiateViewControllerWithIdentifier: @"RightMenuViewController"];
	
	[SlideNavigationController sharedInstance].rightMenu = rightMenu;
	[SlideNavigationController sharedInstance].leftMenu = leftMenu;
	[SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
	
	// Creating a custom bar button for right menu
	UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
	[button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
	[button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	[SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
	
    //////////////lgilgilgigli
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSShadowAttributeName: [UIColor clearColor],
                                                            NSShadowAttributeName: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                            NSFontAttributeName: [UIFont fontWithName:@"AppleGothic" size:20.0f]
                                                            }];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigatio_for_ios6"] forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:0.0 forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        

        [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
        
        // Uncomment to change the color of back button
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        // Uncomment to assign a custom backgroung image
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
        
        
        // Uncomment to change the back indicator image
        
        [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@""]];
        
        // Uncomment to change the font style of the title
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, 1);
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0], NSFontAttributeName, nil]];
        
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:0.0 forBarMetrics:UIBarMetricsDefault];
    }
	
    

    /////lgilgilgi
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:CATERGORIES_URL];
    [request setHTTPMethod:@"POST"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    ////////
    mb_isExistAccount = NO;
    mb_isLoginAccount = NO;
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Json
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedCategoriesData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data != nil)
    {
        [receivedCategoriesData appendData:data];
    }
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString     *strResult = [[NSString alloc] initWithData:receivedCategoriesData encoding:NSUTF8StringEncoding];
    NSArray *array = [[NSArray alloc] init];
    SBJSON *jsonParse = [SBJSON new];
    array = [jsonParse objectWithString:strResult];
    if (!array) {
        return;
    }
    
    m_newCategoryName = [[NSMutableArray alloc] initWithArray:array];
    ////////lgilgilgilgi
    int v_categoryNum = [m_newCategoryName count];
    self.m_checkValArray = [[NSMutableArray alloc] initWithCapacity:v_categoryNum];
    for (int i = 0; i < v_categoryNum; i++) {
        [self.m_checkValArray addObject:[NSNumber numberWithBool:NO]];
    }
    /////lgilgilgi
    self.m_CategoryType = 0;
}

@end
