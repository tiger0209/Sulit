#import "Price_TableViewCell.h"
#import "DemoTextField.h"

@implementation Price_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.m_minPriceField = [[DemoTextField alloc] initWithFrame:CGRectMake(5,   5, 130, 30)];
        self.m_maxPriceField = [[DemoTextField alloc] initWithFrame:CGRectMake(180, 5, 130, 30)];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
