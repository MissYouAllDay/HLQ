//
//  slidermecell.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/21.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "slidermecell.h"

@implementation slidermecell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"slidermecell";
    slidermecell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"slidermecell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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
