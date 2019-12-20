//
//  HRZiXunCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRZiXunCell.h"

@implementation HRZiXunCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRZiXunCell";
    HRZiXunCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRZiXunCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}

- (void)setInfoModel:(YPGetInformationArticleList *)infoModel{
    _infoModel = infoModel;
    
    self.titleLabel.text = _infoModel.Title;
    self.tagLabel.text = _infoModel.WeddingInformationTitle;
    self.iconImgV .contentMode = UIViewContentModeScaleAspectFill;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_infoModel.ShowImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
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
