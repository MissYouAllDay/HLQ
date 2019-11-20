//
//  HRCarCell.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRCarCell.h"

@implementation HRCarCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRCarCell";
    HRCarCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRCarCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setCarmodel:(HRCarStyleModel *)carmodel{
    _carmodel =carmodel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:carmodel.Img] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.nameLab.text=carmodel.Parent;
    self.numLab.text =[NSString stringWithFormat:@"%zd辆",carmodel.NumBer];
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
