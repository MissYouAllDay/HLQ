//
//  hotelCanbiaoManageCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelCanbiaoManageCell.h"

@implementation hotelCanbiaoManageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelCanbiaoManageCell";
    hotelCanbiaoManageCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelCanbiaoManageCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.clipsToBounds =YES;
    self.bgView.layer.cornerRadius =5;
    [self addShadowToView:self.bgView withColor:TextNormalColor];
    self.bgView.clipsToBounds =NO;
    self.editBtn.clipsToBounds =YES;
    self.editBtn.layer.cornerRadius =15;
    
    
}
-(void)setModel:(canbiaoModel *)model{
    _model =model;
    self.tingNameLab.text =model.Name;
    self.priceLab.text =[NSString stringWithFormat:@"￥%@",model.Price];
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
    theView.layer.shadowRadius =3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
