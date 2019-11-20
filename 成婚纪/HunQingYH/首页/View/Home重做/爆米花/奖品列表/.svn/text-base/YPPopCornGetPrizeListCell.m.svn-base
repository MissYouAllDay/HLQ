//
//  YPPopCornGetPrizeListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornGetPrizeListCell.h"

@implementation YPPopCornGetPrizeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPPopCornGetPrizeListCell";
    YPPopCornGetPrizeListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPPopCornGetPrizeListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setRecordModel:(YPUserPopcornRecord *)recordModel{
    _recordModel = recordModel;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_recordModel.Img] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    if (_recordModel.Name.length > 0) {
        self.titleLabel.text = _recordModel.Name;
    }else{
        self.titleLabel.text = @"无名称";
    }
    
    if ([_recordModel.Type integerValue] == 0) {//0现金1实物2兑换
        self.getBtn.hidden = YES;
        self.tagLabel.hidden = NO;
        self.tagLabel.text = @"已添加至-我的账户";
    }else if ([_recordModel.Type integerValue] == 1 || [_recordModel.Type integerValue] == 2) {//0现金1实物2兑换
        if ([_recordModel.IsUse integerValue] == 0) {//0未领取1已领取
            self.getBtn.hidden = NO;
            self.tagLabel.hidden = YES;
        }else if ([_recordModel.IsUse integerValue] == 1){
            self.getBtn.hidden = YES;
            self.tagLabel.hidden = NO;
            self.tagLabel.text = @"已领取";
        }
    }
}

- (void)setGetBtn:(UIButton *)getBtn{
    _getBtn = getBtn;
    
    _getBtn.layer.cornerRadius = 15;
    _getBtn.clipsToBounds = YES;
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
