//
//  FindViewController.m
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "FindViewController.h"
#import "ViewController.h"




@interface FindViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.20f green:0.24f blue:0.25f alpha:1.00f];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
    headView.backgroundColor = [UIColor colorWithRed:0.12f green:0.16f blue:0.18f alpha:1.00f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(95, 30, 200, 20)];
    label.font = [UIFont systemFontOfSize:12.0];
    label.textColor = [UIColor whiteColor];
    label.text = @"输入城市、邮政编码或机场位置";
    [headView addSubview:label];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 60, 300, 40)];
    _searchBar.backgroundColor = [UIColor colorWithRed:0.12f green:0.19f blue:0.23f alpha:1.00f];
//    searchbar.barStyle =  UIBarStyleBlack;
//    searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.barStyle = UISearchBarIconSearch;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.cornerRadius = 7;
    _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchBar.delegate = self;
    
    [headView addSubview:_searchBar];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 70, 40, 25)];
    [clickButton setTitle:@"取消" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:clickButton];
    
    [self.view addSubview:headView];
    
   
    
}

//开始编辑的时候调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    _mutableArray = [[NSMutableArray alloc] init];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width,300) style:UITableViewStyleGrouped];

    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mutableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

//改变TableView的尾标题栏颜色
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithRed:0.20f green:0.24f blue:0.25f alpha:1.00f];

}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithRed:0.20f green:0.24f blue:0.25f alpha:1.00f];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    NSString *string = [NSString stringWithFormat:@"%@             %@",_mutableArray[indexPath.row][@"location"], _mutableArray[indexPath.row][@"parent_city"]];
//    cell.textLabel.text = string;
    
    cell.textLabel.text = _mutableArray[indexPath.row][@"location"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    _searchBar.text = cell1.textLabel.text;
    
    [self.tableView setHidden:YES];
    
}

//输入内容就会触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *string = [NSString stringWithFormat:@"https://search.heweather.com/find?location=%@&key=6f50849b09364be0a651d52ee9473f54", searchBar.text];
    
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (data && error == nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            self.mutableArray = dic[@"HeWeather6"][0][@"basic"];
//            NSLog(@"----%@",self.mutableArray);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            
        } else {
            NSLog(@"%@", error);
        }
        
    }];
    [dataTask resume];
    
//    [self.tableView reloadData];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.tableView endEditing:YES];
//}

////在搜索框修改搜索内容时触发
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//     [self.tableView reloadData];
//    return YES;
//
//}

//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
////    [self.tableView reloadData];
//    NSLog(@"输入搜索内容完毕");
//}


//点击搜索时执行的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([_delegate respondsToSelector:@selector(changeWithString:)]) {
        //代理传值
//        NSLog(@"------%@",searchBar.text);
        [_delegate changeWithString:searchBar.text];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)click:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
