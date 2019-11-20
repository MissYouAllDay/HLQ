//
//  YPHYTHOrderPayWaySelectCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/4.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderPayWaySelectCell.h"

@implementation YPHYTHOrderPayWaySelectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderPayWaySelectCell";
    YPHYTHOrderPayWaySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderPayWaySelectCell" owner:nil options:nil] lastObject];
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
