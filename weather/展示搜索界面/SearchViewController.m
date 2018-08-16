//
//  SearchViewController.m
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "FindViewController.h"
#import "ViewController.h"

@interface SearchViewController ()
<UITableViewDelegate, UITableViewDataSource, twoViewControllerDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.00f green:0.60f blue:0.80f alpha:1.00f];
    
//    _mutableArray = [NSMutableArray arrayWithObjects:@"西安",@"北京", nil];
//    self.messageMutableArray = [[NSMutableArray alloc] init];
//    self.messageMutableArray = [[NSMutableArray alloc] init];
//    self.tempMutableArray = [[NSMutableArray alloc] init];
    
    self.mutableArray = self.searchMutableArray;
    self.messageMutableArray = self.dateMutableArray;
    self.tempMutableArray = self.rightMutableArray;
    
    
//    _messageMutableArray = [[NSMutableArray alloc] init];
//    _messageMutableArray = [NSMutableArray arrayWithObjects:@"14:20",@"14:20",nil];8
    
//    _tempMutableArray = [[NSMutableArray alloc] init];
//    _tempMutableArray = [NSMutableArray arrayWithObjects:@"35",@"34", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:_tableView];
    
}

- (void)changeWithString:(NSString *)string {
    self.str = string;
    
    if (_timesMutableArray == nil) {
        _timesMutableArray = [[NSMutableArray alloc] init];
    }
    [_timesMutableArray addObject:string];
    NSLog(@"%@",_timesMutableArray);
    
    //    NSLog(@"%@",_timesMutableArray);
    
    int flag = 1;
    for (int i = 0; i <_mutableArray.count; i ++) {
        if ([self.str isEqualToString:_mutableArray[i]]) {
            flag = 0;
        }
    }
    
    if (_mutableArray && flag == 1) {
        
        [_mutableArray addObject:self.str];
        
        //        for (int j = 0; j < _mutableArray.count; j++) {
        
        NSString *string1 = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=6f50849b09364be0a651d52ee9473f54",self.str];
        
        string1 = [string1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *url = [NSURL URLWithString:string1];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            if (data && error == nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //                    NSLog(@"%@", dic);
                
                self.messageStr = dic[@"HeWeather6"][0][@"update"][@"loc"];
                
                //                    NSLog(@"%@", self.messageStr);
                //                    NSLog(@"%@", dic[@"HeWeather6"][0][@"update"][@"loc"]);
                
                
                
                self.tempStr = dic[@"HeWeather6"][0][@"now"][@"tmp"];
                //                    NSLog(@"%@", dic[@"HeWeather6"][0][@"now"][@"tmp"]);
                //                    NSLog(@"%@", self.tempStr);
                
                //                    if (self.messageMutableArray != nil && self.tempMutableArray != nil) {
                
                [self.messageMutableArray addObject:self.messageStr];
                [self.tempMutableArray addObject:self.tempStr];
                
                //                    }
                
                //                    NSLog(@"%@", self.messageMutableArray);
                
                
                //                    NSLog(@"%@", self.tempMutableArray);
                
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadData];
                }];
                
            } else {
                NSLog(@"%@", error);
            }
            
        }];
        [dataTask resume];
        
        //            [self.tableView reloadData];
    }
    
    //        }
    //
    //    [self.tableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _mutableArray.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
        
        SearchTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (_messageMutableArray != nil && ![_messageMutableArray isKindOfClass:[NSNull class]] && _messageMutableArray.count != 0) {
            
            cell1.firstLabel.text = _messageMutableArray[indexPath.row];
        }
        if (_mutableArray != nil && ![_mutableArray isKindOfClass:[NSNull class]] && _mutableArray.count != 0) {
            
            cell1.secondLabel.text = _mutableArray[indexPath.row];
        }
        if (_tempMutableArray != nil && ![_tempMutableArray isKindOfClass:[NSNull class]] && _tempMutableArray.count != 0) {
            
//            NSString *str = [NSString stringWithFormat:@"%@°",_tempMutableArray[indexPath.row]];
            
            cell1.thirdLabel.text = [NSString stringWithFormat:@"%@°",_tempMutableArray[indexPath.row]];
        }
        
        
//        cell1.thirdLabel.text = _tempMutableArray[indexPath.row];
        cell1.backgroundColor = [UIColor clearColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    } else {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(330, 10, 30, 30)];
        [button setImage:[UIImage imageNamed:@"11111"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        
        [cell2.contentView addSubview:button];
//        cell2.textLabel.text = @"123";
        cell2.backgroundColor = [UIColor clearColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell2.selected = NO;
        return cell2;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
//    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//
//    self.str = cell.textLabel.text;
//
//    ViewController *viewCon = [[ViewController alloc] init];
//    [self.navigationController pushViewController:viewCon animated:YES];
    
//    NSLog(@"%ld",self.mutableArray.count);
    
    
    NSNumber *number = [NSNumber numberWithInteger:indexPath.row];
    NSDictionary *dict = @{@"number":number};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"row" object:nil userInfo:dict];
    
    
//    if ([_delegate respondsToSelector:@selector(changeWithString:)]) {
//        //代理传值
////        NSLog(@"%@",self.str);
//        [_delegate changeWithString:self.str];
//
//    }
//
    NSLog(@"111%@",_timesMutableArray);
    if ([_delegate respondsToSelector:@selector(changeWithArray:)]) {
        [_delegate changeWithArray:_timesMutableArray];
    }
//
//    [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)clickButton:(UIButton *)sender {
    
    
    FindViewController *findViewControl = [[FindViewController alloc] init];
    
    findViewControl.delegate = self;
    
//    [self presentViewController:findViewControl animated:YES completion:nil];
    
    [self.navigationController pushViewController:findViewControl animated:YES];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
