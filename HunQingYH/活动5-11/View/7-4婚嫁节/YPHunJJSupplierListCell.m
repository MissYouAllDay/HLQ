//
//  YPHunJJSupplierListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJJSupplierListCell.h"

@implementation YPHunJJSupplierListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHunJJSupplierListCell";
    YPHunJJSupplierListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHunJJSupplierListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTagLabel:(UILabel *)tagLabel{
    _tagLabel = tagLabel;
    
    _tagLabel.layer.cornerRadius = 5;
    _tagLabel.layer.masksToBounds = YES;
}

- (IBAction)detailBtnClick:(id)sender {
    
    if (self.detailBtnBlock) {
        self.detailBtnBlock();
    }
    
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
