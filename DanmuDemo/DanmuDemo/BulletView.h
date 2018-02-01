//
//  BulletView.h
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MoveStaus) {
    Start,
    Enter,
    End
};

@interface BulletView : UIView

@property (nonatomic, assign) int trajectory;//弹道

@property (nonatomic, copy) void (^moveStatusBlock)(MoveStaus status);//弹幕状态回调
//初始化弹幕
-(instancetype)initWithComment:(NSString *)comment;
//开始动画
-(void)startAnimation;
//结束动画
-(void)stopAnimation;
@end
