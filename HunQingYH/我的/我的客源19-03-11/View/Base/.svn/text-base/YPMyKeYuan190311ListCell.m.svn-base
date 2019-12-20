//
//  YPMyKeYuan190311ListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190311ListCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPMyKeYuan190311ListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190311ListCell";
    YPMyKeYuan190311ListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190311ListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setGuanfang:(UIButton *)guanfang{
    _guanfang = guanfang;
    _guanfang.enabled = NO;
    _guanfang.layer.cornerRadius = 2;
    _guanfang.clipsToBounds = YES;
    [_guanfang setBackgroundImage:[UIImage gradientImageWithBounds:_guanfang.frame andColors:@[[UIColor colorWithRed:243/255.0 green:200/255.0 blue:20/255.0 alpha:1.0], [UIColor colorWithRed:251/255.0 green:157/255.0 blue:47/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_guanfang setBackgroundImage:[UIImage gradientImageWithBounds:_guanfang.frame andColors:@[[UIColor colorWithRed:243/255.0 green:200/255.0 blue:20/255.0 alpha:1.0], [UIColor colorWithRed:251/255.0 green:157/255.0 blue:47/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
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
