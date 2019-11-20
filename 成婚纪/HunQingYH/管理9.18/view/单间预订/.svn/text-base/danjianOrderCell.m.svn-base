//
//  danjianOrderCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "danjianOrderCell.h"
#import "danjianOrderSubModel.h"
@implementation danjianOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"danjianOrderCell";
    danjianOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"danjianOrderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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
-(void)setModel:(danjianOrderModel *)model{
    _model=model;
    self.danjianNameLab.text =model.Name;
    NSLog(@"****%zd",model.Data_1.count);
    if (model.Data_1.count==0) {
        //227，228，232
        self.wucanBgView.backgroundColor =RGB(227, 228, 232);
        self.wucanLab.textColor =TextNormalColor;
        self.wucanName.hidden =YES;
        self.wucanPhone.hidden =NO;
        self.wucanPhone.text =@"+点击添加预留";
        self.wucanNum.hidden =YES;
        
        self.wancanBgView.backgroundColor =RGB(227, 228, 232);
        self.wancanLab.textColor =TextNormalColor;
        self.wancanNam.hidden =YES;
        self.wancanPhone.hidden =NO;
        self.wancanPhone.text =@"+点击添加预留";
        self.wancanNum.hidden =YES;
    }
    
    if (model.Data_1.count==1) {
        danjianOrderSubModel *submodel =model.Data_1[0];
        if ([submodel.Type integerValue]==0) {
            
            self.wucanBgView.backgroundColor =RGB(255, 161, 1);
            self.wucanLab.textColor =WhiteColor;
            self.wucanName.hidden =NO;
            self.wucanName.text =submodel.Name;
            self.wucanPhone.hidden =NO;
            self.wucanPhone.text =submodel.Phone;
            self.wucanNum.hidden =NO;
            self.wucanNum.text =[NSString stringWithFormat:@"%@人",submodel.PeopleNumber];
            
            self.wancanBgView.backgroundColor =RGB(227, 228, 232);
            self.wancanLab.textColor =TextNormalColor;
            self.wancanNam.hidden =YES;
            self.wancanPhone.hidden =NO;
            self.wancanPhone.text =@"+点击添加预留";
            self.wancanNum.hidden =YES;
        }else{
            
            self.wancanBgView.backgroundColor =RGB(255, 161, 1);
            self.wancanLab.textColor =WhiteColor;
            self.wancanNam.hidden =NO;
            self.wancanNam.text =submodel.Name;
            self.wancanPhone.hidden =NO;
            self.wancanPhone.text =submodel.Phone;
            self.wancanNum.hidden =NO;
            self.wancanNum.text =[NSString stringWithFormat:@"%@人",submodel.PeopleNumber];
            
            self.wucanBgView.backgroundColor =RGB(227, 228, 232);
            self.wucanLab.textColor =TextNormalColor;
            self.wucanName.hidden =YES;
            self.wucanPhone.hidden =NO;
            self.wucanPhone.text =@"+点击添加预留";
            self.wucanNum.hidden =YES;
        }


            
        }
       
    
    
    
    if (model.Data_1.count>1) {
        danjianOrderSubModel *submodel1 =model.Data_1[0];
        danjianOrderSubModel *submodel2 =model.Data_1[1];
        if (submodel1.Type ==0) {
            //午餐
            self.wucanBgView.backgroundColor =RGB(255, 161, 1);
            self.wucanLab.textColor =WhiteColor;
            self.wucanName.hidden =NO;
            self.wucanName.text =submodel1.Name;
            self.wucanPhone.hidden =NO;
            self.wucanPhone.text =submodel1.Phone;
            self.wucanNum.hidden =NO;
            self.wucanNum.text =[NSString stringWithFormat:@"%@人",submodel1.PeopleNumber];
            
            self.wancanBgView.backgroundColor =RGB(255, 161, 1);
            self.wancanLab.textColor =WhiteColor;
            self.wancanNam.hidden =NO;
            self.wancanNam.text =submodel2.Name;
            self.wancanPhone.hidden =NO;
            self.wancanPhone.text =submodel2.Phone;
            self.wancanNum.hidden =NO;
            self.wancanNum.text =[NSString stringWithFormat:@"%@人",submodel2.PeopleNumber];
        }else{
            self.wucanBgView.backgroundColor =RGB(255, 161, 1);
            self.wucanLab.textColor =WhiteColor;
            self.wucanName.hidden =NO;
            self.wucanName.text =submodel2.Name;
            self.wucanPhone.hidden =NO;
            self.wucanPhone.text =submodel2.Phone;
            self.wucanNum.hidden =NO;
            self.wucanNum.text =[NSString stringWithFormat:@"%@人",submodel2.PeopleNumber];
            
            self.wancanBgView.backgroundColor =RGB(255, 161, 1);
            self.wancanLab.textColor =WhiteColor;
            self.wancanNam.hidden =NO;
            self.wancanNam.text =submodel1.Name;
            self.wancanPhone.hidden =NO;
            self.wancanPhone.text =submodel1.Phone;
            self.wancanNum.hidden =NO;
            self.wancanNum.text =[NSString stringWithFormat:@"%@人",submodel1.PeopleNumber];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
