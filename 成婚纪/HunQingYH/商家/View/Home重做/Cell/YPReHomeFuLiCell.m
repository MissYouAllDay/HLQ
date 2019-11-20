//
//  YPReHomeFuLiCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeFuLiCell.h"

@implementation YPReHomeFuLiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeFuLiCell";
    YPReHomeFuLiCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeFuLiCell" owner:nil options:nil] lastObject];
        cell = [[YPReHomeFuLiCell alloc]init];
    }
    return cell;
    
}

- (void)setUrlArr:(NSArray *)urlArr{
    _urlArr = urlArr;
    
    if (!self.scrollView) {
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, ScreenWidth-20-125, (ScreenWidth-20)*0.38) imageURLStringsGroup:_urlArr];
//        __weak typeof(self) weakSelf = self;
        //        _banner.pageControlBottomOffset = 20;
        self.scrollView.currentPageDotColor = NavBarColor;
        self.scrollView.pageDotColor = WhiteColor;
    }
    [self.contentView addSubview:self.scrollView];
    
    if (!self.redWalletBtn) {
        self.redWalletBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.scrollView.frame)+10, 10, ScreenWidth-30-CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        [self.redWalletBtn setBackgroundImage:[UIImage imageNamed:@"hongbao"] forState:UIControlStateNormal];
    }
    [self.contentView addSubview:self.redWalletBtn];
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
