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

    _importantMutableArray = [[NSMutableArray alloc] init];
    [_importantMutableArray addObject:@"西安"];
    [_importantMutableArray addObject:@"北京"];
    
    
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
    [self.view addSubview:footView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(330, 5, 40, 35)];
    [button setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    [footView addSubview:button];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(140, 5, 100, 35)];
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
    
    for (int i = 0; i < _cityMutableArray.count; i++) {
        NSString *string1 = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=6f50849b09364be0a651d52ee9473f54",_cityMutableArray[i]];
        
        string1 = [string1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
         NSURL *url = [NSURL URLWithString:string1];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data && error == nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                
                self.messageStr = dic[@"HeWeather6"][0][@"update"][@"loc"];
            
                self.tempStr = dic[@"HeWeather6"][0][@"now"][@"tmp"];
   
                [self.timeMutableArray addObject:self.messageStr];
                [self.tempterMutableArray addObject:self.tempStr];

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
    
}


- (void)changeWithArray:(NSMutableArray *)mutableArray {
    self.array = mutableArray;

    for (int i = 0; i < self.array.count; i++) {
        NSString *str = nil;
        for (int j = 0; j < _importantMutableArray.count; j++) {
            if ( ![self.array[i] isEqualToString:self.importantMutableArray[j]] ) {
                str = self.array[i];
            }
        }
        if (str) {
            [_importantMutableArray addObject:str];
        }
    }
    
    
    if (_cityMutableArray && self.array != nil) {
    
        NSInteger count = self.cityMutableArray.count;
        for (int i = (int)self.importantMutableArray.count - (int)self.array.count ; i < _cityMutableArray.count; i ++) {
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
