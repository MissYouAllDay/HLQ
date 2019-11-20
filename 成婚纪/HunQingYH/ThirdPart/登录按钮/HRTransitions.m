//
//  HRTransitions.m
//  tongchenghuiMem
//
//  Created by DiKai on 16/8/11.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import "HRTransitions.h"
@interface HRTransitions ()

@property (nonatomic, assign) NSTimeInterval transitionDuration;

@property (nonatomic, assign) CGFloat startingAlpha;

@property (nonatomic, assign) BOOL isPush;

@property (nonatomic, strong) id transitionContext;

@end

@implementation HRTransitions
- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isPush:(BOOL)isPush {
    self = [super init];
    if (self) {
        _transitionDuration = transitionDuration;
        _startingAlpha = startingAlpha;
        _isPush = isPush;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    if (_isPush) {
        toView.alpha = _startingAlpha;
        fromView.alpha = 1.0f;
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha = 1.0f;
            fromView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0f;
            [transitionContext completeTransition:true];
        }];
    } else {
        fromView.alpha = 1.0f;
        toView.alpha = 0;
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [containerView addSubview:toView];
        [UIView animateWithDuration:0.3 animations:^{
            fromView.transform = CGAffineTransformMakeScale(3, 3);
            fromView.alpha = 0.0f;
            toView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0f;
            [transitionContext completeTransition:true];
        }];
    }
}


@end
