//
//  YPFreeWeddingInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPFreeWeddingInputCell.h"

@implementation YPFreeWeddingInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFreeWeddingInputCell";
    YPFreeWeddingInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFreeWeddingInputCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTagView:(UIView *)tagView{
    _tagView = tagView;
    
    _tagView.layer.cornerRadius = 3;
    _tagView.clipsToBounds = YES;
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
