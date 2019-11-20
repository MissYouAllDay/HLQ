//
//  YPSupplierInfo181119ListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierInfo181119ListCell.h"

@implementation YPSupplierInfo181119ListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierInfo181119ListCell";
    YPSupplierInfo181119ListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierInfo181119ListCell" owner:nil options:nil] lastObject];
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
    
    self.anli.text = _gysModel.AnliCount;
    
    self.dongtai.text = _gysModel.StateCount;
    
    //18-10-26 判断显示 - 窦
    if (_gysModel.Xfyl.integerValue == 0) {//0未参加,1已参加
        self.youli.hidden = YES;
    }else if (_gysModel.Xfyl.integerValue == 1) {
        self.youli.hidden = NO;
    }
    if (_gysModel.Hldb.integerValue == 0) {//0未参加,1已参加
        self.danbao.hidden = YES;
    }else if (_gysModel.Hldb.integerValue == 1) {
        self.danbao.hidden = NO;
    }
    
    if (_gysModel.Tag.length > 0) {//Tag有值并且是酒店
        if (JiuDian(_gysModel.SupplierIdentity)) {
            self.activityLabel.text = [NSString stringWithFormat:@" %@ ",_gysModel.Tag];
            self.activityImgV.hidden = NO;
        }else{
            self.activityLabel.text = @"";
            self.activityImgV.hidden = YES;
        }
    }else{
        self.activityLabel.text = @"";
        self.activityImgV.hidden = YES;
    }
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 4;
    _iconImgV.clipsToBounds = YES;
}

- (void)setDanbao:(UILabel *)danbao{
    _danbao = danbao;
    _danbao.layer.cornerRadius = 11;
    _danbao.clipsToBounds = YES;
}

- (void)setYouli:(UILabel *)youli{
    _youli = youli;
    _youli.layer.cornerRadius = 11;
    _youli.clipsToBounds = YES;
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
