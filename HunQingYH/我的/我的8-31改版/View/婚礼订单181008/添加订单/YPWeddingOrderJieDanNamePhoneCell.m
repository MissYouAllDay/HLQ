//
//  YPWeddingOrderJieDanNamePhoneCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderJieDanNamePhoneCell.h"

@implementation YPWeddingOrderJieDanNamePhoneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWeddingOrderJieDanNamePhoneCell";
    YPWeddingOrderJieDanNamePhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWeddingOrderJieDanNamePhoneCell" owner:nil options:nil] lastObject];
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
