//
//  YPMyKeYuan190313EditRemarkCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190313EditRemarkCell.h"

@implementation YPMyKeYuan190313EditRemarkCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190313EditRemarkCell";
    YPMyKeYuan190313EditRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190313EditRemarkCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0].CGColor;
    
    _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _backView.layer.cornerRadius = 2;
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
