//
//  yhtAddTwoBtnCell.m
//  HunQingYH
//
//  Created by xl on 2019/7/4.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtAddTwoBtnCell.h"

@implementation yhtAddTwoBtnCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtAddTwoBtnCell";
    yhtAddTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"yhtAddTwoBtnCell" owner:nil options:nil] lastObject];
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
