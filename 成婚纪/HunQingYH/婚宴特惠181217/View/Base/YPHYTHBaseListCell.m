//
//  YPHYTHBaseListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHBaseListCell.h"

@implementation YPHYTHBaseListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHBaseListCell";
    YPHYTHBaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHBaseListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setList:(YPBanquetListObj *)list {
    
    _list = list;
    
    [self.imgV       sd_setImageWithURL:[NSURL URLWithString:list.HotelLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.HeadImg]  placeholderImage:[UIImage imageNamed:@"图片占位"]];
    self.tingTitle.text = list.BanquetHallName.length > 0 ? list.BanquetHallName : @"当前无名称";
    self.titleLabel.text = list.Name.length > 0 ? list.Name : @"当前无名称";
    self.canbiao.text = list.FloorPrice;
    self.zhuoshu.text = [NSString stringWithFormat:@"%ld-%ld",list.MinTableNumber,list.MaxTableCount];
    self.lijian.text = [NSString stringWithFormat:@"%@%%",list.Discount];
    self.countLabel.text = [NSString stringWithFormat:@"%@",list.ReservedQuantity];
    
}

- (void)setImgV:(UIImageView *)imgV{
    _imgV = imgV;
    _imgV.layer.cornerRadius = 12;
    _imgV.clipsToBounds = YES;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 11;
    _iconImgV.clipsToBounds = YES;
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
