//
//  yhtorderOneCordCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/23.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtorderOneCordCell.h"

@implementation yhtorderOneCordCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"yhtorderOneCordCell";
    yhtorderOneCordCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"yhtorderOneCordCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentview.clipsToBounds =YES;
    self.contentview.layer.cornerRadius =5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
