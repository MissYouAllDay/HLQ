//
//  HRTixianSelectCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "HRTixianSelectCell.h"

@implementation HRTixianSelectCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRTixianSelectCell";
    HRTixianSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRTixianSelectCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

-(void)setSelectFlag:(BOOL)selectFlag{
    _selectFlag =selectFlag;
    if (_selectFlag) {
        self.selectImageView.image =[UIImage imageNamed:@"tixian_Select"];
    }else{
        self.selectImageView.image =[UIImage imageNamed:@"tixian_NoSelect"];
    }
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
