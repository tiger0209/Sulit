//
//  EIViewController.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "MNMBottomPullToRefreshManager.h"

@class KNThirdViewController;

@interface EIViewController : UIViewController <UISearchBarDelegate, SlideNavigationControllerDelegate, MNMBottomPullToRefreshManagerClient>
{
    NSMutableData           *receivedHomeViewData;
    NSMutableArray     *m_newData;
    NSMutableArray     *m_img_array;
    
    //////
    KNThirdViewController * semiVC;
    
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    //int reloads_;
    int m_unitCount;

}
@property (strong, nonatomic)       IBOutlet UICollectionView   *cv;
@property (nonatomic, readwrite)    UIImageView                 *m_titleImageView;

@property (nonatomic, assign)       BOOL                        mb_isPushedView;

@property (strong, nonatomic)       UIButton   *m_profileBtn;

//////lgilgilgi
- (void)clickSearchBtn;
- (void)clickEmailBtn;
- (void)clickProfileBtn;

@end
