//
//  SevenWeatherTableViewCell.m
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "SevenWeatherTableViewCell.h"

@implementation SevenWeatherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_dateLabel];
        
        _pictureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_pictureImageView];
        
        
        _highTemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_highTemperatureLabel];
        
        _lowTemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_lowTemperatureLabel];
        
    }
    return self;
}

- (void)setLabel:(UILabel *)label {
    label.font = [UIFont systemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _dateLabel.frame = CGRectMake(20, 10, 110, 20);
    [self setLabel:_dateLabel];
    
    _pictureImageView.frame = CGRectMake(190, 5, 30, 30);
    
    _highTemperatureLabel.frame = CGRectMake(280, 10, 25, 20);
    [self setLabel:_highTemperatureLabel];
    
    _lowTemperatureLabel.frame = CGRectMake(330, 10, 25, 20);
    [self setLabel:_lowTemperatureLabel];
    
    
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
