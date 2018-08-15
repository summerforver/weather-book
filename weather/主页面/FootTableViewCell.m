//
//  FootTableViewCell.m
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "FootTableViewCell.h"

@implementation FootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        _messageLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_messageLabel];
        
        _nameSecondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameSecondLabel];
        
        _messageSecondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_messageSecondLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(20, 7, 100, 15);
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:12.0];
    
    _messageLabel.frame = CGRectMake(20, 23, 170, 30);
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.font = [UIFont systemFontOfSize:26.0];
    
    _nameSecondLabel.frame = CGRectMake(190, 7, 100, 15);
    _nameSecondLabel.textColor = [UIColor whiteColor];
    _nameSecondLabel.font = [UIFont systemFontOfSize:12.0];
    
    _messageSecondLabel.frame = CGRectMake(190, 23, 180, 30);
    _messageSecondLabel.textColor = [UIColor whiteColor];
    _messageSecondLabel.font = [UIFont systemFontOfSize:26.0];
    
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
