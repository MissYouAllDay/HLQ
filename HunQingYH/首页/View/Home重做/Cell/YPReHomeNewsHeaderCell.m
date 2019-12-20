//
//  YPReHomeNewsHeaderCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeNewsHeaderCell.h"

#define SelectedColor NavBarColor

@implementation YPReHomeNewsHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeNewsHeaderCell";
    YPReHomeNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeNewsHeaderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBtn1:(UIButton *)btn1{
    _btn1 = btn1;
    
    _btn1.layer.cornerRadius = 3;
    _btn1.clipsToBounds = YES;
    _btn1.layer.borderColor = LightGrayColor.CGColor;
    _btn1.layer.borderWidth = 1;
}

- (void)setBtn2:(UIButton *)btn2{
    _btn2 = btn2;
    
    _btn2.layer.cornerRadius = 3;
    _btn2.clipsToBounds = YES;
    _btn2.layer.borderColor = LightGrayColor.CGColor;
    _btn2.layer.borderWidth = 1;
}

- (void)setBtn3:(UIButton *)btn3{
    _btn3 = btn3;
    
    _btn3.layer.cornerRadius = 3;
    _btn3.clipsToBounds = YES;
    _btn3.layer.borderColor = LightGrayColor.CGColor;
    _btn3.layer.borderWidth = 1;
}

//- (IBAction)btn1Click:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    
//    if (!btn.isSelected) {
//        btn.selected = !btn.selected;
//        btn.backgroundColor = SelectedColor;
//        self.btn2.backgroundColor = WhiteColor;
//        self.btn3.backgroundColor = WhiteColor;
//        
//        if (self.btn1ClickBlock) {
//            self.btn1ClickBlock(btn);
//        }
//    }
//}
//
//- (IBAction)btn2Click:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    
//    if (!btn.isSelected) {
//        btn.selected = !btn.selected;
//        btn.backgroundColor = SelectedColor;
//        self.btn1.backgroundColor = WhiteColor;
//        self.btn3.backgroundColor = WhiteColor;
//        
//        if (self.btn2ClickBlock) {
//            self.btn2ClickBlock(btn);
//        }
//    }
//}
//
//- (IBAction)btn3Click:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    
//    if (!btn.isSelected) {
//        btn.selected = !btn.selected;
//        btn.backgroundColor = SelectedColor;
//        self.btn1.backgroundColor = WhiteColor;
//        self.btn2.backgroundColor = WhiteColor;
//        
//        if (self.btn3ClickBlock) {
//            self.btn3ClickBlock(btn);
//        }
//    }
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
