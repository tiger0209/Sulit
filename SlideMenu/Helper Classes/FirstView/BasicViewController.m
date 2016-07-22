//
//  BasicViewController.m
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 03/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import "BasicViewController.h"
#import "YUTableView.h"
#import "JSON.h"
#import "EIViewController.h"

#import "AppDelegate.h"


#define TABLECOLOR [UIColor colorWithRed:62.0/255.0 green:76.0/255.0 blue:87.0/255.0 alpha:1.0]

@interface BasicViewController () <YUTableViewDelegate>

@property (weak, nonatomic) IBOutlet YUTableView * tableView;

@end

@implementation BasicViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

- (void) viewDidLoad
{
    self.view.backgroundColor = TABLECOLOR;
    self.tableView.backgroundColor = TABLECOLOR;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    /////lgilgilgi
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:CATERGORIES_URL];
    [request setHTTPMethod:@"POST"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table Init

- (void) setTable
{
    _tableView.showAllItems                             = YES;
    _tableView.scrollToTopWhenAnimationFinished         = NO;
    _tableView.insertRowAnimation                       = 3;
    _tableView.deleteRowAnimation                       = 3;
    _tableView.userInteractionEnabledDuringAnimation    = YES;
    _tableView.parentView                               = self;
    
    _tableView.animationDuration = 0.0f;

    [_tableView setCellsFromArray: [self createCellItems: 2 root: nil] cellIdentifier: @"BasicTableViewCell"];
    [_tableView setRootItem: [[YUTableViewItem alloc] initWithData: @"Back"]];

}

- (NSArray *) createCellItems: (int) numberOfItems root :(NSString *) root
{
    if (numberOfItems == 0) return nil;
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < numberOfItems; i++)
    {
        NSString * label;
        if (root == nil)
        {
            switch (i) {
                case 0:
                    if ([[AppDelegate sharedInstance] mb_isLoginAccount]) {
                        label = @"Sign Out";
                    }else{
                        label = @"Sign In";
                    }
                    break;
                case 1:
                    label = @"Categories";
                    break;
                default:
                    break;
            }
        }
        else if ([root isEqualToString:@"Categories"])
        {
            NSDictionary *v_dic = [m_newData objectAtIndex:i];
            
//            int v_id = [[v_dic objectForKey:@"id"] integerValue];
            NSString *v_catName = [v_dic objectForKey:@"category"];
            label = [NSString stringWithFormat:@"  %@", v_catName ];
            
        }
        YUTableViewItem * item = [[YUTableViewItem alloc] initWithData: label];
        
        //////Categories
        if([label isEqualToString:@"Categories"])
        {
            item.subItems          = [self createCellItems: [m_newData count] root: label];
        }
        
        [array addObject: item];
    }
    
    return array;
}

#pragma mark - YUTableViewDelegate Methods
- (CGFloat) heightForItem: (YUTableViewItem *) item
{
    float v_height;
    if (([[AppDelegate sharedInstance] mb_isLoginAccount] && [item.itemData isEqualToString:@"Sign Out"]) ||
        (![[AppDelegate sharedInstance] mb_isLoginAccount] && [item.itemData isEqualToString:@"Sign In"])) {
        v_height = 60.0f;
    }else if ([item.itemData isEqualToString:@"Categories"]) {
        v_height = 40.0f;
    }else{
        v_height = 40.0f;
    }
    return v_height;
}

- (void)didSelectedRow:(YUTableViewItem *)item
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc ;
    
    if (item.subItems.count == 0)
    {
        if (([[AppDelegate sharedInstance] mb_isLoginAccount] && [item.itemData isEqualToString:@"Sign Out"]) ||
            (![[AppDelegate sharedInstance] mb_isLoginAccount] && [item.itemData isEqualToString:@"Sign In"])){
            
            if ([AppDelegate sharedInstance].mb_isLoginAccount) {
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Log Out"
                                                                      message:@"Are you got to log out?"
                                                                     delegate:self
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:@"Cancel", nil];
                
                [myAlertView show];
            }else{
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MHLogInViewController"];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                         withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                 andCompletion:nil];
            }
        }

        for (int i = 0; i < [m_newData count]; i++) {
            NSDictionary *v_dic = [m_newData objectAtIndex:i];
            int v_id = [[v_dic objectForKey:@"id"] integerValue];
            NSString *v_catName = [v_dic objectForKey:@"category"];
            NSString *label = [NSString stringWithFormat:@"  %@", v_catName ];
            
            if ([item.itemData isEqualToString:label]) {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                                         bundle: nil];
                UIViewController *vc ;
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"EIViewController"];
                [AppDelegate sharedInstance].m_CategoryType = v_id;
                [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
            }
        }
    }
    else
    {
        NSLog(@"%@ selected", item.itemData);
    }
}

#pragma mark Json
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedCategoriesData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data != nil)
    {
        [receivedCategoriesData appendData:data];
    }
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString     *strResult = [[NSString alloc] initWithData:receivedCategoriesData encoding:NSUTF8StringEncoding];
    NSArray *array = [[NSArray alloc] init];
    SBJSON *jsonParse = [SBJSON new];
    array = [jsonParse objectWithString:strResult];
    if (!array) {
        return;
    }
    m_newData = [[NSMutableArray alloc] initWithArray:array];
    [self setTable];
}

#pragma mark ALERTDELEGATE
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        /////Log Out
        NSLog(@"0");
        [AppDelegate sharedInstance].mb_isLoginAccount = NO;
        [self setTable];
        
    } else {
        /////
        NSLog(@"1");
    }
}
@end
