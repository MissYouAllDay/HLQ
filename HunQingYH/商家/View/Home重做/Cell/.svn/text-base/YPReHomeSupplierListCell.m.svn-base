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

- (void)setGysModel:(YPGetWebSupplierList *)gysModel{
    _gysModel = gysModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_gysModel.ImgUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    if (_gysModel.Name.length > 0){
        self.titleLabel.text = _gysModel.Name;
    }else{
        self.titleLabel.text = @"当前无名称";
    }
    
    self.anliCount.text = _gysModel.CaseCount;

    self.zhuangtaiCount.text = _gysModel.StateCount;
    
    if ([_gysModel.IsSign integerValue] == 1){//0未签约 1已签约
        self.danbaoImgV.hidden = NO;
    }else{
        self.danbaoImgV.hidden = YES;
    }
    
    if ([_gysModel.IsSign integerValue] == 1){//0未送礼 1已送礼
        self.giftImgV.hidden = NO;
    }else{
        self.giftImgV.hidden = YES;
    }
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
