//
//  HRSpinerLayer.m
//  tongchenghuiMem
//
//  Created by DiKai on 16/8/11.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import "HRSpinerLayer.h"
#import <UIKit/UIKit.h>
@implementation HRSpinerLayer
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        CGFloat radius = CGRectGetHeight(frame) / 4;
        self.frame = CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        CGPoint center = CGPointMake(CGRectGetHeight(frame) / 2, CGRectGetMidY(self.bounds));
        CGFloat startAngle = 0 - M_PI_2;
        CGFloat endAngle = M_PI * 2 - M_PI_2;
        BOOL clockwise = true;
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise].CGPath;
        self.fillColor = nil;
//        self.strokeColor = WhiteColor.CGColor;//旋转圆圈颜色
        self.strokeColor = NavBarColor.CGColor;//旋转圆圈颜色 登录改版
        self.lineWidth = 1;
        
        self.strokeEnd = 0.4;
        self.hidden = true;
    }
    return self;
}

-(void)beginAnimation {
    self.hidden = false;
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = 0;
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 0.4;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotate.repeatCount = HUGE;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = false;
    [self addAnimation:rotate forKey:rotate.keyPath];
}

-(void)stopAnimation {
    self.hidden = true;
    [self removeAllAnimations];
}


@end
