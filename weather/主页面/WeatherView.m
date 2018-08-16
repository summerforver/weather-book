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
#import "EveryHour.h"

@interface WeatherView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame addCityName:(NSString *)cityname {
    if (self = [super initWithFrame:frame]) {

        [self creatWeb:cityname];
        
//        [self creatInternetRequest:cityname];
        
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

- (void)creatInternetRequest:(NSString *)cityname{
    
    NSString *string1 = [NSString stringWithFormat:@"https://api.jisuapi.com/weather/query?appkey=1c40a96656a7763e&city=%@",cityname];
    
    NSString *urlString1 = [[NSString alloc] init];
    urlString1 = [string1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url1 = [NSURL URLWithString:urlString1];
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //            NSLog(@"%@", dic);
            
            self.hourMutableArray = [[NSMutableArray alloc] init];
            self.tianqiMutableArray = [[NSMutableArray alloc] init];
            self.imgMutableArray = [[NSMutableArray alloc] init];
            self.tempMutableArray = [[NSMutableArray alloc] init];
//            self.hourMutableArray = dic1[@"result"][@"hourly"];
            for (int i = 0; i < 24; i++) {
                
                [self.hourMutableArray addObject:dic1[@"result"][@"hourly"][i][@"time"]];
                
                [self.tianqiMutableArray addObject:dic1[@"result"][@"hourly"][i][@"weather"]];
                
                [self.imgMutableArray addObject:dic1[@"result"][@"hourly"][i][@"img"]];
                [self.tempMutableArray addObject:dic1[@"result"][@"hourly"][i][@"temp"]];
                
            }
        
            
//            NSLog(@"------%@",self.hourMutableArray);
            
//
//            NSLog(@"=====%@",self.tianqiMutableArray);
            
//            NSLog(@"%@",self.imgMutableArray);
            
//            NSLog(@"%@",self.tempMutableArray);
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSLog(@"24242");
                [self.tableView reloadData];
            }];
            
        } else {
            NSLog(@"%@", error);
        }
        
    }];
    
    [dataTask1 resume];
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
    
    [self.tableView reloadData];
    
}

- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width,self.frame.size.height-55) style:UITableViewStylePlain];
    
    [_tableView registerClass:[HeadViewTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[SevenWeatherTableViewCell class] forCellReuseIdentifier:@"cell3"];
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell4"];
    [_tableView registerClass:[FootTableViewCell class] forCellReuseIdentifier:@"cell5"];
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
        
        
        NSString *string2 = [NSString stringWithFormat:@"%@公里",dict[@"vis"]];
        NSString *str = [[NSString alloc] init];
        str = @"%";
        NSString *string4 = [NSString stringWithFormat:@"%@%@", dict[@"pop"],str];

        NSArray *leftMessageArray = [NSArray arrayWithObjects:dict[@"sr"],string4, dict[@"wind_dir"], dict[@"pcpn"], string2, nil];
        
        NSString *string1 = [NSString stringWithFormat:@"%@°", _weatherMutableArray[0][@"now"][@"fl"]];
        NSString *string3 = [NSString stringWithFormat:@"%@百帕",dict[@"pres"] ];
        NSString *string5 = [NSString stringWithFormat:@"%@%@", dict[@"hum"],str];
    
        NSArray *rightMessageArray = [NSArray arrayWithObjects:dict[@"ss"], string5, string1, string3, dict[@"uv_index"], nil];
        
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
        if (cell4 == nil) {
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 330, 60)];
            _label.numberOfLines = 0;
            _label.textColor = [UIColor whiteColor];
            
            _label.font = [UIFont systemFontOfSize:16.0];
            [cell4.contentView addSubview:_label];
            
        }
        _label.text = _weatherMutableArray[0][@"lifestyle"][0][@"txt"];
        
        
        cell4.backgroundColor = [UIColor clearColor];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        cell.textLabel.text = @"123";
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 120)];
            
            scrollerView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
            scrollerView.pagingEnabled = YES;
            scrollerView.scrollEnabled = YES;
            scrollerView.showsHorizontalScrollIndicator = NO;
            scrollerView.bounces = YES;
       
            scrollerView.contentSize = CGSizeMake(62*24, 120);

            [cell.contentView addSubview:scrollerView];

            _abvMutableArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < 24; i ++) {
                
                EveryHour *view = [[EveryHour alloc] init];
                
                view.frame = CGRectMake(62*i, 0, 62, 120);
                
                [scrollerView addSubview:view];
                [_abvMutableArray addObject:view];
                
            }
        }
        //scrollView数据源
        for (int i = 0; i < 24; i ++) {
            EveryHour *view = [_abvMutableArray objectAtIndex:i];
            
            if (i == 0) {
                [view setDataTimeLabel:@" 现在" addImageView:[UIImage imageNamed:_imgMutableArray[i]] addWeather:_tianqiMutableArray[i] addTemLabel: [NSString stringWithFormat:@"%@°",_tempMutableArray[i]]];
            } else {
                [view setDataTimeLabel: _hourMutableArray[i] addImageView:[UIImage imageNamed:_imgMutableArray[i]] addWeather:_tianqiMutableArray[i] addTemLabel: [NSString stringWithFormat:@"%@°",_tempMutableArray[i]]];
                
            }
        }
        
        
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
