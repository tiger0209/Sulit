#import "Category_TableViewCell.h"

@implementation Category_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.m_CategoryName = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        self.m_CategoryCheckBox = [[M13Checkbox alloc] init];
        [self.m_CategoryCheckBox setFrame:CGRectMake(280, 5, 30, 30)];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
