//
//  YPMyKeYuan190312DetailHeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190312DetailHeadCell.h"

@implementation YPMyKeYuan190312DetailHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190312DetailHeadCell";
    YPMyKeYuan190312DetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190312DetailHeadCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setEditBtn:(UIButton *)editBtn{
    _editBtn = editBtn;
    _editBtn.layer.cornerRadius = 4;
    _editBtn.clipsToBounds = YES;
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
