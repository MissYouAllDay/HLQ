//
//  YPSupplierInfoCanBiaoOtherInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/21.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierInfoCanBiaoOtherInputCell.h"

@implementation YPSupplierInfoCanBiaoOtherInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierInfoCanBiaoOtherInputCell";
    YPSupplierInfoCanBiaoOtherInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierInfoCanBiaoOtherInputCell" owner:nil options:nil] lastObject];
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
