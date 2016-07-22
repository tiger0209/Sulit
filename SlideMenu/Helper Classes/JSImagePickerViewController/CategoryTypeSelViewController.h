//
//  KNThirdViewController.h
//  KNSemiModalViewControllerDemo
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTypeSelViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    //int _m_category_type;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITableView       *m_tableView;
@property (nonatomic, assign) int       m_category_type;

@end
