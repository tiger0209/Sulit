//
//  AppDelegate.h
//  SlideMenu
//
//  Created by Lion0324 on 4/24/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "BasicViewController.h"
#import "RightMenuViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    NSMutableData      *receivedCategoriesData;
}
@property (strong, nonatomic) UIWindow                      *window;
@property (nonatomic, strong) NSMutableArray                *m_newCategoryName;
@property (nonatomic, strong) NSMutableArray                *m_checkValArray;
@property (nonatomic, assign) int                            m_CategoryType;

@property (nonatomic, strong) NSString                      *m_min_Price;
@property (nonatomic, strong) NSString                      *m_max_Price;
@property (nonatomic, strong) NSString                      *m_Brand;

@property (nonatomic, assign) BOOL                          *mb_isExistAccount;
@property (nonatomic, assign) BOOL                          *mb_isLoginAccount;

+(AppDelegate*) sharedInstance;

@end
