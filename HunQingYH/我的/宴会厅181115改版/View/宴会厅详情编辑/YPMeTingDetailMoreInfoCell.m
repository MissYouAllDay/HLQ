//
//  YPMeTingDetailMoreInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeTingDetailMoreInfoCell.h"

@implementation YPMeTingDetailMoreInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMeTingDetailMoreInfoCell";
    YPMeTingDetailMoreInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMeTingDetailMoreInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setEditBtn:(UIButton *)editBtn{
    _editBtn = editBtn;
    _editBtn.layer.cornerRadius = 14;
    _editBtn.clipsToBounds = YES;
    _editBtn.layer.borderColor = RGBS(170).CGColor;
    _editBtn.layer.borderWidth = 1;
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
