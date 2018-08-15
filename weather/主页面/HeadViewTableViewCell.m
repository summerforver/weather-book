//
//  HeadViewTableViewCell.m
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "HeadViewTableViewCell.h"

@implementation HeadViewTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
        [self.contentView addSubview:_cityLabel];
        
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 20)];
        [self.contentView addSubview:_messageLabel];
        
        
        _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 70)];
        [self.contentView addSubview:_temperatureLabel];
       
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 110, 20)];
       [self.contentView addSubview:_dateLabel];
        
        
        _todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 182, 35, 20)];
       [self.contentView addSubview:_todayLabel];
        
        _highTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 180, 25, 20)];
        [self.contentView addSubview:_highTemperatureLabel];
        
        
        _lowTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(330, 180, 25, 20)];
     
        [self.contentView addSubview:_lowTemperatureLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.font = [UIFont systemFontOfSize:30.0];
    
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.font = [UIFont systemFontOfSize:16.0];
   
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.textAlignment = NSTextAlignmentCenter;
    _temperatureLabel.font = [UIFont systemFontOfSize:80.0];
  
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.font = [UIFont systemFontOfSize:20.0];
    
    _todayLabel.textColor = [UIColor whiteColor];
    _todayLabel.font = [UIFont systemFontOfSize:14.0];
    _todayLabel.text = @"今天";
 
    _highTemperatureLabel.textColor = [UIColor whiteColor];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:20.0];

    _lowTemperatureLabel.textColor = [UIColor whiteColor];
    _lowTemperatureLabel.font = [UIFont systemFontOfSize:20.0];
   
    
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
