//
//  YPPassageDistributeListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/28.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPPassageDistributeListCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPPassageDistributeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPPassageDistributeListCell";
    YPPassageDistributeListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPPassageDistributeListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}


- (void)setListModel:(YPGetJSJTableList *)listModel {
    
    _listModel = listModel;
    
    self.nameLabel.text = listModel.Name.length > 0 ? listModel.Name : @"无姓名";
    self.phoneLabel.text = listModel.Phone.length > 0 ? listModel.Phone : @"无手机号";
    self.profession.text = listModel.Identity;
    self.wedDate.text = listModel.WeddingTime.length > 0 ? listModel.WeddingTime : @"无婚期";
    self.shangchuan.text = listModel.Time.length > 0 ? listModel.Time : @"无上传时间";
    self.quyu.text = listModel.Area.length > 0 ? listModel.Area : @"无区域";
    self.zhuoshu.text = [NSString stringWithFormat:@"%zd",listModel.TablesNumber.integerValue];
    self.canbiao.text = [NSString stringWithFormat:@"%@",listModel.MealMark];
}

- (void)setProfession:(UILabel *)profession{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _profession.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGB(101, 200, 195).CGColor,
                       (id)RGB(124, 223, 194).CGColor,nil];
    [_profession.layer addSublayer:gradient];
    
    _profession = profession;
    _profession.layer.cornerRadius = 9;
    _profession.clipsToBounds = YES;
}

- (void)setLookBtn:(UIButton *)lookBtn{
    _lookBtn = lookBtn;
    _lookBtn.layer.cornerRadius = 14;
    _lookBtn.clipsToBounds = YES;
    [_lookBtn setBackgroundImage:[UIImage gradientImageWithBounds:_lookBtn.frame andColors:@[RGB(249, 35, 123),RGB(248, 99, 103)] andGradientType:1] forState:UIControlStateNormal];
    [_lookBtn setBackgroundImage:[UIImage gradientImageWithBounds:_lookBtn.frame andColors:@[RGB(249, 35, 123),RGB(248, 99, 103)] andGradientType:1] forState:UIControlStateHighlighted];
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
