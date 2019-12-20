//
//  hotelAddButtonCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/27.
//  Copyright © 2019 xl. All rights reserved.
//

#import "hotelAddButtonCell.h"

@implementation hotelAddButtonCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelAddButtonCell";
    hotelAddButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelAddButtonCell" owner:nil options:nil] lastObject];
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
