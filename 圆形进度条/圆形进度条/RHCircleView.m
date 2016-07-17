//
//  RHCircleView.m
//  圆形进度条
//
//  Created by 郭人豪 on 16/6/7.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "RHCircleView.h"
#import "UIImageView+WebCache.h"

#define kLineWidth 2


@interface RHCircleView ()

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) CAShapeLayer * outLayer;

@property (nonatomic, strong) CAShapeLayer * progressLayer;

@end

@implementation RHCircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        
        //设置图片
        self.layer.cornerRadius = width/2.0;
        
        self.layer.masksToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imageView];
        
        //添加灰色圆环
        _outLayer = [CAShapeLayer layer];
        
        CGRect rect = CGRectMake(kLineWidth/2.0, kLineWidth/2.0, width - kLineWidth, height - kLineWidth);
        
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        //画笔颜色
        _outLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        
        //线宽(圆环宽)
        _outLayer.lineWidth = kLineWidth;
        
        //填充颜色
        _outLayer.fillColor = [UIColor clearColor].CGColor;
        
        _outLayer.lineCap = kCALineCapRound;
        
        _outLayer.path = path.CGPath;
        
        [self.layer addSublayer:_outLayer];
        
        //添加蓝色进度圆环
        _progressLayer = [CAShapeLayer layer];
        
        _progressLayer.strokeColor = [UIColor blueColor].CGColor;
        
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        
        _progressLayer.lineWidth = kLineWidth;
        
        _progressLayer.lineCap = kCALineCapRound;
        
        _progressLayer.path = path.CGPath;
        
        [self.layer addSublayer:_progressLayer];
        
        //旋转调整起点进度
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
        //旋转图片调整图片方向
        _imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }
    return self;
}


- (void)setImageUrl:(NSString *)url{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
}

- (void)setImageLocal:(NSString *)imageName{
    
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)updateProgressWithNumber:(NSUInteger)number{
    
    [CATransaction begin];
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [CATransaction setAnimationDuration:0];
    
    _progressLayer.strokeEnd = number/100.0;
    
    [CATransaction commit];
    
}

- (void)updateProgressWithNumber:(NSUInteger)number andTimeInterval:(NSTimeInterval)time{
    
    [CATransaction begin];
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [CATransaction setAnimationDuration:time];
    
    _progressLayer.strokeEnd = number/100.0;
    
    [CATransaction commit];
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
