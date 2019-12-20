//
//  YPEDuSureOrderAddressCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuSureOrderAddressCell.h"

@implementation YPEDuSureOrderAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEDuSureOrderAddressCell";
    YPEDuSureOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEDuSureOrderAddressCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setInfoModel:(YPGetConsigneeInfoList *)infoModel{
    _infoModel = infoModel;
    
    if (_infoModel.Consignee.length > 0) {
        self.nameLabel.text = _infoModel.Consignee;
    }else{
        self.nameLabel.text = @"无姓名";
    }
    if (_infoModel.ConsigneePhone.length > 0) {
        self.phoneLabel.text = _infoModel.ConsigneePhone;
    }else{
        self.phoneLabel.text = @"无电话";
    }
    if (_infoModel.DetailedAddress.length > 0) {
        self.address.text = _infoModel.DetailedAddress;
    }else{
        self.address.text = @"无地址";
    }
    if (_infoModel.DefaultAddress == 0) {//0，否；1，是
        [self.defaultBtn removeFromSuperview];
    }

}

- (void)setDefaultBtn:(UIButton *)defaultBtn{
    _defaultBtn = defaultBtn;
    
    _defaultBtn.enabled = NO;//只是标识 不能点击
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
