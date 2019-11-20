//
//  YPHome190416QueryHotelCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/4/16.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190416QueryHotelCell.h"
#import "NSAttributedString+YYText.h"
#import "UIImage+YPGradientImage.h"

@implementation YPHome190416QueryHotelCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome190416QueryHotelCell";
    YPHome190416QueryHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome190416QueryHotelCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.shadowColor = RGBS(230).CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(-1,1);//shadowOffset阴影偏移,x向右偏移，y向下偏移，默认(0, -3),这个跟shadowRadius配合使用
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
}

- (void)setLookBtn:(UIButton *)lookBtn{
    _lookBtn = lookBtn;
    _lookBtn.layer.cornerRadius = 20;
    _lookBtn.clipsToBounds = YES;
    [_lookBtn setBackgroundImage:[UIImage gradientImageWithBounds:_lookBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_lookBtn setBackgroundImage:[UIImage gradientImageWithBounds:_lookBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
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
