//
//  CXReceiveTableViewCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveTableViewCell.h"
#import "BRDatePickerView.h"
@implementation CXReceiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.line0.backgroundColor =
    self.line1.backgroundColor =
    self.line2.backgroundColor =
    self.line3.backgroundColor =
    self.line4.backgroundColor =
    self.line5.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.receiveLogLab.textColor =
    self.rightJLab.textColor =
    self.subBtn.backgroundColor = [UIColor colorWithHexString:@"#F9352B"];
    
    self.subBtn.layer.cornerRadius = 4;
    self.subBtn.clipsToBounds = YES;
    self.mainBgView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    
    self.telTF.keyboardType =
    self.tabNum.keyboardType =
    self.canBiaoTF.keyboardType =
    self.payMoneyTF.keyboardType = UIKeyboardTypeNumberPad;

    self.dateLab.text = @"2019  年  1  月  1  日";
    self.dateLab.textColor = [UIColor colorWithHexString:@"#D3D3D3"];
    self.dateLab.userInteractionEnabled = YES;

    [self changePlaceHolder:@"请填写姓名" withTF:self.nameTF];
    [self changePlaceHolder:@"请填写手机号" withTF:self.telTF];
    [self changePlaceHolder:@"10  桌" withTF:self.tabNum];
    [self changePlaceHolder:@"1000  元/桌" withTF:self.canBiaoTF];
    [self changePlaceHolder:@"1000  元" withTF:self.payMoneyTF];
}

- (void) changePlaceHolder:(NSString *)text withTF:(UITextField *)tf {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#D3D3D3"];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:text attributes:dict];
    [tf setAttributedPlaceholder:attribute];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
