//
//  YPHYTHOrderPayWayCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/4.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderPayWayCell.h"

@implementation YPHYTHOrderPayWayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderPayWayCell";
    YPHYTHOrderPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderPayWayCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (IBAction)allBtnClick:(UIButton *)sender {
    self.yp_payWayBlock(sender, self.allLab1, self.allLab2, self.restBtn, self.restLab1, self.restLab2);
}

- (IBAction)restBtnClick:(UIButton *)sender {
    self.yp_payWayBlock(sender, self.restLab1, self.restLab2, self.allBtn, self.allLab1, self.allLab2);
}

- (void)setAllBtn:(UIButton *)allBtn{
    _allBtn = allBtn;
    _allBtn.tag = 1001;
    _allBtn.layer.cornerRadius = 4;
    _allBtn.clipsToBounds = YES;
    _allBtn.layer.borderWidth = 1;
}

- (void)setRestBtn:(UIButton *)restBtn{
    _restBtn = restBtn;
    _restBtn.tag = 1002;
    _restBtn.layer.cornerRadius = 4;
    _restBtn.clipsToBounds = YES;
    _restBtn.layer.borderWidth = 1;
}

- (void)setAllLab1:(UILabel *)allLab1{
    _allLab1 = allLab1;
    _allLab1.userInteractionEnabled = NO;
}

- (void)setAllLab2:(UILabel *)allLab2{
    _allLab2 = allLab2;
    _allLab2.userInteractionEnabled = NO;
}

- (void)setRestLab1:(UILabel *)restLab1{
    _restLab1 = restLab1;
    _restLab1.userInteractionEnabled = NO;
}

- (void)setRestLab2:(UILabel *)restLab2{
    _restLab2 = restLab2;
    _restLab2.userInteractionEnabled = NO;
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
