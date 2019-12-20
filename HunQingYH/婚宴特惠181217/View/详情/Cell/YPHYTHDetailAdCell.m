//
//  YPHYTHDetailAdCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailAdCell.h"

@implementation YPHYTHDetailAdCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailAdCell";
    YPHYTHDetailAdCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailAdCell" owner:nil options:nil] lastObject];
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
