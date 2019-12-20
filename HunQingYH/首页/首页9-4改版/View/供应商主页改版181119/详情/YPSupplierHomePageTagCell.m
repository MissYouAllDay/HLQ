//
//  YPSupplierHomePageTagCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierHomePageTagCell.h"

@implementation YPSupplierHomePageTagCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierHomePageTagCell";
    YPSupplierHomePageTagCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierHomePageTagCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setDanbao:(UILabel *)danbao{
    _danbao = danbao;
    _danbao.layer.cornerRadius = 11;
    _danbao.clipsToBounds = YES;
}

- (void)setYouli:(UILabel *)youli{
    _youli = youli;
    _youli.layer.cornerRadius = 11;
    _youli.clipsToBounds = YES;
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
