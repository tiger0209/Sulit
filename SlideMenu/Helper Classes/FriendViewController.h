//
//  EIViewController.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface FriendViewController : UIViewController <SlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cv;

@end
