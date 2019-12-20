//
//  SliderMessListCell.m
//  HunQingYH
//
//  Created by Hiro on 2019/8/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "SliderMessListCell.h"

@implementation SliderMessListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"SliderMessListCell";
    SliderMessListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SliderMessListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(messageModel *)model{
    _model =model;
    self.desLab.text =[NSString stringWithFormat:@"%@ %@ 预订了%@,请尽快安排处理该订单",model.UserName,model.ReserveTime,model.BanquetName];
    self.timeLab.text =model.ReserveTime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.clipsToBounds =YES;
    self.bgView.layer.cornerRadius =5;
    [self addShadowToView:self.bgView withColor:GrayColor];
    self.bgView.clipsToBounds =NO;
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
