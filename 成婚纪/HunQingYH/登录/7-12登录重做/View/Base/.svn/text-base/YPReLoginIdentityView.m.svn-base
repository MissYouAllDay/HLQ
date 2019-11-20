//
//  YPReLoginIdentityView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginIdentityView.h"

@implementation YPReLoginIdentityView

+ (instancetype)yp_reloginIdentityView{
    YPReLoginIdentityView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPReLoginIdentityView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (IBAction)xinrenClick:(UIButton *)sender {
    
    if (!sender.isSelected) {
        sender.selected = !sender.selected;
    }
    sender.tag = 1000;
    self.xinren.textColor = BlackColor;
    
    self.gongyingshang.textColor = LightGrayColor;
    self.gongyingshangBtn.selected = NO;
    self.hotel.textColor = LightGrayColor;
    self.hotelBtn.selected = NO;
    self.company.textColor = LightGrayColor;
    self.companyBtn.selected = NO;
    
    self.btnClickBlock(sender);
}

- (IBAction)gongyingshangClick:(UIButton *)sender {
    
    if (!sender.isSelected) {
        sender.selected = !sender.selected;
    }
    sender.tag = 1001;
    self.gongyingshang.textColor = BlackColor;
    
    self.xinren.textColor = LightGrayColor;
    self.xinrenBtn.selected = NO;
    self.hotel.textColor = LightGrayColor;
    self.hotelBtn.selected = NO;
    self.company.textColor = LightGrayColor;
    self.companyBtn.selected = NO;
    
    self.btnClickBlock(sender);
}

- (IBAction)hotelClick:(UIButton *)sender {
    
    if (!sender.isSelected) {
        sender.selected = !sender.selected;
    }
    sender.tag = 1002;
    self.hotel.textColor = BlackColor;
    
    self.gongyingshang.textColor = LightGrayColor;
    self.gongyingshangBtn.selected = NO;
    self.xinren.textColor = LightGrayColor;
    self.xinrenBtn.selected = NO;
    self.company.textColor = LightGrayColor;
    self.companyBtn.selected = NO;
    
    self.btnClickBlock(sender);
}

- (IBAction)companyClick:(UIButton *)sender {
    
    if (!sender.isSelected) {
        sender.selected = !sender.selected;
    }
    sender.tag = 1003;
    self.company.textColor = BlackColor;
    
    self.gongyingshang.textColor = LightGrayColor;
    self.gongyingshangBtn.selected = NO;
    self.hotel.textColor = LightGrayColor;
    self.hotelBtn.selected = NO;
    self.xinren.textColor = LightGrayColor;
    self.xinrenBtn.selected = NO;
    
    self.btnClickBlock(sender);
}

- (IBAction)areaBtnClick:(UIButton *)sender {
    
    sender.tag = 1004;
    self.btnClickBlock(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
