//
//  BulletView.m
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import "BulletView.h"

@interface BulletView()

@property(nonatomic, strong) UILabel * lbComment;

@end

@implementation BulletView
//初始化弹幕
-(instancetype)initWithComment:(NSString *)comment{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        NSDictionary * attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * 10, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(10, 0, width, 30);
    }
    return self;
}
//开始动画
-(void)startAnimation{
    
    //根据弹幕的长度执行动画效果
    //根据 v= s/t  时间一定  弹幕越长 指定的动画效果越快
    CGFloat ScreenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.f;
    CGFloat wholewidth = ScreenWith + CGRectGetWidth(self.bounds);
    
    //弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    //t = s/v
    CGFloat speed = wholewidth /duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    
    //延时方法
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    //取消延时的方法
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholewidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}
-(void)enterScreen{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}
//结束动画
-(void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeFromSuperlayer];
    [self removeFromSuperview];

}

-(UILabel *)lbComment{
    if (!_lbComment) {
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        _lbComment.backgroundColor = [UIColor clearColor];
        _lbComment.font = [UIFont systemFontOfSize:14];
        [self addSubview: _lbComment];
    }
    return _lbComment;
}

@end
