//
//  CXSmallTestResultCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/11.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXSmallTestResultCell.h"

@implementation CXSmallTestResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)showHeaderData {
    
    self.zeroLab.text = @"领取时间";
    self.firstLab.text = @"酒店领取";
    self.secondLab.text = @"婚庆领取";
    self.thirdLab.text = @"婚纱领取";
    
    self.zeroLab.font =
    self.firstLab.font =
    self.secondLab.font =
    self.thirdLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    self.zeroLab.textColor =
    self.firstLab.textColor =
    self.secondLab.textColor =
    self.thirdLab.textColor = [CXUtils colorWithHexString:@"#333333"];
    
}

- (void)showCellData:(NSString *)string {
    
    
    self.zeroLab.text = @"2020.12.12";
    self.firstLab.text = @"0.00";
    self.secondLab.text = @"0.00";
    self.thirdLab.text = @"0.00";
    
    self.zeroLab.font =
    self.firstLab.font =
    self.secondLab.font =
    self.thirdLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    
    self.zeroLab.textColor =
    self.firstLab.textColor =
    self.secondLab.textColor =
    self.thirdLab.textColor = [CXUtils colorWithHexString:@"#585858"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
