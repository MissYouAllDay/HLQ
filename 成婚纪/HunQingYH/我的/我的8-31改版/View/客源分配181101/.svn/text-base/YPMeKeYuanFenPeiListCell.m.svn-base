//
//  YPMeKeYuanFenPeiListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/1.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeKeYuanFenPeiListCell.h"

@implementation YPMeKeYuanFenPeiListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMeKeYuanFenPeiListCell";
    YPMeKeYuanFenPeiListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMeKeYuanFenPeiListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setRemark:(FSCustomButton *)remark{
    _remark = remark;
    
    _remark.buttonImagePosition = FSCustomButtonImagePositionRight;
    
    _remark.layer.cornerRadius = 1;
    _remark.clipsToBounds = YES;
}

- (void)accessoryViewAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            
            [self.remark setImage:[UIImage imageNamed:@"shangArrow_white"] forState:UIControlStateNormal];
            
        } else {
            [self.remark setImage:[UIImage imageNamed:@"xiaArrow_white"] forState:UIControlStateNormal];
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpanded)
            [self removeIndicatorView];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
