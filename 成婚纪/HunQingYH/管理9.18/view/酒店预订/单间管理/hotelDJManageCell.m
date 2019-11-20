//
//  hotelDJManageCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/24.
//  Copyright © 2019 xl. All rights reserved.
//

#import "hotelDJManageCell.h"

@implementation hotelDJManageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelDJManageCell";
    hotelDJManageCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelDJManageCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(danjianModel *)model{
    _model =model;
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
    textAttrs[NSFontAttributeName]=[UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    self.iconimageview.image =[self zd_imageWithColor:RGB(146, 146, 146) size:CGSizeMake(50, 50) text:[model.BanquetName substringToIndex:1 ]textAttributes:textAttrs circular:NO];
    self.nameLab.text =model.BanquetName;
    self.numberLab.text =[NSString stringWithFormat:@"最多容纳%@人",model.MaxTableNumber];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconimageview.clipsToBounds =YES;
    self.iconimageview.layer.cornerRadius =5;
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
