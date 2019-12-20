//
//  YPSupplierInfoBaseYouhuiListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierInfoBaseYouhuiListCell.h"

@implementation YPSupplierInfoBaseYouhuiListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierInfoBaseYouhuiListCell";
    YPSupplierInfoBaseYouhuiListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierInfoBaseYouhuiListCell" owner:nil options:nil] lastObject];
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
