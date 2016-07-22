//
//  KNThirdViewController.m
//  KNSemiModalViewControllerDemo
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import "CategoryTypeSelViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "CategoryCell.h"


@implementation CategoryTypeSelViewController

@synthesize m_category_type;

- (void)viewDidLoad {

  [self.m_tableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil]
           forCellReuseIdentifier:@"CategoryCell"];

  [super viewDidLoad];
}

- (void)viewDidUnload {
    
  [super viewDidUnload];
  [self.m_tableView reloadData];
    
}

#pragma TableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float v_height = 45.0f;
    return v_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

#pragma TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AppDelegate sharedInstance].m_newCategoryName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    
    NSDictionary *v_dic = [[AppDelegate sharedInstance].m_newCategoryName objectAtIndex:indexPath.row];
//    int v_id = [[v_dic objectForKey:@"id"] integerValue];
    NSString *v_catName = [v_dic objectForKey:@"category"];
    cell.m_CategoryName.text = v_catName;
    return cell;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m_category_type = indexPath.row+1;
    
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }

}
@end
