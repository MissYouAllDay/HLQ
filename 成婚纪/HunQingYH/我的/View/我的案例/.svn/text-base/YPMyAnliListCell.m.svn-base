//
//  YPMyAnliListCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyAnliListCell.h"

@implementation YPMyAnliListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyAnliListCell";
    YPMyAnliListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyAnliListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setInfoList:(YPCaseInfoInfoList *)infoList{
    _infoList = infoList;
    self.iconImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_infoList.CoverMap]];
    self.titleLabel.text = _infoList.LogTitle;
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
