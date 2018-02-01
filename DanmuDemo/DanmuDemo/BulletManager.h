//
//  BulletManager.h
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;
@interface BulletManager : NSObject

@property (nonatomic, copy) void(^generateViewBlock)(BulletView * view);

-(void)start;//弹幕开始执行

-(void)stop;//弹幕停止执行

@end
