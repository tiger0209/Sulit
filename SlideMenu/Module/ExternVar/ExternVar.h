//
//  ExternVar.h
//  JsonP
//
//  Created by xiao on 12/27/13.
//  Copyright (c) 2013 xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
//#import "ShareViewController.h"
//#import <Twitter/Twitter.h>
//#import "SSHActionSheet.h"
#import <Accounts/Accounts.h>

static  NSString        *kBusiness = @"Business";
static  NSString        *kMenuImg = @"MenuImage";
static  NSString        *kContent = @"Content";
static  NSString        *kSocialMedia = @"SocialMedia";
static  NSString        *kServiceType = @"ServiceType";
static  NSString        *kCategory = @"Category";

static  NSString        *kBusinessID = @"id";
static  NSString        *kCategoryID = @"category_id";
static  NSString        *kTitle = @"title";
static  NSString        *kOffer = @"Offer";
static  NSString        *kServiceMenu = @"ServiceMenu";
static  NSString        *kDescription = @"description";
static  NSString        *kPhoneNum = @"phone number";
static  NSString        *kEmail = @"email";
static  NSString        *kLatitude = @"latitude";
static  NSString        *kLongitude = @"longitude";
static  NSString        *kPostalCode = @"postal_code";
static  NSString        *kUrl = @"url";
static  NSString        *kPicture = @"picture";

static  NSString        *kFacebook = @"facebook";
static  NSString        *kTwitter = @"twitter";


#ifndef FTShare_Config_h
#define FTShare_Config_h

#warning Enter twitter and Facebook keys!

#define kIKTwitterConsumerKey   @"J3lGExzjOc3gi9fv5oMgA" //@"yourTwitterConsumerKey"
#define kIKTwiiterPasscode      @"wkOKutYnXXpNnHZJvOfIRMo1sXoGZDFwHgpGuk4tY" //@"yourTwitterPasscode"

#define kIKFacebookAppID        @"219306811462394" //@"yourFacebookAppID"

#endif

@interface ExternVar : NSObject


@property(nonatomic, assign) BOOL       isAboutToMap;
@property(nonatomic, assign) BOOL       isAboutToWeb;
@property(nonatomic, retain) NSMutableDictionary     *aboutViewDataDictionary;
@property(nonatomic, assign) BOOL       isAboutRequest;

@property(nonatomic, retain) NSMutableArray     *mainMenuDataArray;
@property(nonatomic, assign) BOOL       isMainMenuRequest;

@property(nonatomic, retain) NSMutableArray     *subMenuDataArray;
@property(nonatomic, assign) BOOL       isSubMenuRequest;

@property(nonatomic, retain) NSMutableArray      *detailMenuDataArray;
@property(nonatomic, assign) BOOL        isDetailMenuRequest;

@property(nonatomic, retain) NSMutableArray     *galleryDataArray;
@property(nonatomic, assign) BOOL       isGalleryPhotoRequest,isGalleryVideoRequest;

@property(nonatomic, retain) NSMutableDictionary     *contactDataDictionary;
@property(nonatomic, assign) BOOL       isContactRequest;

@property(nonatomic, retain) NSMutableDictionary         *reservationDictionary;

@property(nonatomic, retain) NSMutableDictionary         *webViewDictionary;

@property(nonatomic, retain) NSMutableDictionary         *socialViewDictionary;

@property(nonatomic, retain) NSMutableArray              *offerCategoryArray;
@property(nonatomic, assign) BOOL                        isOfferCategoryRequest;
@property(nonatomic, retain) NSMutableArray              *offersArray;

@property(nonatomic, retain) NSString                    *m_bussinessPhoneNum;
@property(nonatomic, retain) MKPointAnnotation           *userPt;

+ (ExternVar *) instance;
+ (void) safeRelease :(id)variable;

@end
