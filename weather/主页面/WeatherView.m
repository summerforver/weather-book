//
//  WeatherView.m
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "WeatherView.h"
#import "HeadViewTableViewCell.h"
#import "SevenWeatherTableViewCell.h"
#import "FootTableViewCell.h"

@interface WeatherView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame addCityName:(NSString *)cityname {
    if (self = [super initWithFrame:frame]) {

        [self creatWeb:cityname];
        [self addTableView];
        
    }
    return self;
}


- (void)creatWeb:(NSString *)cityname{

    NSString *string = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=6f50849b09364be0a651d52ee9473f54",cityname];
    
    NSString *urlString = [[NSString alloc] init];
    urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data && error == nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//            NSLog(@"%@", dic);
            
            self.weatherMutableArray = [[NSMutableArray alloc] init];
            self.weatherMutableArray = dic[@"HeWeather6"];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            
        } else {
            NSLog(@"%@", error);
        }
      
    }];
    
    [dataTask resume];
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
    
    [self.tableView reloadData];
    
}

- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width,self.frame.size.height-55) style:UITableViewStyleGrouped];
    
    [_tableView registerClass:[HeadViewTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[SevenWeatherTableViewCell class] forCellReuseIdentifier:@"cell3"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell4"];
    [_tableView registerClass:[FootTableViewCell class] forCellReuseIdentifier:@"cell5"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_tableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return 5;
    } else if (section == 2) {
        return 3;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 210;
    }else if (indexPath.section == 1) {
        return 120;
    } else if (indexPath.section == 2) {
        return 40;
    } else if (indexPath.section == 3){
        return 70;
    } else {
        return 60;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.section == 0) {
        HeadViewTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        
        cell1.cityLabel.text = _weatherMutableArray[0][@"basic"][@"location"];
        cell1.messageLabel.text = _weatherMutableArray[0][@"now"][@"cond_txt"];
        NSString *str = [NSString stringWithFormat:@"%@°",_weatherMutableArray[0][@"now"][@"tmp"]];
        cell1.temperatureLabel.text = str;
        
        cell1.dateLabel.text = _weatherMutableArray[0][@"daily_forecast"][0][@"date"];
        cell1.highTemperatureLabel.text = _weatherMutableArray[0][@"daily_forecast"][0][@"tmp_max"];
        cell1.lowTemperatureLabel.text = _weatherMutableArray[0][@"daily_forecast"][0][@"tmp_min"];
        
        
        cell1.backgroundColor = [UIColor clearColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    } else if (indexPath.section == 2){
        NSArray *array = [[NSArray alloc] init];
        array = _weatherMutableArray[0][@"daily_forecast"];
        
        
        SevenWeatherTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell3.dateLabel.text = array[indexPath.row][@"date"];
        cell3.highTemperatureLabel.text = array[indexPath.row][@"tmp_max"];
        cell3.lowTemperatureLabel.text = array[indexPath.row][@"tmp_min"];
        cell3.pictureImageView.image = [UIImage imageNamed:array[indexPath.row][@"cond_code_d"]];
        
        cell3.backgroundColor = [UIColor clearColor];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    } else if (indexPath.section == 4) {
        FootTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        NSArray *leftArray = [NSArray arrayWithObjects:@"日出", @"降水概率", @"风速", @"降水量", @"能见度", nil];
        NSArray *rightArray = [NSArray arrayWithObjects:@"日落", @"湿度", @"体感温度", @"气压", @"紫外线指数", nil];
        NSDictionary *dict = [[NSDictionary alloc] init];
        dict = _weatherMutableArray[0][@"daily_forecast"][0];

        NSArray *leftMessageArray = [NSArray arrayWithObjects:dict[@"sr"],dict[@"pop"], dict[@"wind_dir"], dict[@"pcpn"], dict[@"vis"], nil];
        
        NSArray *rightMessageArray = [NSArray arrayWithObjects:dict[@"ss"], dict[@"hum"], _weatherMutableArray[0][@"now"][@"fl"], dict[@"pres"], dict[@"uv_index"], nil];
        
        cell5.nameLabel.text = leftArray[indexPath.row];
        
        if (leftMessageArray != nil && ![leftMessageArray isKindOfClass:[NSNull class]] && leftMessageArray.count != 0) {
            
            cell5.messageLabel.text = leftMessageArray[indexPath.row];
        }
        if (rightMessageArray != nil && ![rightMessageArray isKindOfClass:[NSNull class]] && rightMessageArray.count != 0) {
            
            cell5.messageSecondLabel.text = rightMessageArray[indexPath.row];
        }
        cell5.nameSecondLabel.text = rightArray[indexPath.row];
        
        cell5.backgroundColor = [UIColor clearColor];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell5;
        
    } else if (indexPath.section == 3) {
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 330, 60)];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.text = _weatherMutableArray[0][@"lifestyle"][0][@"txt"];
        label.font = [UIFont systemFontOfSize:16.0];
        [cell4.contentView addSubview:label];
        
        cell4.backgroundColor = [UIColor clearColor];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"123";
        
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
