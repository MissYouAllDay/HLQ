//
//  HRVideoTableViewCell.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRVideoTableViewCell.h"

@implementation HRVideoTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRVideoTableViewCell";
    HRVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRVideoTableViewCell" owner:nil options:nil] lastObject];
      
    }
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.VideoimageView.contentMode = UIViewContentModeScaleAspectFill;
    self.VideoimageView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
