//
//  SearchTableViewCell.m
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_firstLabel];
        
        _secondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_secondLabel];
        
        _thirdLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_thirdLabel];
        

        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _firstLabel.frame = CGRectMake(15, 15, 150, 15);
    _firstLabel.font = [UIFont systemFontOfSize:12.0];
    _firstLabel.textColor = [UIColor whiteColor];
    
    
    _secondLabel.frame = CGRectMake(15, 30, 220, 40);
    _secondLabel.font = [UIFont systemFontOfSize:26.0];
    _secondLabel.textColor = [UIColor whiteColor];
    
    _thirdLabel.frame = CGRectMake(270, 10, 90, 60);
    _thirdLabel.font = [UIFont systemFontOfSize:50.0];
    _thirdLabel.textColor = [UIColor whiteColor];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
