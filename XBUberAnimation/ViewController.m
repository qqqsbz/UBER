//
//  ViewController.m
//  XBUberAnimation
//
//  Created by coder on 16/9/30.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
@property (strong, nonatomic) UIView        *circleView;
@property (strong, nonatomic) UIImageView   *logoImageView;
@property (strong, nonatomic) MPMoviePlayerController *playerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initView];
    
    [self performSelector:@selector(startCircleAnimation) withObject:nil afterDelay:2.f];
    
    [self performSelector:@selector(startLogoAnimation) withObject:nil afterDelay:2.f];
    
    [self performSelector:@selector(startPlayer) withObject:nil afterDelay:4.5f];
}

- (void)initView {
    
    //初始化并设置大小
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 20, CGRectGetWidth(self.view.frame) - 20)];
    
    //在屏幕中间显示
    self.circleView.center = self.view.center;
    
    //边框长度
    self.circleView.layer.borderWidth = 2.f;
    
    //边框颜色
    self.circleView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    
    //去除不在圆内部分
    self.circleView.layer.masksToBounds = YES;
    
    //设置为圆形
    self.circleView.layer.cornerRadius  = CGRectGetWidth(self.circleView.frame) / 2.f;
    
    //将图片设置成背景颜色
    self.circleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yyy"]];
    
    
    //获取要播放动画的图片
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:68];
    
    for (int i = 1; i < 68; i ++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"logo-%03d",i]];
        
        [images addObject:image];
        
    }
    
    //初始化并设置大小
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.circleView.frame), 277)];
    
    //设置在屏幕中央
    self.logoImageView.center = self.view.center;
    
    //设置要播放动画的图片
    self.logoImageView.animationImages = images;
    
    //设置动画播放时间
    self.logoImageView.animationDuration = 5.f;
    
    //不允许重复播放
    self.logoImageView.animationRepeatCount = 1;
    
    [self.view insertSubview:self.logoImageView atIndex:self.view.subviews.count];
    
    //获取视频路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    //设置为自动播放
    self.playerController.shouldAutoplay = YES;
    
    //设置frame
    self.playerController.view.frame = self.view.bounds;
    
    //设置透明度
    self.playerController.view.alpha = 0;
    
    //设置进度条不显示
    self.playerController.controlStyle = MPMovieControlStyleNone;
    
    //设置重复播放
    [self.playerController setRepeatMode:MPMovieRepeatModeOne];
    
    [self.view insertSubview:self.playerController.view atIndex:self.view.subviews.count - 1];
}

- (void)startCircleAnimation {
    
    //设置缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.fromValue = @0;
    
    scaleAnimation.toValue   = @1;
    
    //动画播放时间
    scaleAnimation.duration  = 0.5;
    
    //动画执行完毕后不移除
    scaleAnimation.removedOnCompletion = NO;
    
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    [self.circleView.layer addAnimation:scaleAnimation forKey:@"scale"];
    
    [self.view insertSubview:self.circleView atIndex:self.view.subviews.count - 2];
    
}

- (void)startLogoAnimation {
    
    [UIView animateWithDuration:3 animations:^{
        
        self.circleView.alpha = 0;
        
    }];
    
    self.logoImageView.image = [UIImage imageNamed:@"logo-067"];
    
    [self.logoImageView startAnimating];
    
}

- (void)startPlayer {
    
    [UIView animateWithDuration:3 animations:^{
        
        self.playerController.view.alpha = 1;
        
        [self.playerController prepareToPlay];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
