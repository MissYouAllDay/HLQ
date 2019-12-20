//
//  YPFATagCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPFATagCell.h"

@implementation YPFATagCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFATagCell";
    YPFATagCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFATagCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setPlanList:(YPPlanInfoDetailed *)planList{
    _planList = planList;
    
    NSArray *arr = [_planList.AttState componentsSeparatedByString:@","];
    switch (arr.count) {
        case 0:
        {
            self.tag1.hidden = YES;
            self.tag2.hidden = YES;
            self.tag3.hidden = YES;
            self.tag4.hidden = YES;
            
        }
            break;
        case 1:
        {
            self.tag1.hidden = NO;
            self.tag1.text = arr[0];
            [self.tag1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
            }];
            self.tag2.hidden = YES;
            self.tag3.hidden = YES;
            self.tag4.hidden = YES;
            
        }
            break;
        case 2:
        {
            self.tag1.hidden = NO;
            self.tag1.text = arr[0];
            self.tag2.hidden = NO;
            self.tag2.text = arr[1];
            [self.tag1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView).mas_offset(40);
            }];
            [self.tag2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.tag1.mas_right).mas_offset(10);
            }];
            self.tag3.hidden = YES;
            self.tag4.hidden = YES;
            
        }
            break;
        case 3:
        {
            self.tag1.hidden = NO;
            self.tag1.text = arr[0];
            self.tag2.hidden = NO;
            self.tag2.text = arr[1];
            self.tag3.hidden = NO;
            self.tag3.text = arr[2];
            [self.tag2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
            }];
            [self.tag1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.tag2.mas_left).mas_offset(-10);
            }];
            [self.tag3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.tag2.mas_right).mas_offset(10);
            }];
            self.tag4.hidden = YES;
            
        }
            break;
        case 4:
        {
            self.tag1.hidden = NO;
            self.tag1.text = arr[0];
            self.tag2.hidden = NO;
            self.tag2.text = arr[1];
            self.tag3.hidden = NO;
            self.tag3.text = arr[2];
            self.tag4.hidden = NO;
            self.tag4.text = arr[3];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)setTag1:(UILabel *)tag1{
    _tag1 = tag1;
    
    _tag1.layer.borderWidth = 1;
    _tag1.layer.borderColor = RGB(151, 160, 170).CGColor;
    _tag1.layer.cornerRadius = 1;
    _tag1.clipsToBounds = YES;
}

- (void)setTag2:(UILabel *)tag2{
    _tag2 = tag2;
    
    _tag2.layer.borderWidth = 1;
    _tag2.layer.borderColor = RGB(151, 160, 170).CGColor;
    _tag2.layer.cornerRadius = 1;
    _tag2.clipsToBounds = YES;
}

- (void)setTag3:(UILabel *)tag3{
    _tag3 = tag3;
    
    _tag3.layer.borderWidth = 1;
    _tag3.layer.borderColor = RGB(151, 160, 170).CGColor;
    _tag3.layer.cornerRadius = 1;
    _tag3.clipsToBounds = YES;
}

- (void)setTag4:(UILabel *)tag4{
    _tag4 = tag4;
    
    _tag4.layer.borderWidth = 1;
    _tag4.layer.borderColor = RGB(151, 160, 170).CGColor;
    _tag4.layer.cornerRadius = 1;
    _tag4.clipsToBounds = YES;
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
