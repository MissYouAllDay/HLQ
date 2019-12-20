//
//  YPReHomeSupplierListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeSupplierListCell.h"

@implementation YPReHomeSupplierListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeSupplierListCell";
    YPReHomeSupplierListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeSupplierListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setGysModel:(YPGetFacilitatorList *)gysModel{
    
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
//    self.danbao.hidden = NO;
//    self.xiaofei.hidden = NO;
    
    //18-10-26 判断显示 - 窦
    if (_gysModel.Xfyl.integerValue == 0) {//0未参加,1已参加
        self.xiaofei.hidden = YES;
    }else if (_gysModel.Xfyl.integerValue == 1) {
        self.xiaofei.hidden = NO;
    }
    if (_gysModel.Hldb.integerValue == 0) {//0未参加,1已参加
        self.danbao.hidden = YES;
    }else if (_gysModel.Hldb.integerValue == 1) {
        self.danbao.hidden = NO;
    }
    
    if (_gysModel.Tag.length > 0) {//Tag有值并且是酒店
        if (JiuDian(_gysModel.SupplierIdentity)) {
            self.tagLabel.text = [NSString stringWithFormat:@" %@ ",_gysModel.Tag];
            self.tagImgV.hidden = NO;
        }else{
            self.tagLabel.text = @"";
            self.tagImgV.hidden = YES;
        }
    }else{
        self.tagLabel.text = @"";
        self.tagImgV.hidden = YES;
    }
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 4;
    _iconImgV.clipsToBounds = YES;
}

- (void)setDanbao:(UILabel *)danbao{
    _danbao = danbao;
    
    _danbao.layer.cornerRadius = 1;
    _danbao.clipsToBounds = YES;
    _danbao.layer.borderColor = RGBA(102, 154, 255, 1).CGColor;
    _danbao.layer.borderWidth = 1;
}

- (void)setXiaofei:(UILabel *)xiaofei{
    _xiaofei = xiaofei;
    
    _xiaofei.layer.cornerRadius = 1;
    _xiaofei.clipsToBounds = YES;
    _xiaofei.layer.borderColor = RGBA(253, 156, 39, 1).CGColor;
    _xiaofei.layer.borderWidth = 1;
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
