//
//  YPReMeGuanzhuFensiListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeGuanzhuFensiListCell.h"

@implementation YPReMeGuanzhuFensiListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMeGuanzhuFensiListCell";
    YPReMeGuanzhuFensiListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMeGuanzhuFensiListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPUserFollowInfoList *)listModel{
    _listModel = listModel;
    
    if (_listModel.Name.length > 0) {
        self.titleLabel.text = _listModel.Name;
    }else{
        self.titleLabel.text = @"无名称";
    }
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_listModel.Headportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    
//    self.shenfenLabel.text = [NSString stringWithFormat:@" %@ ",_listModel.Profession];
    self.shenfenLabel.text = [CXDataManager checkUserProfession:_listModel.Profession];
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 25;
    _iconImgV.clipsToBounds = YES;
}

- (void)setShenfenLabel:(UILabel *)shenfenLabel{
    _shenfenLabel = shenfenLabel;
    
    _shenfenLabel.layer.cornerRadius = 3;
    _shenfenLabel.clipsToBounds = YES;
    _shenfenLabel.backgroundColor = RGB(250, 80, 120);
}

- (void)setGuanzhuBtn:(UIButton *)guanzhuBtn{
    _guanzhuBtn = guanzhuBtn;
    
    _guanzhuBtn.layer.cornerRadius = 3;
    _guanzhuBtn.clipsToBounds = YES;
    _guanzhuBtn.layer.borderColor = LightGrayColor.CGColor;
    _guanzhuBtn.layer.borderWidth = 1;
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
