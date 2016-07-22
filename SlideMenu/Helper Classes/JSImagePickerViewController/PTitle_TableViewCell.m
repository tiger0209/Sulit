
#import "PTitle_TableViewCell.h"
#import "DemoTextField.h"

@implementation PTitle_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.m_titleField = [[DemoTextField alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
