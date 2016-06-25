//
//  xuanfuwu.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/24.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

//主题颜色

#import "AppDelegate.h"
#import "xuanfuwu.h"




#define MAINCOLOER [UIColor colorWithRed:105/255.0 green:149/255.0 blue:246/255.0 alpha:1]


#define kDownLoadWidth 60

#define kOffSet kDownLoadWidth / 2


@interface xuanfuwu ()<UIDynamicAnimatorDelegate>

@property (nonatomic , retain ) UIView *backgroundView;//背景视图

@property (nonatomic , retain ) UIImageView *imageView;//图片视图

@property (nonatomic , retain ) UIDynamicAnimator *animator;//物理仿真动画
@end

@implementation xuanfuwu

//初始化

- (instancetype)initWithFrame:(CGRect)frame{
    
    // 设置 xuanfuwu 这个视图的大小 宽高都是60
    frame.size.width = kDownLoadWidth;
    
    frame.size.height = kDownLoadWidth;
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        //初始化背景视图
        
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        // 让初始化背景变成圆
        _backgroundView.layer.cornerRadius = _backgroundView.frame.size.width / 2;
        
        //        clipsToBounds
        //        是指视图上的子视图,如果超出父视图的部分就截取掉,
        //        masksToBounds
        //        却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
        _backgroundView.clipsToBounds = YES;
        
        // 设置颜色和透明度
        _backgroundView.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.7];
        
        _backgroundView.userInteractionEnabled = NO;
        
        [self addSubview:_backgroundView];
        
        //初始化图片背景视图
        // 比背景视图稍微小一点，显示出呼吸的效果
        
        UIView * imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
        // 变圆
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
        
        imageBackgroundView.clipsToBounds = YES;
        
        imageBackgroundView.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.8f];
        
        imageBackgroundView.userInteractionEnabled = NO;
        
        [self addSubview:imageBackgroundView];
        
        
        
        //初始化图片
        
//        _imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"TabbarIconMoney.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        UIImage *image = [[UIImage imageNamed:@"TabbarIconMoney.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageView = [[UIImageView alloc] initWithImage:image];
        
        
        // UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        // UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
        // UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
        
        
//        _imageView.tintColor = [UIColor whiteColor];
        _imageView.tintColor = [UIColor yellowColor];

        
        _imageView.frame = CGRectMake(0, 0, 30, 30);
        
        _imageView.center = CGPointMake(kDownLoadWidth / 2 , kDownLoadWidth / 2);
        
        [self addSubview:_imageView];
        
        
        
        //将正方形的view变成圆形
        
        self.layer.cornerRadius = kDownLoadWidth / 2;
        
        
        //开启呼吸动画
        
        [self HighlightAnimation];
        
    }
    
    return self;
    
}


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

//结束触摸

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸结束点
    
    UITouch *endTouch = [touches anyObject];
    
    //返回触摸结束点
    // 这个方法是指：触摸的点时在哪个视图，xuanfuwu 是加在viewController上的，所以用superView
    self.endPoint = [endTouch locationInView:self.superview];
    
    //判断是否移动了视图 (误差范围5)
    
    CGFloat errorRange = 5;
    
    if (( self.endPoint.x - self.startPoint.x >= -errorRange && self.endPoint.x - self.startPoint.x <= errorRange ) && ( self.endPoint.y - self.startPoint.y >= -errorRange && self.endPoint.y - self.startPoint.y <= errorRange )) {
        // 如果移动范围不超过 5 ，就不进行物理事件的响应
        
        
        
    } else {
        
        //移动
        
        self.center = self.endPoint;
        
        //计算距离最近的边缘 吸附到边缘停靠
        
        CGFloat superwidth = self.superview.bounds.size.width;
        
        CGFloat superheight = self.superview.bounds.size.height;
        
        CGFloat endX = self.endPoint.x;
        
        CGFloat endY = self.endPoint.y;
        
        CGFloat topRange = endY;//上距离
        
        CGFloat bottomRange = superheight - endY;//下距离
        
        CGFloat leftRange = endX;//左距离
        
        CGFloat rightRange = superwidth - endX;//右距离
        
        
        //比较上下左右距离 取出最小值
        
        CGFloat minRangeTB = topRange > bottomRange ? bottomRange : topRange;//获取上下最小距离
        
        CGFloat minRangeLR = leftRange > rightRange ? rightRange : leftRange;//获取左右最小距离
        
        CGFloat minRange = minRangeTB > minRangeLR ? minRangeLR : minRangeTB;//获取最小距离
        
        
        //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
        
        CGPoint minPoint;
        
        if (minRange == topRange) {
            
            //上
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , 0 + kOffSet);
            
        } else if(minRange == bottomRange){
            
            //下
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , superheight - kOffSet);
            
        } else if(minRange == leftRange){
            
            //左
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(0 + kOffSet , endY);
            
        } else if(minRange == rightRange){
            
            //右
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(superwidth - kOffSet , endY);
            
        }
        
        
        //添加吸附物理行为
        
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        
        // 吸附行为中的两个吸附点之间的距离，通常用这个属性来调整吸附的长度，可以创建吸附行为之后调用。系统基于你创建吸附行为的方法来自动初始化这个长度
        [attachmentBehavior setLength:0];
        
        // 阻尼，相当于回弹过程中额阻力效果
        [attachmentBehavior setDamping:0.1];
        
        // 回弹的频率
        [attachmentBehavior setFrequency:3];
        
        [self.animator addBehavior:attachmentBehavior];
        
        
    }
    
    
}

#pragma mark ---UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    NSLog(@"动画即将开始");
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    NSLog(@"动画已经停止了");

}



#pragma mark ---LazyLoading

- (UIDynamicAnimator *)animator
{
    
    if (!_animator) {
        
        // 创建物理仿真器(ReferenceView : 仿真范围)
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        
        //设置代理
        
        _animator.delegate = self;
        
    }
    
    return _animator;
    
}



#pragma mark ---BreathingAnimation 呼吸动画

// 实质就是一个循环动画，透明度来回改变
- (void)HighlightAnimation{
    
    // 修改block块里面的值
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.1f];
        
    } completion:^(BOOL finished) {
        
        [Self DarkAnimation];
        
    }];
    
}

- (void)DarkAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.6f];
        
    } completion:^(BOOL finished) {
        
        [Self HighlightAnimation];
        
    }];
    
}

@end
