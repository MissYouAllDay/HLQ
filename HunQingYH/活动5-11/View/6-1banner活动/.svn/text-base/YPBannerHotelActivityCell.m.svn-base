//
//  YPBannerHotelActivityCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/1.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPBannerHotelActivityCell.h"

@implementation YPBannerHotelActivityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPBannerHotelActivityCell";
    YPBannerHotelActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPBannerHotelActivityCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = ClearColor;
    return cell;
    
}

- (void)setGysModel:(YPGetActivityHotelList *)gysModel{
    _gysModel = gysModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_gysModel.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    if (_gysModel.Name.length > 0){
        self.titleLabel.text = _gysModel.Name;
    }else{
        self.titleLabel.text = @"当前无名称";
    }
    
    self.anliCount.text = _gysModel.AnliCount;
    
    self.zhuangtaiCount.text = _gysModel.StateCount;
    
//    //18-08-10 一直显示-窦
//    self.danbaoImgV.hidden = NO;
//    self.giftImgV.hidden = NO;
    
    //18-10-26 判断显示 - 窦
    if (_gysModel.Xfyl.integerValue == 0) {//0无礼 1有礼
        self.giftImgV.hidden = YES;
    }else if (_gysModel.Xfyl.integerValue == 1) {
        self.giftImgV.hidden = NO;
    }
    if (_gysModel.Hldb.integerValue == 0) {//0无礼 1有礼
        self.danbaoImgV.hidden = YES;
    }else if (_gysModel.Hldb.integerValue == 1) {
        self.danbaoImgV.hidden = NO;
    }
    
    //6-1
    if (_gysModel.Describe.length > 0) {
        self.tagLabel.text = [NSString stringWithFormat:@" %@ ",_gysModel.Describe];
        self.tagImgV.hidden = NO;
    }else{
        self.tagLabel.text = @"";
        self.tagImgV.hidden = YES;
    }
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.backgroundColor = WhiteColor;
    _backView.layer.cornerRadius = 5;
    _backView.clipsToBounds = YES;
}

//- (void)setTagBtn:(UIButton *)tagBtn{
//    _tagBtn = tagBtn;
//    
//    _tagBtn.enabled = NO;
//    _tagBtn.layer.cornerRadius = 3;
//    _tagBtn.clipsToBounds = YES;
//    [_tagBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [_tagBtn setBackgroundImage:[UIImage imageNamed:@"渐变背景"] forState:UIControlStateNormal];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
