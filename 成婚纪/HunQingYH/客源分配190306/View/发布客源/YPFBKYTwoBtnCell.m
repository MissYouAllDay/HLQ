//
//  YPFBKYTwoBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/4/1.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPFBKYTwoBtnCell.h"

@implementation YPFBKYTwoBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFBKYTwoBtnCell";
    YPFBKYTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFBKYTwoBtnCell" owner:nil options:nil] lastObject];
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
