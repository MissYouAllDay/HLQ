//
//  HRLoginButton.m
//  tongchenghuiMem
//
//  Created by DiKai on 16/8/11.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import "HRLoginButton.h"
#import "HRSpinerLayer.h"
@interface HRLoginButton ()

@property (nonatomic, assign) CFTimeInterval shrinkDuration;

@property (nonatomic, strong) CAMediaTimingFunction *shrinkCurve;

@property (nonatomic, strong) CAMediaTimingFunction *expandCurve;

@property (nonatomic, strong) HRAnimationCompletion animationCompletion;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) HRSpinerLayer *spinerLayer;

@end

@implementation HRLoginButton

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _spinerLayer = [[HRSpinerLayer alloc] initWithFrame:self.frame];
        _shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
        self.shrinkDuration = 0.1;
        [self.layer addSublayer:_spinerLayer];
        [self setup];
    }
    return self;
}

-(void)setup {
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.clipsToBounds = true;
    [self addTarget:self action:@selector(scaleToSmall)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall {
    typeof(self) __weak weak = self;
    
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(0.9, 0.9);
                     } completion:nil];
}

- (void)scaleAnimation {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
    [self beginAnimation];
}

- (void)scaleToDefault {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.4f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
}

- (void)beginAnimation {
    [self performSelector:@selector(revert) withObject:nil afterDelay:0.f];
    [self.layer addSublayer:_spinerLayer];
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.toValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.duration = _shrinkDuration;
    shrinkAnim.timingFunction = _shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [_spinerLayer beginAnimation];
    [self setUserInteractionEnabled:false];
}

- (void)failedAnimationWithCompletion:(HRAnimationCompletion)completion {
    _animationCompletion = completion;
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.toValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.duration = _shrinkDuration;
    shrinkAnim.timingFunction = _shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    _color = self.backgroundColor;
    
    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    backgroundColor.toValue  = (__bridge id)MainColor.CGColor;//登录改版 隐藏
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = _shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    keyFrame.delegate = self;
    self.layer.position = point;
    
    [self.layer addAnimation:backgroundColor forKey:backgroundColor.keyPath];
    [self.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [_spinerLayer stopAnimation];
    [self setUserInteractionEnabled:true];
}

- (void)succeedAnimationWithCompletion:(HRAnimationCompletion)completion {
    _animationCompletion = completion;
    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnim.fromValue = @(1.0);
    expandAnim.toValue = @(33.0);
    expandAnim.timingFunction = _expandCurve;
    expandAnim.duration = 0.3;
    expandAnim.delegate = self;
    expandAnim.fillMode = kCAFillModeForwards;
    expandAnim.removedOnCompletion = false;
    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
    [_spinerLayer stopAnimation];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation *cab = (CABasicAnimation *)anim;
    if ([cab.keyPath isEqualToString:@"transform.scale"]) {
        [self setUserInteractionEnabled:true];
        if (_animationCompletion) {
            _animationCompletion();
        }
        
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(didStopAnimation) userInfo:nil repeats:NO];
        
    }
}

-(void)revert {
    
    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    backgroundColor.toValue  = (__bridge id)MainColor.CGColor;
    backgroundColor.toValue  = (__bridge id)WhiteColor.CGColor;//登录改版
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = _shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    [self.layer addAnimation:backgroundColor forKey:@"backgroundColors"];
    
    
}

- (void)didStopAnimation {
    
    [self.layer removeAllAnimations];
}


@end
