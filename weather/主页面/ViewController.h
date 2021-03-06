//
//  ViewController.h
//  weather
//
//  Created by 王一卓 on 2018/8/13.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)NSMutableArray *cityMutableArray;
@property (nonatomic, strong)NSMutableArray *importantMutableArray;
@property (nonatomic, strong)NSMutableArray *timeMutableArray;
@property (nonatomic, strong)NSMutableArray *tempterMutableArray;
@property (nonatomic, strong)NSMutableArray *array;

@property (nonatomic, copy)NSString *messageStr;
@property (nonatomic, copy)NSString *tempStr;

@end

