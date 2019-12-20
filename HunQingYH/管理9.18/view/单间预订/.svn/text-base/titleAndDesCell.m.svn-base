//
//  titleAndDesCell.m
//  HunQingYH
//
//  Created by xl on 2019/7/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "titleAndDesCell.h"

@implementation titleAndDesCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"titleAndDesCell";
    titleAndDesCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"titleAndDesCell" owner:nil options:nil] lastObject];
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
