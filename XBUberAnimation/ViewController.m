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
    
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 20, CGRectGetWidth(self.view.frame) - 20)];
    
    self.circleView.center = self.view.center;
    
    self.circleView.layer.borderWidth = 2.f;
    
    self.circleView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    
    self.circleView.layer.masksToBounds = YES;
    
    self.circleView.layer.cornerRadius  = CGRectGetWidth(self.circleView.frame) / 2.f;
    
    self.circleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yyy"]];
    
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:68];
    
    for (int i = 1; i < 68; i ++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"logo-%03d",i]];
        
        [images addObject:image];
        
    }
    
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.circleView.frame), 277)];
    
    self.logoImageView.center = self.view.center;
    
    self.logoImageView.animationImages = images;
    
    self.logoImageView.animationDuration = 5.f;
    
    self.logoImageView.animationRepeatCount = 1;
    
    [self.view insertSubview:self.logoImageView atIndex:self.view.subviews.count];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    self.playerController.shouldAutoplay = YES;
    
    self.playerController.view.frame = self.view.bounds;
    
    self.playerController.view.alpha = 0;
    
    self.playerController.controlStyle = MPMovieControlStyleNone;
    
    [self.playerController setRepeatMode:MPMovieRepeatModeOne];
    
    [self.view insertSubview:self.playerController.view atIndex:self.view.subviews.count - 1];
}

- (void)startCircleAnimation {
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.fromValue = @0;
    
    scaleAnimation.toValue   = @1;
    
    scaleAnimation.duration  = 0.5;
    
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
