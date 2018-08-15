//
//  WeatherView.h
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *weatherMutableArray;
@property (nonatomic, copy)NSString *cityName;

- (instancetype)initWithFrame:(CGRect)frame addCityName:(NSString *)cityname;
@end
