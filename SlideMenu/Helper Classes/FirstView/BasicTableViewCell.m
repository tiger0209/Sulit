//
//  BasicTableViewCell.m
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 03/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import "BasicTableViewCell.h"

#define TABLECOLOR [UIColor colorWithRed:62.0/255.0 green:76.0/255.0 blue:87.0/255.0 alpha:1.0]
#define CELLSELECTED [UIColor colorWithRed:52.0/255.0 green:64.0/255.0 blue:73.0/255.0 alpha:1.0]
#define SEPARATOR [UIColor colorWithRed:31.0/255.0 green:38.0/255.0 blue:43.0/255.0 alpha:1.0]
#define SEPSHADOW [UIColor colorWithRed:80.0/255.0 green:97.0/255.0 blue:110.0/255.0 alpha:1.0]
#define SHADOW [UIColor colorWithRed:69.0/255.0 green:84.0/255.0 blue:95.0/255.0 alpha:1.0]
#define TEXT [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:213.0/255.0 alpha:1.0]


@implementation BasicTableViewCell

- (void) setCellContentsFromItem: (YUTableViewItem *) item
{
    self.label.text = item.itemData;
    
    if (item.status != YUTableViewItemStatusSubmenuOpened && item.status != YUTableViewItemStatusParent)
    {
        if ([item.itemData isEqualToString:@"Categories"]) {
            self.arrowImage.hidden          = NO;
            self.arrowImage.image = [UIImage imageNamed:@"arrow.png"];
            self.leftConstraint.constant    = 20;
        }else{
            self.arrowImage.hidden          = YES;
            self.leftConstraint.constant    = 20;
        }
    }
    else
    {
            self.arrowImage.hidden          = NO;
            self.arrowImage.image = [UIImage imageNamed:@"arrow-1.png"];
            self.leftConstraint.constant    = 20;
    }
    
    self.label.textColor = TEXT;
    self.separator.backgroundColor = SEPARATOR;
    self.sepShadow.backgroundColor = SEPSHADOW;
    self.shadow.backgroundColor = SHADOW;

}

@end
