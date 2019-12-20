//
//  YPPassegerDistribute1Cell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPPassegerDistribute1Cell.h"

@implementation YPPassegerDistribute1Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPPassegerDistribute1Cell";
    YPPassegerDistribute1Cell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPPassegerDistribute1Cell" owner:nil options:nil] lastObject];
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
