//
//  YPKeYuan190320ReAllListself.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190320ReAllListCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPKeYuan190320ReAllListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPKeYuan190320ReAllListCell";
    YPKeYuan190320ReAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPKeYuan190320ReAllListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPGetJSJTableList *)listModel {
    
    _listModel = listModel;
    if (listModel.Source.integerValue == 0) {//0官方,1个人
        self.tagImgV.hidden = NO;
    }else{
        self.tagImgV.hidden = YES;
    }
    if (listModel.Name.length > 0) {
        self.titleLabel.text = listModel.Name;
    }else{
        self.titleLabel.text = @"无姓名";
    }
    if (listModel.Phone.length > 0) {
        self.phoneLabel.text = listModel.Phone;
    }else{
        self.phoneLabel.text = @"无手机号";
    }
    if (listModel.Identity.length > 0) {
        self.supplierLabel.text = listModel.Identity;
    }else{
        self.supplierLabel.text = @"无需求商家";
    }
    if (listModel.WeddingTime.length > 0) {
        self.hunqi.text = listModel.WeddingTime;
    }else{
        self.hunqi.text = @"无婚期";
    }
    self.zhuoshu.text = [NSString stringWithFormat:@"%@桌",listModel.TablesNumber];
    self.canbiao.text = [NSString stringWithFormat:@"%@元/桌",listModel.MealMark];
    
    ///**审核状态   0未申请,1审核中,2审核通过,3审核驳回*/
    switch ([listModel.ApplyType intValue]) {
        case 0: [self applyTypeWithUnApply]; break;
        case 1: [self applyTypeWithUnApply]; break;
        case 2: [self applyTypeWithUnApply]; break;
        case 3: [self applyTypeWithUnApply]; break;
        default:
            break;
    }
}

// 未申请
- (void)applyTypeWithUnApply {
    [self.applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [self.applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    self.applyBtn.userInteractionEnabled = YES;
    
}

// 审核中
- (void)applyTypeWithChecking {
    
    [self.applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0], [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:RGBS(220) forState:UIControlStateNormal];
    [self.applyBtn setTitle:@"审核中" forState:UIControlStateNormal];
    self.applyBtn.userInteractionEnabled = NO;
}

// 审核成功
- (void)applyTypeWithSuccess {
    
    [self.applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:RGBS(220) forState:UIControlStateNormal];
    [self.applyBtn setTitle:@"已申请" forState:UIControlStateNormal];
    self.applyBtn.userInteractionEnabled = NO;
}

// 审核驳回
- (void)applyTypeWithFail {
    [self.applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    
    [self.applyBtn setTitle:@"申请驳回" forState:UIControlStateNormal];
    self.applyBtn.userInteractionEnabled = YES;
}



- (void)setApplyBtn:(UIButton *)applyBtn{
    _applyBtn = applyBtn;
    _applyBtn.layer.cornerRadius = 17.5;
    _applyBtn.clipsToBounds = YES;
    [_applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
    _applyBtn.layer.shadowColor = [UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:0.18].CGColor;
    _applyBtn.layer.shadowOffset = CGSizeMake(0,2);
    _applyBtn.layer.shadowOpacity = 1;
    _applyBtn.layer.shadowRadius = 6;
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
