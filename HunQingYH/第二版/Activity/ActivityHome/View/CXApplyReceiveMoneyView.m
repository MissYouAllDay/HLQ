//
//  CXApplyReceiveMoneyView.m
//  HunQingYH
//
//  Created by canxue on 2019/12/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXApplyReceiveMoneyView.h"

@implementation CXApplyReceiveMoneyView

- (void)awakeFromNib {
    
    [super awakeFromNib];
//    self.hidden = YES;
    
    self.nameBgView.layer.cornerRadius  =
    self.telBgView.layer.cornerRadius   =
    self.hunQiBgView.layer.cornerRadius =
    self.addressBgView.layer.cornerRadius =
    self.tabNumBgView.layer.cornerRadius  =
    self.canbiaoBgView.layer.cornerRadius =
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    
    self.nameBgView.layer.borderColor  =
    self.telBgView.layer.borderColor   =
    self.hunQiBgView.layer.borderColor =
    self.addressBgView.layer.borderColor =
    self.tabNumBgView.layer.borderColor  =
    self.canbiaoBgView.layer.borderColor = [CXUtils colorWithHexString:@"#F8616E"].CGColor;
    
    self.nameBgView.layer.borderWidth  =
    self.telBgView.layer.borderWidth   =
    self.hunQiBgView.layer.borderWidth =
    self.addressBgView.layer.borderWidth =
    self.tabNumBgView.layer.borderWidth  =
    self.canbiaoBgView.layer.borderWidth = 1;
    
    self.bgView.layer.cornerRadius = 10;
}

- (IBAction)closeBtn:(UIButton *)sender {

    
    [self removeFromSuperview];
}

- (void)showView {
    
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];

    [UIView animateWithDuration:0.35 animations:^{
        
        
        
    }];
   
}





@end
