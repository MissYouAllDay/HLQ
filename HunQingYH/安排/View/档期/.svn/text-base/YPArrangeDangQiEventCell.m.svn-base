//
//  YPArrangeDangQiEventCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeDangQiEventCell.h"

@implementation YPArrangeDangQiEventCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPArrangeDangQiEventCell";
    YPArrangeDangQiEventCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPArrangeDangQiEventCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
}

- (void)setScheduleModel:(YPGetScheduleList *)scheduleModel{
    _scheduleModel = scheduleModel;
 
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:scheduleModel.CorpLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = scheduleModel.CorpName;
    self.nameLabel.text =scheduleModel.CorpPhone;
    self.phone.hidden = YES;
    self.hotel.text = scheduleModel.CorpRummeryName;
    self.address.text = scheduleModel.RummeryAddress;
    if ([scheduleModel.Remark isEqualToString:@""]) {
         self.remark.text = @"未添加备注";
    }else{
        self.remark.text = scheduleModel.Remark;
    }
}
- (IBAction)phoneBtnClick:(id)sender {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.scheduleModel.CorpPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

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
