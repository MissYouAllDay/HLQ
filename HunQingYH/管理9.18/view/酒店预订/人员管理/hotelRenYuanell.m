//
//  hotelRenYuanell.m
//  HunQingYH
//
//  Created by xl on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelRenYuanell.h"

@implementation hotelRenYuanell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelRenYuanell";
    hotelRenYuanell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelRenYuanell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageview.clipsToBounds =YES;
    self.iconImageview.layer.cornerRadius =20;
  
}
-(void)setModel:(yuangongModel *)model{
    _model =model;
    self.nameLab.text =model.Name;
    self.phoneLab.text =model.Phone;
    
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
    textAttrs[NSFontAttributeName]=[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    self.iconImageview.image =[self zd_imageWithColor:RGB(146, 146, 146) size:CGSizeMake(40, 40) text:[model.Name substringToIndex:1 ]textAttributes:textAttrs circular:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
-(UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
