//
//  YPKYGFBannerCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKYGFBannerCell.h"

@implementation YPKYGFBannerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPKYGFBannerCell";
    YPKYGFBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPKYGFBannerCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
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
