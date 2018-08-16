//
//  EveryHour.m
//  weather
//
//  Created by 王一卓 on 2018/8/16.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "EveryHour.h"

@implementation EveryHour

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, 50, 20)];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_timeLabel];
        
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 32, 30, 30)];
        [self addSubview:_pictureView];
        
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 40, 20)];
        _weatherLabel.textAlignment = NSTextAlignmentCenter;
        _weatherLabel.textColor = [UIColor whiteColor];
        _weatherLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:_weatherLabel];
        
        _temLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 40, 20)];
    
        _temLabel.textColor = [UIColor whiteColor];
        _temLabel.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_temLabel];
        
       
        
    }
    return self;
}
- (void)setDataTimeLabel:(NSString *)timeString addImageView:(UIImage *)viewImage addWeather:(NSString *)weatherString addTemLabel:(NSString *)temString {
    self.timeLabel.text = timeString;
    self.pictureView.image = viewImage;
    self.weatherLabel.text = weatherString;
    self.temLabel.text = temString;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
