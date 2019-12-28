//
//  CXGiftGoodDetailView.m
//  HunQingYH
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGiftGoodDetailView.h"

@implementation CXGiftGoodDetailView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self.telBtn addTarget:self action:@selector(telAction) forControlEvents:UIControlStateHighlighted];
}
- (void)setModel:(CXActivityCouponModel *)model {
    
    _model = model;
    
    [self.bannerImg sd_setImageWithURL:[NSURL URLWithString:self.model.CoverMap] placeholderImage:nil];
    
    self.activityName.text = self.model.Name;
    self.limitLab.text = @"";
    self.receiveLab.text = [NSString stringWithFormat:@"%d",[self.model.Number intValue] - [self.model.SurplusNumber intValue]];
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:self.model.MerchantName] placeholderImage:nil];
    self.shopName.text = self.model.MerchantName;
    self.shopAddressLab.text = self.model.MerchantAddress;
    self.validityTimeLab.text = self.model.ValidityTime;
    self.subInfoLimitelab.text = self.model.ReceiveCondition;

}

- (void)telAction {
    
    [CXUtils phoneAction:self.viewController withTel:self.model.MerchantPhone];
}

@end
