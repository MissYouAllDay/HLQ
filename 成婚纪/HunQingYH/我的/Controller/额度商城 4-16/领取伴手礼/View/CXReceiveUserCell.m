//
//  CXReceiveUserCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveUserCell.h"

@implementation CXReceiveUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.relogBtn.layer.cornerRadius = self.reBtn.layer.cornerRadius = 4;
    self.relogBtn.layer.masksToBounds = self.reBtn.layer.masksToBounds = YES;
    self.relogBtn.backgroundColor = self.reBtn.backgroundColor = [UIColor colorWithHexString:@"#F9352B"];

    self.relogBtn.titleLabel.font = self.reBtn.titleLabel.font = kFont(10);
    
    [self.payMoneyLab sizeToFit];
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.payMoneyLab.textColor = [UIColor colorWithHexString:@"#F9352B"];
    self.detailLab.textColor = [UIColor colorWithHexString:@"#333333"];
}

- (void)setModel:(YPGetFacilitatorFlowRecord *)model {
    
    _model = model;
    
    if (!ISEMPTY(model.FacilitatorName) && !ISEMPTY(model.Money)) {
        self.payMoneyLab.text = [NSString stringWithFormat:@"您在%@的首次交款金额为%@元",model.FacilitatorName,model.Money];
        self.detailLab.text = @"您可选择以下对应的伴手礼套餐";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
