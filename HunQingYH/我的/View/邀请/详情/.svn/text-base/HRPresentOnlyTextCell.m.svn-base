//
//  HRPresentOnlyTextCell.m
//  hunqing
//
//  Created by DiKai on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "HRPresentOnlyTextCell.h"

@implementation HRPresentOnlyTextCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRPresentOnlyTextCell";
    HRPresentOnlyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRPresentOnlyTextCell" owner:nil options:nil] lastObject];
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
