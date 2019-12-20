//
//  YPHYTHNoDataCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHNoDataCell.h"

@implementation YPHYTHNoDataCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHNoDataCell";
    YPHYTHNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHNoDataCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
