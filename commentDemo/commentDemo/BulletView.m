//
//  BulletView.m
//  commentDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BulletView.h"

#define padding       10

@interface BulletView ()
/// 弹幕的Label
@property(nonatomic, strong) UILabel *bulletLabel;
@end

@implementation BulletView

- (instancetype)initWithComment:(NSString *)comment{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
    
        self.bulletLabel.text = comment;
        
        self.bulletLabel.frame = CGRectMake(padding, 0, 0, 30);
        [self.bulletLabel sizeToFit];
        
        self.bounds = CGRectMake(0, 0, padding * 2 + CGRectGetWidth(self.bulletLabel.frame), CGRectGetHeight(self.bulletLabel.frame));
        
    }
    return self;
}

- (void)startAnimation{
    
    CGFloat duration = 4.0;
    CGFloat totalWidth = [UIScreen mainScreen].bounds.size.width + CGRectGetWidth(self.bounds);
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    CGFloat speed = totalWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    [self performSelector:@selector(enter) withObject:nil afterDelay:enterDuration];
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= totalWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

- (void)enter{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

- (void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark --- 懒加载
- (UILabel *)bulletLabel{
    if (!_bulletLabel) {
        _bulletLabel = [[UILabel alloc]init];
        _bulletLabel.font = [UIFont systemFontOfSize:14];
        _bulletLabel.textColor = [UIColor whiteColor];
        _bulletLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bulletLabel];
    }
    return _bulletLabel;
}



@end
