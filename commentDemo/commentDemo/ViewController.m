//
//  ViewController.m
//  commentDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"

@interface ViewController ()
///
@property(nonatomic, strong) BulletManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[BulletManager alloc]init];
    __block typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
    };
    
}
- (IBAction)start:(id)sender {
    [self.manager start];
}
- (IBAction)stop:(id)sender {
    [self.manager stop];
}

- (void)addBulletView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    view.frame = CGRectMake(width, 300 + view.trajectory * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
    
}





@end
