//
//  TopView.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/24.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "TopView.h"

@interface TopView () <UIDynamicAnimatorDelegate>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
    }
    return self;
}



#pragma mark - UIResponse

// 触摸事件的触摸点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //返回触摸点坐标
    
    self.startPoint = [startTouch locationInView:self.superview];
    
    // 移除之前的所有行为
    // 如果不移除，之前移动所触发的物理吸附事件就会一直执行
    [self.animator removeAllBehaviors];
}

//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    // 这里只有一个手指，移动的坐标只有一个
    UITouch *startTouch = [touches anyObject];
    
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    
    self.center = [startTouch locationInView:self.superview];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //添加吸附物理行为
    CGPoint minPoint = CGPointMake(0, 400);
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
    
    // 吸附行为中的两个吸附点之间的距离，通常用这个属性来调整吸附的长度，可以创建吸附行为之后调用。系统基于你创建吸附行为的方法来自动初始化这个长度
    [attachmentBehavior setLength:0];
    
    // 阻尼，相当于回弹过程中额阻力效果
    [attachmentBehavior setDamping:0.1];
    
    // 回弹的频率
    [attachmentBehavior setFrequency:3];
    
    [self.animator addBehavior:attachmentBehavior];
    
}




#pragma mark - UIDynamicAnimatorDelegate


- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    NSLog(@"动画即将开始");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    NSLog(@"动画已经停止了");
}

#pragma mark - Custom


- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        _animator.delegate = self;

    }
    return _animator;
}


@end
