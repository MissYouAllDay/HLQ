//
//  YPMyKeYuan190312DetailMoreCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190312DetailMoreCell.h"

@implementation YPMyKeYuan190312DetailMoreCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190312DetailMoreCell";
    YPMyKeYuan190312DetailMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190312DetailMoreCell" owner:nil options:nil] lastObject];
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
