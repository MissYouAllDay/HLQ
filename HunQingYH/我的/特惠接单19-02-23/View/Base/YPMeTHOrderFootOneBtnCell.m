//
//  YPMeTHOrderFootOneBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMeTHOrderFootOneBtnCell.h"

@implementation YPMeTHOrderFootOneBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMeTHOrderFootOneBtnCell";
    YPMeTHOrderFootOneBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMeTHOrderFootOneBtnCell" owner:nil options:nil] lastObject];
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
