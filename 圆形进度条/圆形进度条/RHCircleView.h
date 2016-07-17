//
//  RHCircleView.h
//  圆形进度条
//
//  Created by 郭人豪 on 16/6/7.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHCircleView : UIView

//设置图片
//网络加载
- (void)setImageUrl:(NSString *)url;
//本地
- (void)setImageLocal:(NSString *)imageName;

//更新进度
- (void)updateProgressWithNumber:(NSUInteger)number;

- (void)updateProgressWithNumber:(NSUInteger)number andTimeInterval:(NSTimeInterval)time;


@end
