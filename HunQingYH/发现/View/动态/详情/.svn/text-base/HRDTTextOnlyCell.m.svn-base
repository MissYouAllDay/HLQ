//
//  HRDTTextOnlyCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTTextOnlyCell.h"

@implementation HRDTTextOnlyCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTTextOnlyCell";
    HRDTTextOnlyCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTTextOnlyCell" owner:nil options:nil] lastObject];
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
