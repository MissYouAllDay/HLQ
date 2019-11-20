//
//  yhtorderriliCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/17.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtorderriliCell.h"

@implementation yhtorderriliCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtorderriliCell";
    yhtorderriliCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"yhtorderriliCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgview.clipsToBounds =YES;
    self.bgview.layer.cornerRadius =10;
    [self addShadowToView:self.bgview withColor:GrayColor];
    self.bgview.clipsToBounds =NO;

    
}
-(void)setModel:(yhtyudingListModel *)model{
    _model =model;
    self.timeLab.text =model.DinnerTime;
    self.nameLab.text =model.UserName;
    self.numLab.text =[NSString stringWithFormat:@"%@桌",model.TableNumber];
    self.canbiaoLab.text =[NSString stringWithFormat:@"%@元/桌",model.MealPrice];
    if ([model.EarnestType isEqualToString:@"0"]) {
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
