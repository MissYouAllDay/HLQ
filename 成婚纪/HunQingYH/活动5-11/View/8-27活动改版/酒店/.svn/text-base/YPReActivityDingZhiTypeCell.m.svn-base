//
//  YPReActivityDingZhiTypeCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityDingZhiTypeCell.h"

@implementation YPReActivityDingZhiTypeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReActivityDingZhiTypeCell";
    YPReActivityDingZhiTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReActivityDingZhiTypeCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBenrenBtn:(UIButton *)benrenBtn{
    _benrenBtn = benrenBtn;
    
    _benrenBtn.layer.cornerRadius = 4;
    _benrenBtn.clipsToBounds = YES;
}

- (void)setXinrenBtn:(UIButton *)xinrenBtn{
    _xinrenBtn = xinrenBtn;
    
    _xinrenBtn.layer.cornerRadius = 4;
    _xinrenBtn.clipsToBounds = YES;
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
