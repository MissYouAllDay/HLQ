//
//  YPMyKeYuan190313EditInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190313EditInputCell.h"

@implementation YPMyKeYuan190313EditInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190313EditInputCell";
    YPMyKeYuan190313EditInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190313EditInputCell" owner:nil options:nil] lastObject];
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
