//
//  YPFBKYInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/4/1.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPFBKYInputCell.h"

@implementation YPFBKYInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFBKYInputCell";
    YPFBKYInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFBKYInputCell" owner:nil options:nil] lastObject];
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
