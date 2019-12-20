//
//  hotelRecordCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/28.
//  Copyright © 2019 xl. All rights reserved.
//

#import "hotelRecordCell.h"

@implementation hotelRecordCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelRecordCell";
    hotelRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelRecordCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(caozuoModel *)model{
    _model =model;
    self.nameLab.text =model.Name;
    self.timeLab.text =model.Time;
    self.caozuoLab.text =model.OperationRecord;
    self.custNameLab.text =model.CustomerName;
    self.custPhoneLab.text =model.CustomerPhone;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor =CHJ_bgColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
