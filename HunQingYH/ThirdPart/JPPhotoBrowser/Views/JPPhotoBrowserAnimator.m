//
//  JPPhotoBrowserAnimator.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "JPPhotoBrowserAnimator.h"

@interface JPPhotoBrowserAnimator ()

/** 是否是Presendt */
@property(nonatomic,assign) BOOL isPresent;

@end

@implementation JPPhotoBrowserAnimator

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

//- (void)setAnimationImageView:(UIImageView *)animationImageView {
//    
//    _animationImageView = animationImageView;
//    
//    self.currentImageView = animationImageView;
//}

//返回真正的Present动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isPresent = YES;
    
    return self;
}

//返回真正的Dismiss动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.isPresent = NO;
    
    return self;
}


//UIViewControllerAnimatedTransitioning 交互代理
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

//一旦重写 所有代理动画都需要程序员自己定义
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    if(self.isPresent) {
        [self p_PresentTransition:transitionContext];
    }else {
        [self p_DismissTransition:transitionContext];
    }
}

/** presentTransition */
- (void)p_PresentTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //将要显示的控制器的View
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //系统提供的容器视图
    UIView *containerView = [transitionContext containerView];
    
    //用于动画的临时View
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = self.animationImageView.image;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds = YES;
    
    //获取imageView在window的frame
    imageV.frame = [containerView convertRect:self.animationImageView.frame fromView:self.animationImageView.superview];
    
    //添加到容器视图
    [containerView addSubview:imageV];
    
    //目标图片的frame
    CGRect toRect = [self p_ReturnImageSizeWithImage:self.currentImageView.image];
    
    //将目标视图添加到容器视图
    [containerView addSubview:toView];
    
    //动画
    toView.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        imageV.frame = toRect;
        
    } completion:^(BOOL finished) {
        //删除临时的动画View
        [imageV removeFromSuperview];
        //显示目标view
        toView.alpha = 1.0;
        //告诉上下文转转场动画结束  结束之前 默认没有交互
        [transitionContext completeTransition:YES];
    }];
}

/** dismissTransition */
- (void)p_DismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //将要显示的控制器的View
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //系统提供的容器视图
    UIView *containerView = [transitionContext containerView];
    
    //用于动画的临时View
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = self.currentImageView.image;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds = YES;
    
    //获取imageView在window的frame
    imageV.frame = [self p_ReturnImageSizeWithImage:self.currentImageView.image];
    
    //添加到容器视图
    [containerView addSubview:imageV];
    
    //目标图片的frame
    CGRect toRect = [containerView convertRect:self.animationImageView.frame fromView:self.animationImageView.superview];
    
    //将目标视图添加到容器视图
    [containerView addSubview:fromView];
    
    //动画
    fromView.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        imageV.frame = toRect;
        
    } completion:^(BOOL finished) {
        //删除临时的动画View
        [imageV removeFromSuperview];
        //删除显示的view
        [fromView removeFromSuperview];
        //告诉上下文转转场动画结束  结束之前 默认没有交互
        [transitionContext completeTransition:YES];
    }];

}


/** 设置图片大小 */
- (CGRect)p_ReturnImageSizeWithImage:(UIImage *)image {
    
    //屏幕尺寸
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //原图尺寸
    CGSize imageSize = image.size;
    //需要设置的尺寸
    CGSize size = CGSizeZero;
    size.width = screenSize.width;
    size.height = size.width *imageSize.height / imageSize.width;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //短图居中
    if (size.height < screenSize.height) {
        rect.origin.y = (screenSize.height - size.height)*0.5;
    }
    
    return rect;
}

@end
