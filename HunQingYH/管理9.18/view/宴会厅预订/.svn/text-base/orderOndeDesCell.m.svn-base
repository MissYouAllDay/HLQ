//
//  orderOndeDesCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/22.
//  Copyright © 2019 xl. All rights reserved.
//

#import "orderOndeDesCell.h"

@implementation orderOndeDesCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtorderriliCell";
    orderOndeDesCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"orderOndeDesCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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
