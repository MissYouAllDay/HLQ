//
//  YPSupplierInfoRemarkCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierInfoRemarkCell.h"

@implementation YPSupplierInfoRemarkCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierInfoRemarkCell";
    YPSupplierInfoRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierInfoRemarkCell" owner:nil options:nil] lastObject];
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
