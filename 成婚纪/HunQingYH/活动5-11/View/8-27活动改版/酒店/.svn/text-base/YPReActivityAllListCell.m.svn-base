//
//  YPReActivityAllListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityAllListCell.h"

@implementation YPReActivityAllListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReActivityAllListCell";
    YPReActivityAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReActivityAllListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgV.layer.cornerRadius = 9;
    self.imgV.layer.masksToBounds = YES;
    self.imgV.layer.shadowColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.12].CGColor;
    self.imgV.layer.shadowOffset = CGSizeMake(0,4);
    self.imgV.layer.shadowOpacity = 1;
    self.imgV.layer.shadowRadius = 12;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
