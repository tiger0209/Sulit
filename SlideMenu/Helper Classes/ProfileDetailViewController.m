//
//  ProfileDetailViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/25/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"
#import "ProfileViewController.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
////lgilgilgi
#import "JSViewController.h"

static NSString* const WaterfallCellIdentifier = @"WaterfallCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";

@interface ProfileDetailViewController () <FRGWaterfallCollectionViewDelegate, UICollectionViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) NSMutableArray *cellHeights;
////lgilgilgi
@property (nonatomic, strong) NSMutableArray *imageNums;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, retain) MBProgressHUD *HUD;

@end


@implementation ProfileDetailViewController

@synthesize mb_fromProfileBtn;
@synthesize HUD;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (mb_fromProfileBtn) {
        [self.m_photoView setImage:[UIImage imageNamed:@"noProfile.png"]];
    }else{
        [self.m_photoView setImage:[UIImage imageNamed:@"profile.png"]];
    }
    
    ///////lgilgilgilgi
    UIImage *v_img = [UIImage imageNamed:@"nav_bar_title.png"];
    float v_img_w = [v_img size].width;
    float v_img_h = [v_img size].height;
    float v_ratio = 20.0f / v_img_h;
    v_img_w = [v_img size].width*v_ratio;
    v_img = [self scaleImageToSize:v_img newSize:CGSizeMake(v_img_w, 20)];
    
    
    /////////lgilgilgi
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImage *barBackBtnImg = [UIImage imageNamed:@"Back_Icon"];
    barBackBtnImg = [self scaleImageToSize:barBackBtnImg newSize:CGSizeMake(32, 32)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:barBackBtnImg
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button1 setImage:[UIImage imageNamed:@"settingIcon"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *view1 = [[UIView alloc] initWithFrame:button1.frame];
    [view1 addSubview:button1];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:view1];
    
    
    self.navigationItem.rightBarButtonItems = @[barButtonItem1];
    
    
    ///////////////
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    UIImage *v_img1 = [UIImage imageNamed:@"Segment_About.png"];
    UIImage *v_img2 = [UIImage imageNamed:@"Segment_Products.png"];
    UIImage *v_img3 = [UIImage imageNamed:@"Segment_Reviews.png"];
    UIImage *v_img4 = [UIImage imageNamed:@"Segment_About_Sel.png"];
    UIImage *v_img5 = [UIImage imageNamed:@"Segment_Products_Sel.png"];
    UIImage *v_img6 = [UIImage imageNamed:@"Segment_Reviews_Sel.png"];

    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[v_img1,
                                                                                v_img2,
                                                                                v_img3]
                                                        sectionSelectedImages:@[v_img4,
                                                                                v_img5,
                                                                                v_img6]
                            ];
    self.segmentedControl.frame = CGRectMake(0, 305, viewWidth, 45);
    self.segmentedControl.selectionIndicatorHeight = 0.0f;
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 1;

    
    [self.m_textView_About setHidden:YES];
    [self.cv setHidden:NO];
    [self.m_textView_Review setHidden:YES];

    [self.view addSubview:self.segmentedControl];
    
    
    /////lgilgilgi
    //if ([AppDelegate sharedInstance].m_CategoryType == 0) {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:SEVER_URL];
    [request setHTTPMethod:@"POST"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    //}
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.frame = CGRectMake(viewWidth/2, 400, 30, 30);
    HUD.delegate = self;
    [HUD setLabelFont:[UIFont systemFontOfSize:12]];
    [HUD setLabelText:@"Loading..."];
    
    //self.cv.delegate = self;
    //[self.cv reloadData];
    [self.cv setBackgroundColor:[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f]];
    
}

#pragma Segment Control
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    if ((long)segmentedControl.selectedSegmentIndex == 0) {
        [self.m_textView_About setHidden:NO];
        [self.cv setHidden:YES];
        [self.m_textView_Review setHidden:YES];
    }
    if ((long)segmentedControl.selectedSegmentIndex == 1) {
        [self.m_textView_About setHidden:YES];
        [self.cv setHidden:NO];
        [self.m_textView_Review setHidden:YES];
    }
    if ((long)segmentedControl.selectedSegmentIndex == 2) {
        [self.m_textView_About setHidden:YES];
        [self.cv setHidden:YES];
        [self.m_textView_Review setHidden:NO];
    }
}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self.cv collectionViewLayout] invalidateLayout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
#if TESTTESTTEST
    int v_cnt = [m_newData count];
    if ( v_cnt > 20) {
        v_cnt = 20;
    }
    return v_cnt;
#else
    //return [m_newData count];
    if (!m_newData) {
        return 0;
    }else{
        return 5;
    }
#endif
    
}

- (NSTimeInterval) timeStamp:(NSDate*) date {
    return [date timeIntervalSince1970];
}
- (NSString*) getTimeString :(NSString*) time{
    NSString *v_str = time;
    
    v_str = [v_str stringByReplacingOccurrencesOfString:@"-"
                                             withString:@"/"];
    
    return v_str;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    int index = indexPath.item;
    //    NSLog(@"=====%d======", indexPath.section + 1 * indexPath.item);
    
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    NSDictionary *v_dic = [m_newData objectAtIndex:indexPath.section + 1 * indexPath.item];
    
    waterfallCell.lblTitle_name.text = [v_dic objectForKey:@"name"];
    waterfallCell.lblTitle_price.text = [NSString stringWithFormat:@"$%@", [v_dic objectForKey:@"price"] ];
    
    NSString *v_upload_time = [v_dic objectForKey:@"upload_time"];
    v_upload_time = [self getTimeString:v_upload_time];
    
    NSDateFormatter *dateFormatter=[NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    NSDate *date=[dateFormatter dateFromString:v_upload_time];
    NSTimeInterval v_spending_time = [self timeStamp:[NSDate date]] - [self timeStamp:date];
    
    int v_spending_hour = v_spending_time / (1000*60*60);
    int v_spending_min = (v_spending_time - (1000*60*60*v_spending_hour)) / (1000*60);
    if (v_spending_hour  == 0) {
        waterfallCell.lblTitle_time.text = [NSString stringWithFormat:@"ago %dmin", v_spending_min];
    }else{
        waterfallCell.lblTitle_time.text = [NSString stringWithFormat:@"ago %dh %dmin", v_spending_hour, v_spending_min];
    }
    
    
    UIImage *v_img = [m_img_array objectAtIndex:indexPath.section + 1 * indexPath.item ];
    float v_img_w = [v_img size].width;
    float v_ratio = 140.0f / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
    v_img = [self scaleImageToSize:v_img newSize:CGSizeMake(140, v_img_h)];
    v_img_w = [v_img size].width;
    v_img_h = [v_img size].height;
    
    //////lgilgilgi
    //waterfallCell.frame = CGRectMake(0, 0, 140, v_img_h + 40);
    
    waterfallCell.frameView.frame = CGRectMake(0, 0, 140, v_img_h+20);
    [waterfallCell.frameView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    waterfallCell.frameView.layer.masksToBounds = YES;
    waterfallCell.frameView.layer.cornerRadius = 5;
    
    waterfallCell.imageView.image = v_img;
    waterfallCell.imageView.frame = CGRectMake(0, 0, 140, v_img_h);
    //waterfallCell.imageView.layer.masksToBounds = YES;
    //waterfallCell.imageView.layer.cornerRadius = 5;
    
    [waterfallCell.frameView addSubview:waterfallCell.imageView];
    
    
    int v_num = arc4random()%10;
    if (v_num <= 5) {
        waterfallCell.imageView_newMark.hidden = YES;
    }else{
        waterfallCell.imageView_newMark.hidden = NO;
    }
    
    [waterfallCell.lblTitle_name setFrame:CGRectMake(5, v_img_h, waterfallCell.lblTitle_name.frame.size.width, waterfallCell.lblTitle_name.frame.size.height)];
    [waterfallCell.lblTitle_price setFrame:CGRectMake(80, v_img_h, waterfallCell.lblTitle_price.frame.size.width, waterfallCell.lblTitle_price.frame.size.height)];
    //[waterfallCell.lblTitle_time setFrame:CGRectMake(v_img_w - 100, v_img_h + 20, waterfallCell.lblTitle_time.frame.size.width, waterfallCell.lblTitle_time.frame.size.height)];
    waterfallCell.lblTitle_name.textColor = [UIColor blackColor];
    waterfallCell.lblTitle_price.textColor = [UIColor colorWithRed:26.0f/255.0f green:197.0f/255.0f blue:115.0f/255.0f alpha:1.0f];

    return waterfallCell;
}

- (UIImage *)scaleImage:(UIImage*)image toResolution:(int)resolution
{
    CGImageRef imgRef = [image CGImage];
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat ratio = width/height;
    
    bounds.size.width = resolution;
    bounds.size.height = bounds.size.width / ratio;
    UIGraphicsBeginImageContext(bounds.size);
    [image drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
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


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //////lgilgilgi
    UIImage *v_img = [m_img_array objectAtIndex:indexPath.section + 1 * indexPath.item ];
    float v_img_w = [v_img size].width;
    float v_ratio = 140.0f / v_img_w;
    float v_img_h = [v_img size].height*v_ratio + 20;
    self.cellHeights[indexPath.section + 1 * indexPath.item] = @(v_img_h);
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


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *v_dic = [m_newData objectAtIndex:indexPath.section + 1 * indexPath.item];
    
    NSLog(@"I Click Click Click!!!!!!");
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc ;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
    
    ProfileViewController* v_ProView = (ProfileViewController*)vc;
    v_ProView.m_Productdic = v_dic;
    v_ProView.m_image = [m_img_array objectAtIndex:indexPath.section + 1 * indexPath.item ];
    
    [self.navigationController pushViewController:vc animated:NO];
    
}


- (IBAction)clickEmailIconBtn:(id)sender
{
    NSLog(@"----CLICK Email Icon Btn-----");
    NSLog(@" === click Email Btn === ");
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.mailComposeDelegate = self;
    NSString    *recipientStr = @"Hi, World!!!";
    [mailVC setToRecipients:[NSArray arrayWithObject:recipientStr]];
    [mailVC setSubject:@"Hi, World!!!"];
    NSString    *messageBody;
    NSString    *tmpStr = @"Anonymous";
    messageBody = [NSString stringWithFormat:@"Name: %@ \n",tmpStr];
    messageBody = [NSString stringWithFormat:@"%@Email: %@ \n",messageBody, @"jjj@gmail.com"]
    ;
    messageBody = [NSString stringWithFormat:@"%@Phone: %@ \n",messageBody,@"132-5554-6667"]
    ;
    messageBody = [NSString stringWithFormat:@"Date: %@ \n",@"30/05/2015"]
    ;
    [mailVC setMessageBody:messageBody isHTML:NO];
    
    ///////
    if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        [[mailVC navigationBar] setTintColor:[UIColor colorWithRed:26.0f/255.0f green:197.0f/255.0f blue:115.0f/255.0f alpha:1.0f]];
    }else{
        [[mailVC navigationBar] setBarTintColor:[UIColor colorWithRed:26.0f/255.0f green:197.0f/255.0f blue:115.0f/255.0f alpha:1.0f]];
    }
    
    
    [self presentViewController: mailVC animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    }];

}
- (IBAction)clickPhoneIconBtn:(id)sender
{
    NSLog(@"----CLICK Phone Icon Btn-----");
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSString *phoneStr = @"13238831722";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneStr]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }

}
- (IBAction)clickFacebookIconBtn:(id)sender
{
    NSLog(@"----CLICK Facebook Icon Btn-----");
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

}
- (IBAction)clickTwitterIconBtn:(id)sender
{
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

}
- (void)clickSettingBtn
{
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"In Developing!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];

}

- (IBAction)clickUploadBtn:(id)sender
{
    NSLog(@"----CLICK Upload Btn-----");
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc ;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"JSViewController"];
    
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
    
    
}


#pragma mark Json
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedHomeViewData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data != nil)
    {
        [receivedHomeViewData appendData:data];
    }
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString     *strResult = [[NSString alloc] initWithData:receivedHomeViewData encoding:NSUTF8StringEncoding];
    //strResult = [strResult componentsSeparatedByCharactersInSet:];
    //strResult = [strResult substringWithRange:NSMakeRange(1, [strResult length]-1)];
    //strResult =  [strResult substringToIndex:[strResult length]-1];
    
    NSArray *array = [[NSArray alloc] init];
    SBJSON *jsonParse = [SBJSON new];
    array = [jsonParse objectWithString:strResult];
    if (!array) {
        return;
    }
    
    m_newData = [[NSMutableArray alloc] initWithArray:array];
    
    ////lgilgilgi
    NSDictionary *v_dic;
    NSString *img_name;
    UIImage *v_image;
    NSURL *v_imgUrl;
    m_img_array = [[NSMutableArray alloc] init];
    
#if TESTTESTTEST
    int v_cnt = [array count];
    if ( v_cnt > 20) {
        v_cnt = 20;
    }
    for (int i = 0; i < v_cnt; i++) {
#else
        //for (int i = 0; i < [array count]; i++) {
        for (int i = 0; i < 5; i++) {
            
#endif
            
            v_dic = [m_newData objectAtIndex:i];
            img_name = [v_dic objectForKey:@"imgurl"];
            
            if (img_name == nil) {
                continue;
            }
            
            img_name = [NSString stringWithFormat:@"%@/%@", UPLOAD_IMG_URL, img_name ];
            v_imgUrl = [NSURL URLWithString:img_name];
            v_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:v_imgUrl]];
            if (!v_image) {
                v_image = [UIImage imageNamed:@"image_1.png"];
            }
            [m_img_array addObject:v_image];
        }
        
        [HUD hide:YES afterDelay:0.2];
        
        /////lgilgilgi
        
        FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
        cvLayout.delegate = self;
        cvLayout.itemWidth = 140.0f;
        cvLayout.topInset = 10.0f;
        cvLayout.bottomInset = 10.0f;
        cvLayout.stickyHeader = YES;
            
        [self.cv setCollectionViewLayout:cvLayout];
        
        [self.cv reloadData];
        
        self.segmentedControl.selectedSegmentIndex = 1;
        [self.m_textView_About setHidden:YES];
        [self.cv setHidden:NO];
        [self.m_textView_Review setHidden:YES];

        
    }


    
#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
        switch (result)
        {
            case MFMailComposeResultCancelled:
                // NSLog(@"Mail cancelled");
                break;
            case MFMailComposeResultSaved:
                // NSLog(@"Mail saved");
                break;
            case MFMailComposeResultSent:
            {
                NSLog(@"\n\n Email Sent");
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Succcess"
                                                                      message:@"Email Sent"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];

                // NSLog(@"Mail sent");
                break;
            }
            case MFMailComposeResultFailed:
                // NSLog(@"Mail sent failure: %@", [error localizedDescription]);
                break;
            default:
                break;
        }
        
        // Close the Mail Interface
        
        [self dismissViewControllerAnimated:YES completion:NULL];

        if([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
            [self dismissViewControllerAnimated:YES completion:nil];
        else
            [self dismissModalViewControllerAnimated:YES];
        //    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
