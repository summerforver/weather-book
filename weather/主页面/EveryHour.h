//
//  EveryHour.h
//  weather
//
//  Created by 王一卓 on 2018/8/16.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EveryHour : UIView

@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *pictureView;

@property (nonatomic, strong)UILabel *weatherLabel;
@property (nonatomic, strong)UILabel *temLabel;


- (void)setDataTimeLabel:(NSString *)timeString addImageView:(UIImage *)viewImage addWeather:(NSString *)weatherString addTemLabel:(NSString *)temString ;
@end
