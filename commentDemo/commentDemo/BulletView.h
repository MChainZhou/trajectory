//
//  BulletView.h
//  commentDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,moveStauts){
    Start,
    Enter,
    End
};

@interface BulletView : UIView
/// 弹道
@property (nonatomic,assign) int trajectory;
/// 弹幕的状态
@property(nonatomic, copy) void(^moveStatusBlock)(moveStauts status);

/// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;

- (void)startAnimation;
- (void)stopAnimation;
@end
