//
//  BulletManager.h
//  commentDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;

@interface BulletManager : NSObject
/// 
@property(nonatomic, copy) void(^generateViewBlock)(BulletView *view);

- (void)start;
- (void)stop;
@end
