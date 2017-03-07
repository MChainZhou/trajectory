//
//  BulletManager.m
//  commentDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()
///
@property(nonatomic, strong) NSMutableArray *bulletComments;
///
@property(nonatomic, strong) NSMutableArray *dataSource;
///
@property(nonatomic, strong) NSMutableArray *bulletViews;

/// 是否暂停
@property (nonatomic,assign) BOOL isStopAnimation;
@end

@implementation BulletManager

- (instancetype)init{
    if (self = [super init]) {
        self.isStopAnimation = YES;
    }
    return self;
}
- (void)start{
    if (!self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    
    [self initBulletComment];
    
    
}

- (void)stop{
    if (self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
    }];
    [self.bulletViews removeAllObjects];
}


- (void)initBulletComment{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];

    
    for (int i = 0; i < 3; i ++) {
        if (self.bulletComments.count > 0) {
            //随机获取弹道的轨迹
            NSInteger index = random()%trajectorys.count;
            int trajectory = [trajectorys[index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            //取出弹幕
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            [self creatBulletView:comment trajectory:trajectory];
        }
    }
}
- (void)creatBulletView:(NSString *)comment trajectory:(int)trajectory{
    if (self.isStopAnimation) {
        return;
    }
    BulletView *view = [[BulletView alloc]initWithComment:comment];
    view.trajectory = trajectory;
    
    
    __block typeof (view) weakView = view;
    view.moveStatusBlock = ^(moveStauts status){
        if (self.isStopAnimation) {
            return ;
        }
        switch (status) {
            case Start:{
                // 弹幕开始进入屏幕,将view加入弹幕管理的bulletViews
                [self.bulletViews addObject:weakView];
                break;
            }
            case Enter:{
                // 弹幕完全进入屏幕时，判断是否还有其他的弹幕，有就追加到弹幕后谜案
                if (self.bulletComments.count > 0) {
                    NSString *lastComment = [self nextComment];
                    [self creatBulletView:lastComment trajectory:trajectory];
                }
                break;
            }
            case End:{
                // 弹幕移出屏幕时，结束动画，并且判断是否还有弹幕
                if ([self.bulletViews containsObject:weakView]) {
                    [self.bulletViews removeObject:weakView];
                    [weakView stopAnimation];
                }
                if (self.bulletViews.count == 0) {
                    self.isStopAnimation = YES;
                    [self start];
                }
                break;
            }
            default:
                break;
        }
        
    };
    
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}

- (NSString *)nextComment{
    if (self.bulletComments.count == 0) {
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}


#pragma mark --- 懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~~~~",
                             @"弹幕2~~~~",
                             @"弹幕3~~~~~~~~~~~~~~",
                             @"弹幕4~~~~~~~~",
                             @"弹幕5~~~~",
                             @"弹幕6~~~~~~~~~~~~~~",
                             @"弹幕7~~~~~~~~",
                             @"弹幕8~~~~",
                             @"弹幕9~~~~~~~~~~~~~~"]];
    }
    return _dataSource;
}

- (NSMutableArray *)bulletComments{
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

- (NSMutableArray *)bulletViews{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}
@end
