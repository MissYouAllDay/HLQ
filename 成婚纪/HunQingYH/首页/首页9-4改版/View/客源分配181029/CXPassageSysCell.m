//
//  CXPassageSysCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXPassageSysCell.h"

@implementation CXPassageSysCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSysCellDefaValueIsJoin:(BOOL)isJoin withName:(NSString *)name {
    
    NSString *join = isJoin ?  @"该商家参与" :  @"该商家未参与";
    UIColor *showColor = isJoin ? [UIColor colorWithHexString:@"#FB3F6E"] : [UIColor colorWithHexString:@"#A9A9A9"];
    NSMutableAttributedString *all = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",name,join] attributes:@{NSForegroundColorAttributeName:showColor,NSFontAttributeName:kFont(13)}];
    [all addAttribute:NSFontAttributeName value:kFont(11) range:NSMakeRange(name.length, join.length)];
    
    self.nameLab.attributedText = all;
    self.subLab.text = @"查看详情 >";
    self.subLab.font = kFont(11);
    self.subLab.textColor = showColor;
}

- (void)setSysCellDoubleValueIsJoin:(BOOL)isJoin{
    
    NSString *name = @"全额返现，下单立返0%，年年返，返完为止";
    NSString *join = @"";//@"补贴高达8000元\n该商家未合作暂无补贴";
    UIColor *showColor = isJoin ? [UIColor colorWithHexString:@"#FB3F6E"] : [UIColor colorWithHexString:@"#A9A9A9"];
    NSMutableAttributedString *all = [[NSMutableAttributedString alloc] initWithString:name attributes:@{NSForegroundColorAttributeName:showColor,NSFontAttributeName:kFont(16)}];
    
    self.nameLab.attributedText = all;
    self.subLab.text = join;
    self.subLab.font = kFont(9);
    self.subLab.textColor = showColor;
}

- (void)setSysCellServiceMoney:(NSString *)ServiceCharge withDiscountCharge:(NSString *)DiscountCharge {
    
    if (ISEMPTY(ServiceCharge)) {
        ServiceCharge = @"0";
    }
    if (ISEMPTY(DiscountCharge)) {
        DiscountCharge = @"0";
    }
    
    NSString *lowText = [NSString stringWithFormat:@"经平台预订享受的最低服务费 %@ %%    ",DiscountCharge];
    NSString *defaText = [NSString stringWithFormat:@"正常服务费为%@ %%",ServiceCharge];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",lowText,defaText] attributes:@{NSFontAttributeName:kFont(13)}];
    [att addAttribute:NSFontAttributeName value:kFont(11) range:NSMakeRange(lowText.length, defaText.length)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#818181"] range:NSMakeRange(lowText.length, defaText.length)];
    self.nameLab.attributedText = att;
}


@end
