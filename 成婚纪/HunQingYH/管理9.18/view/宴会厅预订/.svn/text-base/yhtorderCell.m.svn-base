//
//  yhtorderCell.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "yhtorderCell.h"

@implementation yhtorderCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtorderCell";
    yhtorderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"yhtorderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(yhtyudingListModel *)model{
    _model =model;
    self.nameLab.text =model.UserName;
    self.phoneLab.text =model.UserPhone;
    [self.tingIconImageView sd_setImageWithURL:[NSURL URLWithString:model.BanquetImage] placeholderImage:[UIImage imageNamed:@"1024"]];
    self.tingNameLab.text =model.BanquetName;
    self.NumLab.text =model.TableNumber;
    self.canbiaoLab.text =[NSString stringWithFormat:@"￥%@/桌",model.MealPrice];
    self.timeLab.text =model.DinnerTime;
    self.dingjinLab.text =[NSString stringWithFormat:@"￥%@",model.Earnest];
    if ([model.EarnestType integerValue]==0) {
        self.stateLab.text =@"预留";
    }else{
        self.stateLab.text =@"已交定金";
        self.stateLab.textColor =MainColor;
    }
}
//添加四周阴影效果
-(void)addShadowToView:(UIView*)theView withColor:(UIColor*)theColor{
    //阴影颜色
    theView.layer.shadowColor =theColor.CGColor;
    //阴影偏移 默认（0，-3）
    theView.layer.shadowOffset =CGSizeMake(0,0);
    //阴影透明度，默认0
    theView.layer.shadowOpacity =0.3;
    //阴影半径，默认3
    theView.layer.shadowRadius =5;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.clipsToBounds =YES;
    self.bgView.layer.cornerRadius =10;
    [self addShadowToView:self.bgView withColor:GrayColor];
    self.bgView.clipsToBounds =NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
