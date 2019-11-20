//
//  HRDLYQJLCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDLYQJLCell.h"
#import "HRInvitePeopleModel.h"
@implementation HRDLYQJLCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDLYQJLCell";
    HRDLYQJLCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDLYQJLCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(HRYQJLModel *)model{
    _model =model;
   
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
