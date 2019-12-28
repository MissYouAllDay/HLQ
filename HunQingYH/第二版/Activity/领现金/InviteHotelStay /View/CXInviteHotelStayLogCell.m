//
//  CXInviteHotelStayLogCell.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayLogCell.h"

@implementation CXInviteHotelStayLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
}

- (void)setModel:(CXInviteHotelListModel *)model {
    
    _model = model;
    
    self.timeLab.text = [NSString stringWithFormat:@"提交日期：%@",_model.CreateTime];
    self.shopNameTF.text = _model.FacilitatorName;
    self.addressTF.text = [NSString stringWithFormat:@"%@ %@",_model.AreaId,_model.Address];
    self.resultTF.text = [_model.Result intValue] == 0 ? @"未签约" : @"已签约";
    
    NSDictionary *defaAtt = @{NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#9D9C9C"]};
    NSString *canbiaoText = [NSString stringWithFormat:@"%@ 元",_model.MealMark];
    NSString *tingNumText = [NSString stringWithFormat:@"%@ 厅",_model.BanquetHall];

    NSMutableAttributedString *canbiaoAtt = [[NSMutableAttributedString alloc] initWithString:canbiaoText attributes:defaAtt];
    [canbiaoAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(canbiaoAtt.length - 1, 1)];
    
    NSMutableAttributedString *tingNumAtt = [[NSMutableAttributedString alloc] initWithString:tingNumText attributes:defaAtt];
    [tingNumAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(tingNumAtt.length - 1, 1)];

    self.canbiaoTF.attributedText = canbiaoAtt;
    self.tingNumTF.attributedText = tingNumAtt;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
