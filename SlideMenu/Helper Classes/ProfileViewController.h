//
//  ProfileViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@class DDPageControl;

@interface ProfileViewController : UIViewController <SlideNavigationControllerDelegate, UIScrollViewDelegate>
{
    DDPageControl *pageControl ;
}

///////lgilgilgilgi
@property (nonatomic, readwrite)  IBOutlet UIScrollView     *m_productImagesView;

@property (nonatomic, readwrite)  IBOutlet UILabel          *m_product_name;
@property (nonatomic, readwrite)  IBOutlet UILabel          *m_product_price;

@property (nonatomic, readwrite)  IBOutlet UILabel          *m_man_name;
@property (nonatomic, readwrite)  IBOutlet UILabel          *m_product_time;
@property (nonatomic, readwrite)  IBOutlet UILabel          *m_product_location;


@property (nonatomic, readwrite)  IBOutlet UIButton         *m_btn_chat;
@property (nonatomic, readwrite)  IBOutlet UIButton         *m_btn_makeAnOffer;
@property (nonatomic, readwrite)  IBOutlet UIButton         *m_btn_deal;

@property (nonatomic, readwrite)  IBOutlet UIButton         *m_btn_Profile;

@property (nonatomic, readwrite)  IBOutlet UILabel          *m_product_description;

@property (nonatomic, readwrite)  IBOutlet UITextView       *m_product_description_view;

/////lgilgilgi
@property (nonatomic, readwrite) NSDictionary *m_Productdic;
@property (nonatomic, readwrite) UIImage *m_image;

-(IBAction)clickChatBtn:(id)sender;
-(IBAction)clickMakeAnOfferBtn:(id)sender;
-(IBAction)clickDealBtn:(id)sender;


@end
