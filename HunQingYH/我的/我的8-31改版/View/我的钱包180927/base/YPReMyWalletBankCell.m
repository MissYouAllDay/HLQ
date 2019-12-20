//
//  YPReMyWalletBankCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReMyWalletBankCell.h"

@implementation YPReMyWalletBankCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMyWalletBankCell";
    YPReMyWalletBankCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMyWalletBankCell" owner:nil options:nil] lastObject];
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
