//
//  YPHunJJSponsorImgCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJJSponsorImgCell.h"
//#import "HZPhotoBrowserView.h"

//@interface YPHunJJSponsorImgCell()
//
//@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
//
//@end

@implementation YPHunJJSponsorImgCell{
//    HZPhotoBrowserView *_backView;
//    UIImageView *_bigImgV;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHunJJSponsorImgCell";
    YPHunJJSponsorImgCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHunJJSponsorImgCell" owner:nil options:nil] lastObject];
        cell.imgView.clipsToBounds = YES;
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
