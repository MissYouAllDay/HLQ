//
//  YPHome190223FiveBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190223FiveBtnCell.h"

@implementation YPHome190223FiveBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome190223FiveBtnCell";
    YPHome190223FiveBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome190223FiveBtnCell" owner:nil options:nil] lastObject];
        cell.clipsToBounds = YES;
    }
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"婚礼秀",@"备婚指南",@"找商家"];
    NSArray *imgArr = @[@"home190223_hunlixiu",@"home190223_beihun",@"home190223_zhaoshangjia"];
    CGFloat width = ScreenWidth/titleArr.count;
    for (int i = 0; i < titleArr.count; i ++) {
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(i *width, 0, width, 70)];
        FSCustomButton *sender = [[FSCustomButton alloc] initWithFrame:CGRectMake(0, 0, width, 70)];
        [sender setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [sender setTitle:titleArr[i] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sender.titleLabel.font = kFont(13);
        sender.buttonImagePosition = FSCustomButtonImagePositionTop;
        [self.bgView addSubview:bg];
        [bg addSubview:sender];
        [sender addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0: self.hunlixiuBtn = sender; break;
            case 1: self.beihunBtn = sender; break;
            case 2: self.zhaoshangjiaBtn = sender; break;
            default: break;
        }
    }
  
}

- (void)sender:(UIButton *)sender {
    
    
    NSLog(@"戳击少");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
