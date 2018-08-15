//
//  HeadViewTableViewCell.h
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadViewTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *cityLabel;
@property (nonatomic, strong)UILabel *messageLabel;
@property (nonatomic, strong)UILabel *temperatureLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *todayLabel;
@property (nonatomic, strong)UILabel *highTemperatureLabel;
@property (nonatomic, strong)UILabel *lowTemperatureLabel;

@end
