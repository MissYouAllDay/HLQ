//
//  YPArrangeNewAddListCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeNewAddListCell.h"

@implementation YPArrangeNewAddListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPArrangeNewAddListCell";
    YPArrangeNewAddListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPArrangeNewAddListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setOrder:(YPGetSupplierrOrderList *)order{
    _order = order;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_order.CorpLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if (_order.CorpName.length > 0) {
        self.titleLabel.text = _order.CorpName;
    }else{
        self.titleLabel.text = @"无";
    }
    if (_order.CorpPhone.length > 0) {
        self.nameLabel.text = _order.CorpPhone;
    }else{
        self.nameLabel.text = @"无";
    }
    self.phone.hidden = YES;
    if (_order.CorpRummeryName.length > 0) {
        self.hotel.text = _order.CorpRummeryName;
    }else{
        self.hotel.text = @"无";
    }
    if (_order.CorpRummeryAddress.length > 0) {
        self.address.text = _order.CorpRummeryAddress;
    }else{
        self.address.text = @"无";
    }
    
    NSArray *timeArr = [_order.WeddingDate componentsSeparatedByString:@" "];
    if (timeArr.count > 0) {
        self.yearLabel.text = timeArr[0];
    }else{
        self.yearLabel.text = @"无";
    }
    
    //设置按钮颜色
    if ([_order.AnswerStatus integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
        [self.accept setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.accept.layer.borderColor = [UIColor redColor].CGColor;
    }else if ([_order.AnswerStatus integerValue] == 1){
        [self.accept setTitleColor:RGB(45, 175, 57) forState:UIControlStateNormal];
        self.accept.layer.borderColor = RGB(45, 175, 57).CGColor;
    }else if ([_order.AnswerStatus integerValue] == 2){
        [self.accept setTitleColor:GrayColor forState:UIControlStateNormal];
        self.accept.layer.borderColor = GrayColor.CGColor;
    }
}

- (void)setDriverModel:(YPGetDriverTimetableListByDriverID *)driverModel{
    _driverModel = driverModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_driverModel.CaptainImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if (_driverModel.CaptainName.length > 0) {
        self.titleLabel.text = _driverModel.CaptainName;
    }else{
        self.titleLabel.text = @"无";
    }
    if (_driverModel.CaptainPhone.length > 0) {//显示队长手机号
        self.nameLabel.text = _driverModel.CaptainPhone;
    }else{
        self.nameLabel.text = @"无";
    }
    self.phone.hidden = YES;//车手时 隐藏
    if (_driverModel.RummeryName.length > 0) {//显示队长手机号
        self.hotel.text = _driverModel.RummeryName;
    }else{
        self.hotel.text = @"无";
    }
    if (_driverModel.RummeryAddress.length > 0) {//显示队长手机号
        self.address.text = _driverModel.RummeryAddress;
    }else{
        self.address.text = @"无";
    }
    
    NSArray *timeArr = [_driverModel.WeddingDate componentsSeparatedByString:@" "];
    if (timeArr.count > 0) {
        self.yearLabel.text = timeArr[0];
    }else{
        self.yearLabel.text = @"无";
    }

    //设置按钮颜色
    if ([_driverModel.StatuType integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
        [self.accept setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.accept.layer.borderColor = [UIColor redColor].CGColor;
    }else if ([_driverModel.StatuType integerValue] == 1){
        [self.accept setTitleColor:RGB(45, 175, 57) forState:UIControlStateNormal];
        self.accept.layer.borderColor = RGB(45, 175, 57).CGColor;
    }else if ([_driverModel.StatuType integerValue] == 2){
        [self.accept setTitleColor:GrayColor forState:UIControlStateNormal];
        self.accept.layer.borderColor = GrayColor.CGColor;
    }
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
}

- (void)setAccept:(UIButton *)accept{
    _accept = accept;
    _accept.layer.cornerRadius = 2;
    _accept.clipsToBounds = YES;
//    _accept.layer.borderColor = [UIColor redColor].CGColor;
    _accept.layer.borderWidth = 1;
}

- (void)setRefuse:(UIButton *)refuse{
    _refuse = refuse;
    _refuse.layer.cornerRadius = 2;
    _refuse.clipsToBounds = YES;
    _refuse.layer.borderColor = LightGrayColor.CGColor;
    _refuse.layer.borderWidth = 1;
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
