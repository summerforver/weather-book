//
//  SearchViewController.h
//  weather
//
//  Created by 王一卓 on 2018/8/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchViewControllerDelegate <NSObject>

//自定义方法来反向传值
//- (void)changeWithString:(NSString *)string;
- (void)changeWithArray:(NSMutableArray *)mutableArray;

@end


@interface SearchViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *mutableArray;
@property (nonatomic, strong)NSMutableArray *messageMutableArray;
@property (nonatomic, strong)NSMutableArray *tempMutableArray;
@property (nonatomic, strong)NSMutableArray *searchMutableArray;
@property (nonatomic, strong)NSMutableArray *dateMutableArray;
@property (nonatomic, strong)NSMutableArray *rightMutableArray;
@property (nonatomic, strong)NSMutableArray *timesMutableArray;

@property (nonatomic, copy)NSString *str;
@property (nonatomic, copy)NSString *messageStr;
@property (nonatomic, copy)NSString *tempStr;

@property (nonatomic, weak) id <searchViewControllerDelegate> delegate;

@end

