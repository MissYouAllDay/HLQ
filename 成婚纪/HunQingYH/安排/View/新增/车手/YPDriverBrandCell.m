//
//  YPDriverBrandCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/19.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDriverBrandCell.h"

@implementation YPDriverBrandCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPDriverBrandCell";
    YPDriverBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPDriverBrandCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setModel:(YPGetModelsListBySupplierID *)model{
    _model = model;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_model.CarImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if (_model.BrandName.length > 0) {
        self.brand.text = _model.BrandName;
    }else{
        self.brand.text = @"无";
    }
    if (_model.CarName.length > 0) {
        self.type.text = _model.CarName;
    }else{
        self.type.text = @"无";
    }
    if (_model.CarColor.length > 0) {
        self.color.text = _model.CarColor;
    }else{
        self.color.text = @"无";
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
