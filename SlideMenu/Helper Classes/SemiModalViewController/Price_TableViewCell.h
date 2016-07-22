#import <UIKit/UIKit.h>
@class DemoTextField;

@interface Price_TableViewCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UITextField            *m_minPriceField;
@property (nonatomic, strong) IBOutlet UILabel                  *m_ToLabel;
@property (nonatomic, strong) IBOutlet UITextField            *m_maxPriceField;
@end
