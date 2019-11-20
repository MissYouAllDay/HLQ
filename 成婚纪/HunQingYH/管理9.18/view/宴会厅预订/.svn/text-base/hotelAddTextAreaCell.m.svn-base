//
//  hotelAddTextAreaCell.m
//  HunQingYH
//
//  Created by xl on 2019/6/29.
//  Copyright © 2019 xl. All rights reserved.
//

#import "hotelAddTextAreaCell.h"

@implementation hotelAddTextAreaCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"hotelAddTextAreaCell";
    hotelAddTextAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotelAddTextAreaCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.beizhuTextView.layer.borderColor =LineColor.CGColor;
    self.beizhuTextView.layer.borderWidth =1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
