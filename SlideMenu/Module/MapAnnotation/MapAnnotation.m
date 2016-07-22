//
//  MapAnnotation.m
//  MapView
//
//  Created by Prateek Joshi on 7/21/13.
//  Copyright (c) 2013 Prateek Joshi. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate, titleText, subTitleText;
- (NSString *)subtitle{
    return subTitleText;
}
- (NSString *)title{
    return titleText;
}
-(void)setTitle:(NSString*)strTitle {
    self.titleText = strTitle;
}
-(void)setSubTitle:(NSString*)strSubTitle {
    self.subTitleText = strSubTitle;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}
@end