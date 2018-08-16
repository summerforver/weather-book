//
//  ViewController.m
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ViewController.h"
#import "HeadViewTableViewCell.h"
#import "SevenWeatherTableViewCell.h"
#import "FootTableViewCell.h"
#import "SearchViewController.h"
#import "WeatherView.h"
#import "FindViewController.h"

@interface ViewController ()
<UIScrollViewDelegate,searchViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    _cityMutableArray = [[NSMutableArray alloc] init];
    [_cityMutableArray addObject:@"西安"];
    [_cityMutableArray addObject:@"北京"];
//    [_cityMutableArray addObject:@"上海"];
    
    _timeMutableArray = [[NSMutableArray alloc] init];
    _tempterMutableArray = [[NSMutableArray alloc] init];
    
    self.navigationController.navigationBarHidden = YES;
    
    _scrollView = [[UIScrollView alloc] init];

    _scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
    
    _scrollView.backgroundColor = [UIColor colorWithRed:0.00f green:0.60f blue:0.80f alpha:1.00f];
    
    _scrollView.directionalLockEnabled = NO;
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.scrollEnabled = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(375*_cityMutableArray.count, [UIScreen mainScreen].bounds.size.height - 40);
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 625, [UIScreen mainScreen].bounds.size.width, 45)];
    footView.backgroundColor = [UIColor colorWithRed:0.00f green:0.60f blue:0.80f alpha:1.00f];
    //    footView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:footView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(330, 5, 40, 35)];
    [button setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    [footView addSubview:button];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(140, 5, 100, 35)];
//    int count = 3;
    self.pageControl.numberOfPages = _cityMutableArray.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.57f green:0.75f blue:0.88f alpha:1.00f];
    [_pageControl addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventValueChanged];
    
    [footView addSubview:_pageControl];

    for (int i = 0; i < _cityMutableArray.count; i++) {
        
        WeatherView *weather = [[WeatherView alloc] initWithFrame:CGRectMake(375*i, 0, [UIScreen mainScreen].bounds.size.width , _scrollView.frame.size.height) addCityName:_cityMutableArray[i]];

        [self.scrollView addSubview:weather];
        
    }
    [self.view addSubview:_scrollView];
    
    [self creatInternetRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transport:) name:@"row" object:nil];
    
}

- (void)creatInternetRequest {
//    NSLog(@"%@",_cityMutableArray);
    
    for (int i = 0; i < _cityMutableArray.count; i++) {
        NSString *string1 = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=6f50849b09364be0a651d52ee9473f54",_cityMutableArray[i]];
        
        string1 = [string1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
         NSURL *url = [NSURL URLWithString:string1];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data && error == nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //                    NSLog(@"%@", dic);
                
                self.messageStr = dic[@"HeWeather6"][0][@"update"][@"loc"];
                
//                                    NSLog(@"%@", self.messageStr);
                //                    NSLog(@"%@", dic[@"HeWeather6"][0][@"update"][@"loc"]);
                
                
                
                self.tempStr = dic[@"HeWeather6"][0][@"now"][@"tmp"];
                //                    NSLog(@"%@", dic[@"HeWeather6"][0][@"now"][@"tmp"]);
//                                    NSLog(@"%@", self.tempStr);
            
//                                    if (self.timeMutableArray != nil && self.tempterMutableArray != nil) {
                
                [self.timeMutableArray addObject:self.messageStr];
                [self.tempterMutableArray addObject:self.tempStr];
//                                    }
                
//                NSLog(@"%@", self.timeMutableArray);
                
                
//                NSLog(@"%@", self.tempterMutableArray);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                   
//                    [self.tableView reloadData];
                }];
                
                
            } else {
                NSLog(@"%@", error);
            }
            
        }];
            [dataTask resume];
    }
    
}

- (void)clickAction:(UIPageControl *)page {
    _scrollView.contentOffset = CGPointMake(page.currentPage * self.scrollView.frame.size.width, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        int page = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        self.pageControl.currentPage = page;
    }
    
    
}



- (void)clickButton:(UIButton *)sender {
    SearchViewController *viewControl = [[SearchViewController alloc] init];

    viewControl.searchMutableArray = self.cityMutableArray;
    viewControl.dateMutableArray = self.timeMutableArray;
    viewControl.rightMutableArray = self.tempterMutableArray;
    
    
    viewControl.delegate = self;

    
    [self.navigationController pushViewController:viewControl animated:YES];
//    [self presentViewController:viewControl animated:YES completion:nil];
    
    
}

//- (void)changeWithString:(NSString *)string {
//
//
//    self.string = string;
//
//
////     NSLog(@"%@", self.string);
//    int flag = 1;
//    for (int i = 0; i <_cityMutableArray.count-1; i ++) {
//        if ([self.string isEqualToString:_cityMutableArray[i]]) {
//            flag = 0;
//        }
//    }
////    NSLog(@"%d", flag);
//    if (_cityMutableArray && flag == 1 && self.string != nil) {
//
////            [_cityMutableArray addObject:self.string];
//            NSInteger count = self.cityMutableArray.count;
//
////        NSLog(@"%ld",count );
//
//            self.scrollView.contentSize = CGSizeMake(375*self.cityMutableArray.count, [UIScreen mainScreen].bounds.size.height - 40);
//
//            WeatherView *weather = [[WeatherView alloc] initWithFrame:CGRectMake(375*(count-1), 0, [UIScreen mainScreen].bounds.size.width , self.scrollView.frame.size.height) addCityName:self.cityMutableArray[count-1]];
//            [self.scrollView addSubview:weather];
//
//            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*(count-1), 0) animated:NO];
//
//            self.pageControl.numberOfPages = self.cityMutableArray.count;
//            int page = self.scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
//            self.pageControl.currentPage = page;
//
//    }
//}

- (void)changeWithArray:(NSMutableArray *)mutableArray {
//    NSLog(@"%ld",self.cityMutableArray.count);
    self.array = mutableArray;
//    [_cityMutableArray addObjectsFromArray:self.array];
    
    
//    NSLog(@"%ld",self.array.count);
    NSLog(@"%@pppqpqppq",self.array);
    NSLog(@"%ld",self.cityMutableArray.count);
    //     NSLog(@"%@", self.string);
//    int flag = 1;
//    for (int i = 0; i <_cityMutableArray.count-1; i ++) {
//        if ([self.string isEqualToString:_cityMutableArray[i]]) {
//            flag = 0;
//        }
//    }
    //    NSLog(@"%d", flag);
//    if (_cityMutableArray && flag == 1 && self.array != nil) {
    
    
//    for (int i = 0; i < self.array.count; i++) {
//        NSString *str = nil;
//        for (int j = 0; j < _cityMutableArray.count-1; j++) {
//            if ([self.array[i] isEqualToString:_cityMutableArray[j]]) {
//
//                str = self.array[i];
//                NSLog(@"----%@",str);
//            }
//        }
//        if (str) {
//            [_cityMutableArray removeObject:str];
//        }
//    }
//
    
    
    if (_cityMutableArray && self.array != nil) {
        
        
        //改city数组 从第一个界面属性传值过来的时候city数组已经自己加上了 
    
        //            [_cityMutableArray addObject:self.string];
        NSInteger count = self.cityMutableArray.count;
        
        NSLog(@"%ld======",self.cityMutableArray.count);
        
        for (int i = (int)self.cityMutableArray.count + (int)self.array.count - 1 ; i < _cityMutableArray.count; i ++) {
            WeatherView *weather = [[WeatherView alloc] initWithFrame:CGRectMake(375*i, 0, [UIScreen mainScreen].bounds.size.width , self.scrollView.frame.size.height) addCityName:self.cityMutableArray[i]];
            [self.scrollView addSubview:weather];
        }
        
        self.scrollView.contentSize = CGSizeMake(375*self.cityMutableArray.count, [UIScreen mainScreen].bounds.size.height - 40);
        
        
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*(count-1), 0) animated:NO];
        
        self.pageControl.numberOfPages = self.cityMutableArray.count;
        int page = self.scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        self.pageControl.currentPage = page;
        
    }
}





- (void)transport:(NSNotification *)text {
    
    NSNumber *a = [[NSNumber alloc] init];
    a = text.userInfo[@"number"];
    
    int i = [a intValue];
//    NSLog(@"%d",i);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*i, 0) animated:NO];
        
        self.pageControl.currentPage = i;
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
