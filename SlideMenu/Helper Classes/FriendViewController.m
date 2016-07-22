//
//  EIViewController.m
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import "FriendViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"

static NSString* const WaterfallCellIdentifier = @"WaterfallCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";

@interface FriendViewController () <FRGWaterfallCollectionViewDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *cellHeights;
////lgilgilgi
@property (nonatomic, strong) NSMutableArray *imageNums;


@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cv.delegate = self;
    
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    cvLayout.itemWidth = 140.0f;
    cvLayout.topInset = 10.0f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = YES;
    
    [self.cv setCollectionViewLayout:cvLayout];
    [self.cv reloadData];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self.cv collectionViewLayout] invalidateLayout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 30;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //int index = indexPath.item;
    //NSLog(@"=====%d======", indexPath.section + 1 * indexPath.item);
    
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    waterfallCell.lblTitle.text = [NSString stringWithFormat: @"Item %d", indexPath.section + 1 * indexPath.item];
    
    
    NSString *img_name = [NSString stringWithFormat:@"image_%@.jpg",_imageNums[indexPath.section + 1 * indexPath.item]];
    
    NSLog(@"**** %@ *****", _imageNums[indexPath.section + 1 * indexPath.item]);
    
    //////lgilgilgi
    UIImage *v_img = [UIImage imageNamed:img_name];
    float v_img_w = [v_img size].width;
    float v_ratio = 140.0f / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
    
    v_img = [self scaleImage:v_img toResolution:140];
    v_img_w = [v_img size].width;
    v_img_h = [v_img size].height;
    
    waterfallCell.imageView.image = v_img;
    return waterfallCell;
}

- (UIImage *)scaleImage:(UIImage*)image toResolution:(int)resolution
{
    CGImageRef imgRef = [image CGImage];
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    //if already at the minimum resolution, return the orginal image, otherwise scale
    //    if (width <= resolution && height <= resolution) {
    //        return image;
    //
    //    } else {
    CGFloat ratio = width/height;
    
    //       if (ratio > 1) {
    bounds.size.width = resolution;
    bounds.size.height = bounds.size.width / ratio;
    //       } else {
    //           bounds.size.height = resolution;
    //           bounds.size.width = bounds.size.height * ratio;
    //       }
    //   }
    
    UIGraphicsBeginImageContext(bounds.size);
    [image drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    //////lgilgilgilgi
    
    int v_num = arc4random()%5;
    NSString *img_name = [NSString stringWithFormat:@"image_%d.jpg",v_num];
    //////lgilgilgi
    UIImage *v_img = [UIImage imageNamed:img_name];
    float v_img_w = [v_img size].width;
    float v_ratio = 140.0f / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
    self.cellHeights[indexPath.section + 1 * indexPath.item] = @(v_img_h);
    self.imageNums[indexPath.section + 1 * indexPath.item] = @(v_num);
    
    return [self.cellHeights[indexPath.section + 1 * indexPath.item] floatValue];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section + 1) * 26.0f;
}

- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:900];
        for (NSInteger i = 0; i < 900; i++) {
            _cellHeights[i] = @(arc4random()%100*2+100);
        }
    }
    return _cellHeights;
}

- (NSMutableArray *)imageNums {
    if (!_imageNums) {
        _imageNums = [NSMutableArray arrayWithCapacity:900];
        for (NSInteger i = 0; i < 900; i++) {
            _imageNums[i] = @(0);
        }
    }
    return _imageNums;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath; {
    FRGWaterfallHeaderReusableView *titleView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:WaterfallHeaderIdentifier
                                              forIndexPath:indexPath];
    titleView.lblTitle.text = [NSString stringWithFormat: @"Section %d", indexPath.section];
    return titleView;
}

@end
