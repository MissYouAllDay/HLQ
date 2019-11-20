//
//  YPHYTHOrderDetailPaidInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderDetailPaidInfoCell.h"

@implementation YPHYTHOrderDetailPaidInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderDetailPaidInfoCell";
    YPHYTHOrderDetailPaidInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderDetailPaidInfoCell" owner:nil options:nil] lastObject];
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
