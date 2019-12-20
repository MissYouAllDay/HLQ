//
//  YPSupplierHomePageBaseYouHuiListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierHomePageBaseYouHuiListCell.h"

@implementation YPSupplierHomePageBaseYouHuiListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierHomePageBaseYouHuiListCell";
    YPSupplierHomePageBaseYouHuiListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierHomePageBaseYouHuiListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.backgroundColor = RGB(250, 240, 242);
}

- (void)setCircleView:(UIView *)circleView{
    _circleView = circleView;
    _circleView.layer.cornerRadius = 3;
    _circleView.clipsToBounds = YES;
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
