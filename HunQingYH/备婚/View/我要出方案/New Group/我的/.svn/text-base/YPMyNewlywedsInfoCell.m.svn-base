//
//  YPMyNewlywedsInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyNewlywedsInfoCell.h"

@implementation YPMyNewlywedsInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyNewlywedsInfoCell";
    YPMyNewlywedsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyNewlywedsInfoCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setInfo:(YPGetNewPeopleInfo *)info{
    _info = info;
    
    if (_info.Name.length > 0) {
        self.nameLabel.text = _info.Name;
    }else{
        self.nameLabel.text = @"无";
    }
    
    if (_info.Constellation.length > 0) {
        self.xingzuo.text = _info.Constellation;
    }else{
        self.xingzuo.text = @"无";
    }
    if (_info.PlaceOfOrigin.length > 0) {
        self.jiguan.text = _info.PlaceOfOrigin;
    }else{
        self.jiguan.text = @"无";
    }
    if (_info.Occupation.length > 0) {
        self.zhiye.text = _info.Occupation;
    }else{
        self.zhiye.text = @"无";
    }
    if (_info.DateOfBirth.length > 0) {
        self.borthTime.text = _info.DateOfBirth;
    }else{
        self.borthTime.text = @"无";
    }
    if (_info.QQNumber.length > 0) {
        self.qqNum.text = _info.QQNumber;
    }else{
        self.qqNum.text = @"无";
    }
    if (_info.WechatNumber.length > 0) {
        self.weixin.text = _info.WechatNumber;
    }else{
        self.weixin.text = @"无";
    }
    if (_info.Phone.length > 0) {
        self.phoneLabel.text = _info.Phone;
    }else{
        self.phoneLabel.text = @"无";
    }
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 3;
    _backView.clipsToBounds = YES;
    _backView.layer.borderColor = LightGrayColor.CGColor;
    _backView.layer.borderWidth = 1;
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
