//
//  YPHYTHOrderPaySucceedView.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderPaySucceedView.h"

@implementation YPHYTHOrderPaySucceedView

+ (instancetype)yp_orderPaySucceedView{
    YPHYTHOrderPaySucceedView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPHYTHOrderPaySucceedView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setDoneBtn:(UIButton *)doneBtn{
    _doneBtn = doneBtn;
    _doneBtn.layer.cornerRadius = 20;
    _doneBtn.clipsToBounds = YES;
    [_doneBtn setBackgroundImage:[self gradientImageWithBounds:_doneBtn.frame andColors:@[RGBA(249, 35, 123, 1),RGBA(248, 99, 103, 1)] andGradientType:1] forState:UIControlStateNormal];
    [_doneBtn setBackgroundImage:[self gradientImageWithBounds:_doneBtn.frame andColors:@[RGBA(249, 35, 123, 1),RGBA(248, 99, 103, 1)] andGradientType:1] forState:UIControlStateHighlighted];
}

#pragma mark - 渐变色Image
- (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0://纵向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1://横向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default:
            start = CGPointZero;
            end = CGPointZero;
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
