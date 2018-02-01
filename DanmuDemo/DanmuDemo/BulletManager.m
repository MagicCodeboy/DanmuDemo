//
//  BulletManager.m
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
@interface BulletManager()

//弹幕的数据来源
@property(nonatomic, strong) NSMutableArray * dataSource;

//弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray * bulletCommetns;

//存储弹幕View的数组变量
@property(nonatomic, strong) NSMutableArray * bulletViews;

@property (nonatomic, assign) BOOL stopAnimationStaus;
@end


@implementation BulletManager
-(instancetype)init{
    if (self = [super init]) {
        self.stopAnimationStaus = YES;
    }
    return self;
}
-(void)start{
    if (!self.stopAnimationStaus) {
        return;
    }
    self.stopAnimationStaus = NO;
    [self.bulletCommetns removeAllObjects];
    [self.bulletCommetns addObjectsFromArray:self.dataSource];
    
    [self initBulletComment];
}
-(void)stop{
    if (self.stopAnimationStaus) {
        return;
    }
    self.stopAnimationStaus = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView * view = obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}
//初始化弹幕  随机分配弹幕轨迹
-(void)initBulletComment{
    NSMutableArray * trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i = 0; i < 3; i++) {
        if (self.bulletCommetns.count > 0) {
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            //从弹幕数组中逐一取出弹幕数据
            NSString * comment = [self.bulletCommetns firstObject];
            [self.bulletCommetns removeObjectAtIndex:0];
            //创建弹幕view
            [self createBulletView:comment trajectory:trajectory];
        }
    }
}
-(void)createBulletView:(NSString *)comment trajectory:(int)trajectory {
    if (self.stopAnimationStaus) {
        return;
    }
    BulletView * view = [[BulletView alloc] initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakSelf = self;
    view.moveStatusBlock = ^(MoveStaus status){
        if (self.stopAnimationStaus) {
            return ;
        }
        switch (status) {
            case Start: {
                //弹幕开始进入屏幕 将view加入到大幕管理的数组中
                [weakSelf.bulletViews addObject:weakView];
                break;
            }
            case Enter: {
                //弹幕完全进入屏幕  判断是否还有其他内容 如果有则在该弹幕轨迹中创建一个弹幕
                NSString *comment = [weakSelf nextComment];
                if (comment) {
                    [weakSelf createBulletView:comment trajectory:trajectory];
                }
                break;
            }
            case End: {
                //弹幕废飞出屏幕 从_bulletViews中删除 释放资源
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                if (weakSelf.bulletViews.count == 0) {
                    //说明屏幕上已经没有弹幕了，开始循环滚动
                    self.stopAnimationStaus = YES;
                    [weakSelf start];
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
-(NSString *)nextComment{
    if (self.bulletCommetns.count == 0) {
        return nil;
    }
    NSString * comment = [self.bulletCommetns firstObject];
    if (comment) {
        [self.bulletCommetns removeObjectAtIndex:0];
    }
    return comment;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"我是弹幕1~~~~~~",
                                                    @"我是弹幕2~~~~~~我是弹幕2~~~~~~",
                                                    @"我是弹幕3~",
                                                    @"我是弹幕4~~~~~~",
                                                    @"我是弹幕5~~~~~~我是弹幕2~~~~~~",
                                                    @"我是弹幕6~",
                                                    @"我是弹幕7~~~~~~",
                                                    @"我是弹幕8~~~~~~我是弹幕2~~~~~~",
                                                    @"我是弹幕9~"]];
    }
    return _dataSource;
}
-(NSMutableArray *)bulletCommetns{
    if(!_bulletCommetns){
        _bulletCommetns = [NSMutableArray array];
    }
    return _bulletCommetns;
}
-(NSMutableArray *)bulletViews{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}
@end
