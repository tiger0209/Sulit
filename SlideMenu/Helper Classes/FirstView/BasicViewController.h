//
//  BasicViewController.h
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 03/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface BasicViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableData      *receivedCategoriesData;
    NSMutableArray     *m_newData;

}

@property (nonatomic, strong) NSDictionary * tableProperties;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

- (void) setTable;

@end
