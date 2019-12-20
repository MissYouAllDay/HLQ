//
//  CXCompanyReviceLogCell.m
//  HunQingYH
//
//  Created by apple on 2019/10/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXCompanyReviceLogCell.h"

@interface CXCompanyReviceLogCell ()

@property (nonatomic, strong) CALayer *lineLay;

@end
@implementation CXCompanyReviceLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineLay = [[CALayer alloc] init];
    self.lineLay.frame = CGRectMake(0, 0, 1, self.height);
    self.lineLay.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    
    
//    [self.name.layer addSublayer:self.lineLay];
//    [self.phone.layer addSublayer:self.lineLay];
//    [self.date.layer addSublayer:self.lineLay];
//    [self.number.layer addSublayer:self.lineLay];
//    [self.canbiao.layer addSublayer:self.lineLay];
//    [self.payMoney.layer addSublayer:self.lineLay];
    
//    CALayer *bottomLayer = [[CALayer alloc] init];
//    bottomLayer.frame = CGRectMake(0, self.height, ScreenWidth, 1);
//    bottomLayer.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
//    [self.contentView.layer addSublayer:bottomLayer];
    
}

- (void)setIsHeader:(BOOL)isHeader {
    
//    _isHeader = isHeader;
//    self.lineLay.hidden = isHeader;
}

- (void)setModel:(YPGetFacilitatorFlowRecord *)model {
//    self.lineLay.hidden = NO;
    _model = model;
    self.name.text         = self.model.UserName;
    self.phone.text        = self.model.Phone;
    self.number.text      = self.model.TablesNumber;
    self.canbiao.text     = self.model.MealMark;
    self.payMoney.text = self.model.Money;
    
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy年MM月dd日";
    NSDate *date = [matter dateFromString:self.model.WeddingDate];
    matter.dateFormat = @"yyyy.MM.dd";
    self.date.text           = [matter stringFromDate:date];
}

- (void)setSectionHeaderValue {
    
    self.lineLay.hidden = YES;
    
    self.name.text         = @"姓名";
    self.phone.text        = @"手机号";
    self.date.text           = @"婚期";
    self.number.text      = @"桌数";
    self.canbiao.text     = @"餐标";
    self.payMoney.text = @"缴纳";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
