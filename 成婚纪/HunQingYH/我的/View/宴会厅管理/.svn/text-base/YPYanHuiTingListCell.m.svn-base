//
//  YPYanHuiTingListCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/3.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPYanHuiTingListCell.h"

@implementation YPYanHuiTingListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPYanHuiTingListCell";
    YPYanHuiTingListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPYanHuiTingListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPCollectionList *)listModel{
    _listModel = listModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_listModel.CollectionLogo]  placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = _listModel.CollectionTitle;
    self.zhuoCountLabel.text = [NSString stringWithFormat:@"%@桌",[NSString stringWithFormat:@"%@元",_listModel.MinPrice]];
    self.cengHeight.text = [NSString stringWithFormat:@"%@元",_listModel.MinPrice];
}

- (void)setHallList:(YPGetBanquetHallList *)hallList{
    _hallList = hallList;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_hallList.HotelLogo]  placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = _hallList.BanquetHallName;
    self.zhuoCountLabel.text = [NSString stringWithFormat:@"%@桌",_hallList.MaxTableCount];
//    self.cengHeight.text = [NSString stringWithFormat:@"%@元",_hallList.FloorPrice];
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
