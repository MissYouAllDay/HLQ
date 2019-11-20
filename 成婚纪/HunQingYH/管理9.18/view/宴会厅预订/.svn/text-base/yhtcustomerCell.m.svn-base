//
//  yhtcustomerCell.m
//  HunQingYH
//
//  Created by xl on 2019/7/5.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtcustomerCell.h"

@implementation yhtcustomerCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtcustomerCell";
    yhtcustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"yhtcustomerCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(customerModel *)model{
    _model =model;
    self.shenfenLab.text =model.shenfenStr;
    self.nameLab.text =model.nameStr;
    self.phoneLab.text =model.phoneStr;
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
