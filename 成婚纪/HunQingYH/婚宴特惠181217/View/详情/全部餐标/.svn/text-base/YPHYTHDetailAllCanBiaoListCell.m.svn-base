//
//  YPHYTHDetailAllCanBiaoListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailAllCanBiaoListCell.h"

@implementation YPHYTHDetailAllCanBiaoListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailAllCanBiaoListCell";
    YPHYTHDetailAllCanBiaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailAllCanBiaoListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
}

- (void)setYudingBtn:(UIButton *)yudingBtn{
    _yudingBtn = yudingBtn;
    _yudingBtn.layer.cornerRadius = 12;
    _yudingBtn.clipsToBounds = YES;
    [_yudingBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [_yudingBtn setTitleColor:WhiteColor forState:UIControlStateHighlighted];
    [_yudingBtn setBackgroundImage:[self gradientImageWithBounds:_yudingBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_yudingBtn setBackgroundImage:[self gradientImageWithBounds:_yudingBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
}

//- (void)setDingImgV:(UIImageView *)dingImgV{
//    _dingImgV = dingImgV;
//    _dingImgV.layer.cornerRadius = 4;
//    _dingImgV.clipsToBounds = YES;
//    _dingImgV.image = [self gradientImageWithBounds:CGRectMake(0, 0, _dingImgV.frame.size.width, _dingImgV.frame.size.height) andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1];
//}

///渐变色Image
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
