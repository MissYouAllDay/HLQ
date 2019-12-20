//
//  YPArrangeDangQiDriverEventCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeDangQiDriverEventCell.h"

@implementation YPArrangeDangQiDriverEventCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPArrangeDangQiDriverEventCell";
    YPArrangeDangQiDriverEventCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPArrangeDangQiDriverEventCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setDriverModel:(YPGetDriverScheduleList *)driverModel{
    _driverModel = driverModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_driverModel.CaptainImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = driverModel.CaptainName;
    self.phone.text = driverModel.CaptainPhone;
    self.hotel.text = _driverModel.RummeryName;
    self.address.text = _driverModel.RummeryAddress;
}

- (IBAction)phoneBtnClick:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.driverModel.CaptainPhone]]];
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
