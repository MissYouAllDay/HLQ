//
//  CXApplyPartnerMainView.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXApplyPartnerMainView.h"

@implementation CXApplyPartnerMainView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.nameBgView.layer.cornerRadius =
    self.telBgView.layer.cornerRadius =
    self.addressBgView.layer.cornerRadius =
    self.detailBgView.layer.cornerRadius = 5;
    
    self.nameBgView.layer.borderWidth =
    self.telBgView.layer.borderWidth =
    self.addressBgView.layer.borderWidth =
    self.detailBgView.layer.borderWidth = 0.5;

    self.nameBgView.layer.borderColor =
    self.telBgView.layer.borderColor =
    self.addressBgView.layer.borderColor =
    self.detailBgView.layer.borderColor = [UIColor colorWithHexString:@"#E5E5E5"].CGColor;
    
    self.subBtn.backgroundColor = [UIColor orangeColor];
    
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
}

@end
