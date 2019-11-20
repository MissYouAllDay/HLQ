//
//  YPReHomeYouHuiCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeYouHuiCell.h"

@implementation YPReHomeYouHuiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeYouHuiCell";
    YPReHomeYouHuiCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeYouHuiCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBtn1:(UIButton *)btn1{
    _btn1 = btn1;
    
    _btn1.layer.cornerRadius = 5;
    _btn1.clipsToBounds = YES;
}

- (void)setBtn2:(UIButton *)btn2{
    _btn2 = btn2;
    
    _btn2.layer.cornerRadius = 5;
    _btn2.clipsToBounds = YES;
}

- (void)setBtn3:(UIButton *)btn3{
    _btn3 = btn3;
    
    _btn3.layer.cornerRadius = 5;
    _btn3.clipsToBounds = YES;
}

- (void)setBtn4:(UIButton *)btn4{
    _btn4 = btn4;
    
    _btn4.layer.cornerRadius = 5;
    _btn4.clipsToBounds = YES;
}

- (void)setImgV1:(UIImageView *)imgV1{
    _imgV1 = imgV1;
    
    _imgV1.layer.cornerRadius = 5;
    _imgV1.clipsToBounds = YES;
}

- (void)setImgV2:(UIImageView *)imgV2{
    _imgV2 = imgV2;
    
    _imgV2.layer.cornerRadius = 5;
    _imgV2.clipsToBounds = YES;
}

- (void)setImgV3:(UIImageView *)imgV3{
    _imgV3 = imgV3;
    
    _imgV3.layer.cornerRadius = 5;
    _imgV3.clipsToBounds = YES;
}

- (void)setImgV4:(UIImageView *)imgV4{
    _imgV4 = imgV4;
    
    _imgV4.layer.cornerRadius = 5;
    _imgV4.clipsToBounds = YES;
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
