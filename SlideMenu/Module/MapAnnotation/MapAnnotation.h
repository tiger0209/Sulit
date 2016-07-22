//
//  MapAnnotation.h
//  MapView
//
//  Created by Prateek Joshi on 7/21/13.
//  Copyright (c) 2013 Prateek Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject
{
    CLLocationCoordinate2D coordinate;
    NSString *subTitleText;
    NSString *titleText;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readwrite, retain) NSString *titleText;
@property (readwrite, retain) NSString *subTitleText;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
- (NSString *)subTitle;
- (NSString *)title;
-(void)setTitle:(NSString*)strTitle;
-(void)setSubTitle:(NSString*)strSubTitle;
@end