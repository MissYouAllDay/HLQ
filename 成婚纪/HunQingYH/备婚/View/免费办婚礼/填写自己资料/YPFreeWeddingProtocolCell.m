//
//  YPFreeWeddingProtocolCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPFreeWeddingProtocolCell.h"

@implementation YPFreeWeddingProtocolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFreeWeddingProtocolCell";
    YPFreeWeddingProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFreeWeddingProtocolCell" owner:nil options:nil] lastObject];
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
