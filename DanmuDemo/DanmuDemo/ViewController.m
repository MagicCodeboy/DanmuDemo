//
//  ViewController.m
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"
@interface ViewController ()

@property (nonatomic, strong) BulletManager * manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[BulletManager alloc]init];
    __weak typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view) {
        [weakSelf addBulletView:view];
    };
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.manager start];
}
-(void)addBulletView:(BulletView *)bview {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    bview.frame = CGRectMake(width, 300 + bview.trajectory * 40, CGRectGetWidth(bview.bounds), CGRectGetHeight(bview.bounds));
    [self.view addSubview:bview];
    
    [bview startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
