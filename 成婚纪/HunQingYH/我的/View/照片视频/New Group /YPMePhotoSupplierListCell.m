//
//  YPMePhotoSupplierListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMePhotoSupplierListCell.h"

@implementation YPMePhotoSupplierListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMePhotoSupplierListCell";
    YPMePhotoSupplierListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMePhotoSupplierListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setInfoModel:(YPGetCustomerInfoBySupplier *)infoModel{
    _infoModel = infoModel;
    
    if (_infoModel.GroomName.length > 0) {
        self.manName.text = _infoModel.GroomName;
    }else{
        self.manName.text = @"无姓名";
    }
    if (_infoModel.GroomPhoneNo.length > 0) {
        self.manPhone.text = _infoModel.GroomPhoneNo;
    }else{
        self.manPhone.text = @"无手机号";
    }
    if (_infoModel.BrideName.length > 0) {
        self.womanName.text = _infoModel.BrideName;
    }else{
        self.womanName.text = @"无姓名";
    }
    if (_infoModel.BridePhoneNo.length > 0) {
        self.womanPhone.text = _infoModel.BridePhoneNo;
    }else{
        self.womanPhone.text = @"无手机号";
    }
}

- (void)setManView:(UIView *)manView{
    _manView = manView;
    
    _manView.layer.cornerRadius = 3.5;
    _manView.clipsToBounds = YES;
}

- (void)setWomanView:(UIView *)womanView{
    _womanView = womanView;
    
    _womanView.layer.cornerRadius = 3.5;
    _womanView.clipsToBounds = YES;
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
