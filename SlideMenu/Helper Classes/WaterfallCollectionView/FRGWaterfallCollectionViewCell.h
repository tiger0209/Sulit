//
//  FRGWaterfallCollectionViewCell.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRGWaterfallCollectionViewCell : UICollectionViewCell

@property (nonatomic, readwrite) IBOutlet UIView*      frameView;
@property (nonatomic, readwrite) IBOutlet UIImageView* imageView;
@property (nonatomic, readwrite) IBOutlet UIImageView* imageView_newMark;

@property (nonatomic, readwrite)  IBOutlet UILabel *lblTitle_name;
@property (nonatomic, readwrite)  IBOutlet UILabel *lblTitle_price;
@property (nonatomic, readwrite)  IBOutlet UILabel *lblTitle_time;

@end
