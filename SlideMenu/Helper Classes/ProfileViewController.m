//
//  ProfileViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "ProfileViewController.h"
#import "DDPageControl.h"
#import "SPHViewController.h"
#import "ProfileDetailViewController.h"



#define ARC4RANDOM_MAX	0x100000000


@implementation ProfileViewController

@synthesize m_Productdic;
@synthesize m_image;


- (NSTimeInterval) timeStamp:(NSDate*) date {
    return [date timeIntervalSince1970];
}
- (NSString*) getTimeString :(NSString*) time{
    NSString *v_str = time;
    
    v_str = [v_str stringByReplacingOccurrencesOfString:@"-"
                                             withString:@"/"];
    
    return v_str;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /////////lgilgilgi
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    UIImage *barBackBtnImg = [UIImage imageNamed:@"Back_Icon"];
    barBackBtnImg = [self scaleImageToSize:barBackBtnImg newSize:CGSizeMake(32, 32)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:barBackBtnImg
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];

    int numberOfPages = 4 ;
    
    // define the scroll view content size and enable paging
    [self.m_productImagesView setBackgroundColor:[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:239.0f/255.0f]];
    [self.m_productImagesView setPagingEnabled: YES] ;
    [self.m_productImagesView setContentSize: CGSizeMake(self.m_productImagesView.bounds.size.width * numberOfPages, self.m_productImagesView.bounds.size.height)] ;
    
    // programmatically add the page control
    pageControl = [[DDPageControl alloc] init] ;
    [pageControl setCenter: CGPointMake(self.view.center.x, 315.0f)] ;
    [pageControl setNumberOfPages: numberOfPages] ;
    [pageControl setCurrentPage: 0] ;
    [pageControl addTarget:self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    [pageControl setDefersCurrentPageDisplay: YES] ;
    [pageControl setType: DDPageControlTypeOnFullOffEmpty] ;
    [pageControl setOnColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]];
    [pageControl setOffColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]];
    [pageControl setIndicatorDiameter: 7.0f] ;
    [pageControl setIndicatorSpace: 7.0f] ;
    [self.view addSubview: pageControl] ;
    
    CGRect pageFrame;
    UIView *v_pageImageFrame;
    UIImageView *v_pageImageView;
    UIImage *v_productImage;
    
    UILabel *v_product_name;
    UILabel *v_product_price;
    
    for (int i = 0 ; i < numberOfPages ; i++)
    {
        // determine the frame of the current page
        pageFrame = CGRectMake(i * self.m_productImagesView.bounds.size.width, 0.0f, self.m_productImagesView.bounds.size.width, self.m_productImagesView.bounds.size.height) ;
        ////////lgilgilgi BUG
        v_productImage = m_image;
        
        float v_ratio, v_width, v_height;
        
        if (v_productImage.size.height >= pageFrame.size.height - 20) {
            v_ratio = v_productImage.size.height / (pageFrame.size.height - 20);
            v_height = pageFrame.size.height - 20;
            v_width = v_productImage.size.width  / v_ratio;
            if (v_width >= v_height) {
                v_width = v_height;
            }
            
        }else{
            v_ratio = (pageFrame.size.height - 20) / v_productImage.size.height;
            v_height = pageFrame.size.height - 20;
            v_width = v_productImage.size.width * v_ratio;
            if (v_width >= v_height) {
                v_width = v_height;
            }
        }
        
        v_pageImageView = [[UIImageView alloc] initWithImage:v_productImage];
        v_pageImageView.frame = CGRectMake(0,
                                           0,
                                           v_width,
                                           v_height- 20);
        
        v_product_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        v_product_price = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 21)];
        
        v_product_name.text = [m_Productdic objectForKey:@"name"];
        v_product_price.text = [NSString stringWithFormat:@"$%@", [m_Productdic objectForKey:@"price"] ];
        
        v_product_name.textColor = [UIColor blackColor];
        v_product_price.textColor = [UIColor colorWithRed:26.0f/255.0f green:197.0f/255.0f blue:115.0f/255.0f alpha:1.0f];
        
        v_product_name.font = [UIFont systemFontOfSize:13];
        v_product_price.font = [UIFont systemFontOfSize:13];
        
        v_product_name.textAlignment = NSTextAlignmentLeft;
        v_product_price.textAlignment = NSTextAlignmentRight;
        
        [v_product_name setFrame:CGRectMake(5,
                                            v_height - 20,
                                            70,
                                            21)];
        [v_product_price setFrame:CGRectMake(v_width  - 80,
                                             v_height - 20,
                                             70,
                                             21)];
        
        v_pageImageFrame = [[UIView alloc] initWithFrame:CGRectMake(pageFrame.origin.x + pageFrame.size.width/2  - v_width/2,
                                                                    pageFrame.origin.y + pageFrame.size.height/2 - v_height/2,
                                                                    v_width,
                                                                    v_height)];

        [v_pageImageFrame setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
        v_pageImageFrame.layer.masksToBounds = YES;
        v_pageImageFrame.layer.cornerRadius = 5;
        
        [v_pageImageFrame addSubview:v_pageImageView];
        [v_pageImageFrame addSubview:v_product_name];
        [v_pageImageFrame addSubview:v_product_price];
        [self.m_productImagesView addSubview: v_pageImageFrame];
        
        /////lgilgilgi
        //NSDictionary *v_dic = m_Productdic;

    }

    
    NSDictionary *v_dic = m_Productdic;
    
    NSString *v_upload_time = [v_dic objectForKey:@"upload_time"];
    v_upload_time = [self getTimeString:v_upload_time];
    
    NSDateFormatter *dateFormatter=[NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    NSDate *date=[dateFormatter dateFromString:v_upload_time];
    NSTimeInterval v_spending_time = [self timeStamp:[NSDate date]] - [self timeStamp:date];
    
    int v_spending_hour = v_spending_time / (1000*60*60);
    int v_spending_min = (v_spending_time - (1000*60*60*v_spending_hour)) / (1000*60);
    if (v_spending_hour  == 0) {
        self.m_product_time.text = [NSString stringWithFormat:@"%dminutes ago", v_spending_min];
    }else{
        self.m_product_time.text = [NSString stringWithFormat:@"%dh %dmin ago", v_spending_hour, v_spending_min];
    }
    self.m_man_name.text = [v_dic objectForKey:@"seller"];
    self.m_product_location.text = [v_dic objectForKey:@"location"];
    
    [self.m_man_name setHidden:YES];
    [self.m_product_time setHidden:YES];
    [self.m_product_location setHidden:YES];
    [self.m_btn_Profile setHidden:YES];

}

- (UIImage *)scaleImageToSize:(UIImage*)image newSize:(CGSize)newSize
{
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / image.size.width;
    CGFloat aspectHeight = newSize.height / image.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = image.size.width * aspectRatio;
    scaledImageRect.size.height = image.size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
    DDPageControl *thePageControl = (DDPageControl *)sender ;
    
    // we need to scroll to the new index
    [self.m_productImagesView setContentOffset: CGPointMake(self.m_productImagesView.bounds.size.width * thePageControl.currentPage, self.m_productImagesView.contentOffset.y) animated: YES] ;
}


#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    CGFloat pageWidth = self.m_productImagesView.bounds.size.width ;
    float fractionalPage = self.m_productImagesView.contentOffset.x / pageWidth ;
    NSInteger nearestNumber = lround(fractionalPage) ;
    
    if (pageControl.currentPage != nearestNumber)
    {
        pageControl.currentPage = nearestNumber ;
        
        // if we are dragging, we want to update the page control directly during the drag
        if (self.m_productImagesView.dragging)
            [pageControl updateCurrentPageDisplay] ;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    // if we are animating (triggered by clicking on the page control), we update the page control
    [pageControl updateCurrentPageDisplay] ;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

-(IBAction)clickChatBtn:(id)sender
{
    NSLog(@"===Click CHAT BTN====");
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Only Chat IE!!! In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

    UIViewController *v_chatView = [[SPHViewController alloc] initWithNibName:@"SPHViewController" bundle:nil];
    [self.navigationController pushViewController:v_chatView animated:YES];
}

-(IBAction)clickMakeAnOfferBtn:(id)sender
{
    NSLog(@"===Click MAKE OFFER BTN====");
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

}

-(IBAction)clickDealBtn:(id)sender
{
    NSLog(@"===Click DEAL BTN====");
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

}

-(IBAction)clickProfileBtn:(id)sender
{
    NSLog(@"===Click Profile BTN====");
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc ;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileDetailViewController"];
    
    ((ProfileDetailViewController*)vc).mb_fromProfileBtn = YES;
    
    [self.navigationController pushViewController:vc animated:NO];

}


@end
