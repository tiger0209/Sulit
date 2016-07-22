//
//  ExternVar.m
//  JsonP
//
//  Created by xiao on 12/27/13.
//  Copyright (c) 2013 xiao. All rights reserved.
//

#import "ExternVar.h"

@implementation ExternVar

static ExternVar *instance = nil;

@synthesize isAboutToMap,isAboutToWeb;
@synthesize aboutViewDataDictionary;
@synthesize isAboutRequest;
@synthesize isMainMenuRequest;
@synthesize mainMenuDataArray;
@synthesize isSubMenuRequest;
@synthesize subMenuDataArray;
@synthesize detailMenuDataArray,isDetailMenuRequest;
@synthesize galleryDataArray, isGalleryPhotoRequest,isGalleryVideoRequest;
@synthesize contactDataDictionary, isContactRequest;
@synthesize reservationDictionary;
@synthesize webViewDictionary;
@synthesize socialViewDictionary;
@synthesize isOfferCategoryRequest, offerCategoryArray,   offersArray;
@synthesize m_bussinessPhoneNum;

@synthesize userPt;

+ (ExternVar *)instance
{
    
	if (instance == nil)
	{
		instance = [[ExternVar alloc] init];
	}
    
	return instance;
}

+ (void) safeRelease :(id)variable
{
    if (variable != nil) {
//        [variable release];
        variable = nil;
    }
}


@end
