//
//  SearchViewController.h
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol twViewControllerDelegate <NSObject>

//自定义方法来反向传值
- (void)changeWithString:(NSString *)string;

@end


@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *mutableArray;

@property (nonatomic, strong)NSMutableArray *messageMutableArray;

@property (nonatomic, strong)NSMutableArray *tempMutableArray;

@property (nonatomic, copy)NSString *str;

@property (nonatomic, copy)NSString *messageStr;
@property (nonatomic, copy)NSString *tempStr;

@property (nonatomic, weak) id <twViewControllerDelegate> delegate;

@end
