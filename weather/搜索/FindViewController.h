//
//  FindViewController.h
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol twoViewControllerDelegate <NSObject>

//自定义方法来反向传值
- (void)changeWithString:(NSString *)string;

@end

@interface FindViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *mutableArray;
//@property (nonatomic, strong)NSMutableArray *array;

//@property (nonatomic, strong)NSString *str;

@property (nonatomic, weak) id <twoViewControllerDelegate> delegate;
@end
