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
    
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
    
    
    
    CAGradientLayer *layer = [CXUtils gradientLayerWithFrame:CGRectMake(0, 0, ScreenWidth, self.subBtn.height) withColors:@[(id)[CXUtils colorWithHexString:@"#FF8400"].CGColor,(id)[CXUtils colorWithHexString:@"#FDB211"].CGColor,] withStartPoint:CGPointMake(0, 0) withEndPoint:CGPointMake(0, 1) withLocations:nil];
    [self.subBtn.layer addSublayer:layer];
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    self.subBtn.layer.masksToBounds = YES;
}

@end
