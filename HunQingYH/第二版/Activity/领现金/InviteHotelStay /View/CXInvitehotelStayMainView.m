//
//  CXInvitehotelStayMainView.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInvitehotelStayMainView.h"

@implementation CXInvitehotelStayMainView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    
    self.shopNameTF.textColor =
    self.areaTF.textColor =
    self.addressTF.textColor =
    self.canbiaoTF.textColor =
    self.tingNumTF.textColor =
    self.nameTF.textColor =
    self.telTF.textColor = [CXUtils colorWithHexString:@"#3A3A3A"];
    
    self.shopNameTF.placeholder = @"请输入酒店名称";
    self.areaTF.placeholder = @"请选择区域";
    self.addressTF.placeholder = @"请输入详细地址";
    self.nameTF.placeholder = @"请输入邀请人姓名";
    self.telTF.placeholder = @"请输入邀请人手机号";
    
    UIImage *img = [UIImage imageNamed:@"subBtnBgImg01"];
    UIEdgeInsets edg = UIEdgeInsetsMake(0, 0, 0, 0 );
    img = [img resizableImageWithCapInsets:edg resizingMode:UIImageResizingModeStretch];
    
    [self.subBtn setBackgroundImage:img forState:UIControlStateNormal];
    self.titleLab.textColor = [CXUtils colorWithHexString:@"#FA3D37"];
    
    self.canbiaoTF.keyboardType =
    self.tingNumTF.keyboardType = UIKeyboardTypeNumberPad;
}

- (BOOL)checkData {
    
    if (ISEMPTY_S(self.shopNameTF.text)) {
        [EasyShowTextView showText:@"请选择商户"];
        return NO;
    }
    if (ISEMPTY_S(self.areaTF.text)) {
           [EasyShowTextView showText:@"请选择地区"];
           return NO;
    }
    if (ISEMPTY_S(self.addressTF.text)) {
           [EasyShowTextView showText:@"请输入详细地址"];
           return NO;
    }
    if (ISEMPTY_S(self.canbiaoTF.text)) {
           [EasyShowTextView showText:@"请输入餐标"];
           return NO;
    }
    if (ISEMPTY_S(self.tingNumTF.text)) {
           [EasyShowTextView showText:@"请输入宴会厅数量"];
           return NO;
    }
    if (ISEMPTY_S(self.nameTF.text)) {
           [EasyShowTextView showText:@"请输入邀请人姓名"];
           return NO;
    }
    
    if (ISEMPTY_S(self.telTF.text)) {
           [EasyShowTextView showText:@"请输入邀请人电话"];
           return NO;
    }
    if (![CXUtils checkTelNumber:self.telTF.text]) {
        [EasyShowTextView showText:@"邀请人电话不正确"];
        return NO;
    }
    return YES;
    
}


@end
