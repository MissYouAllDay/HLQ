//
//  YPOurNewlywedsDescCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOurNewlywedsDescCell.h"

@implementation YPOurNewlywedsDescCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPOurNewlywedsDescCell";
    YPOurNewlywedsDescCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPOurNewlywedsDescCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.backgroundColor = CHJ_bgColor;
    _backView.layer.cornerRadius = 3;
    _backView.clipsToBounds = YES;
    _backView.layer.borderColor = LightGrayColor.CGColor;
    _backView.layer.borderWidth = 1;
}

- (void)setContentLabel:(UILabel *)contentLabel{
    _contentLabel = contentLabel;
    
//    _contentLabel.attributedText = [self getAttributedStringWithString:contentLabel.text lineSpace:15.0];
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
