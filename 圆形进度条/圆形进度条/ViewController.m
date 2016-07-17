//
//  ViewController.m
//  圆形进度条
//
//  Created by 郭人豪 on 16/6/7.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "ViewController.h"
#import "RHCircleView.h"


#define TIME 0.1

@interface ViewController ()

@property (nonatomic, strong) RHCircleView * cricleView;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, assign) NSUInteger number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _number = 0;
    
    [self createUI];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -- create UI
- (void)createUI{
    
    _cricleView = [[RHCircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    _cricleView.center = CGPointMake(self.view.center.x, 200);
    
    [_cricleView setImageLocal:@"mv003.jpg"];
    
    [_cricleView updateProgressWithNumber:0];
    
    [self.view addSubview:_cricleView];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    _button.center = CGPointMake(self.view.center.x, CGRectGetMaxY(_cricleView.frame)+100);
    
    _button.layer.cornerRadius = 5;
    _button.layer.masksToBounds = YES;
    
    _button.backgroundColor = [UIColor greenColor];
    
    [_button setTitle:@"开始" forState:UIControlStateNormal];
    
    [_button addTarget:self action:@selector(buttonCllick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
}

#pragma mark -- button action
- (void)buttonCllick:(UIButton *)button{
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:TIME target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
        
        [button setTitle:@"暂停" forState:UIControlStateNormal];
        
    }else {
        
        button.selected = !button.selected;
        
        if (button.selected) {
            
            [button setTitle:@"继续" forState:UIControlStateNormal];
            
            _timer.fireDate = [NSDate distantFuture];
            
        }else {
            
            [button setTitle:@"暂停" forState:UIControlStateNormal];
            
            _timer.fireDate = [NSDate distantPast];
        }
        
    }
    
}


- (void)updateProgress:(NSTimer *)timer{
    
    _number++;
    
    [_cricleView updateProgressWithNumber:_number andTimeInterval:TIME];
    
    if (_number == 100) {
        
        [_timer invalidate];
        
        _timer = nil;
        
        [_button setTitle:@"开始" forState:UIControlStateNormal];
        
        _number = 0;
        
        [_cricleView updateProgressWithNumber:_number];
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
