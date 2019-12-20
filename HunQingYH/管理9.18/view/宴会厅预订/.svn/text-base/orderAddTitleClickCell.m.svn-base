//
//  orderAddTitleClickCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/28.
//  Copyright © 2019 xl. All rights reserved.
//

#import "orderAddTitleClickCell.h"

@implementation orderAddTitleClickCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"orderAddTitleClickCell";
    orderAddTitleClickCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"orderAddTitleClickCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(customerModel *)model{
    _model =model;
    [self.titleBtn setTitle:model.shenfenStr forState:UIControlStateNormal];
    self.oneTextField.text =model.nameStr;
    self.twoTextField.text =model.phoneStr;
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
