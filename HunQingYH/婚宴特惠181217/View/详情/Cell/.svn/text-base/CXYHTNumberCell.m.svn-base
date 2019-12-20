//
//  CXYHTNumberCell.m
//  HunQingYH
//
//  Created by apple on 2019/10/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXYHTNumberCell.h"

@implementation CXYHTNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.line1.backgroundColor =
    self.line2.backgroundColor =
    self.line3.backgroundColor =
    self.line4.backgroundColor =
    self.line5.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.areaTitle.font =
    self.widthTitle.font =
    self.columnTitle.font =
    self.lengthTItle.font =
    self.floorHeightTitle.font =
    self.areaLab.font =
    self.widthLab.font =
    self.columnLab.font =
    self.lengthLab.font =
    self.floorHeightLab.font = kFont(13);
    
    self.areaLab.textColor =
    self.widthLab.textColor =
    self.columnLab.textColor =
    self.lengthLab.textColor =
    self.floorHeightLab.textColor = [UIColor colorWithHexString:@"#818181"];
}

- (void)setModel:(YPGetPreferentialCommodityInfo *)model {
    
    _model = model;
    
    self.areaLab.text = [NSString stringWithFormat:@"%@ ㎡",self.model.Acreage];
    self.widthLab.text = [NSString stringWithFormat:@"%@ m",self.model.Width];
    self.columnLab.text = [NSString stringWithFormat:@"%ld",self.model.Column];
    self.lengthLab.text = [NSString stringWithFormat:@"%@ m",self.model.Length];
    self.floorHeightLab.text = [NSString stringWithFormat:@"%@ m",self.model.Height];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
