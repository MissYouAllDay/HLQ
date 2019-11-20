//
//  YPPassengerDistributionBannerCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/29.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPPassengerDistributionBannerCell.h"

@implementation YPPassengerDistributionBannerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPPassengerDistributionBannerCell";
    YPPassengerDistributionBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[YPPassengerDistributionBannerCell alloc]init];
    }
    return cell;
    
}

- (void)setUrlArr:(NSArray *)urlArr{
    _urlArr = urlArr;
    
    if (!self.scrollView) {
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(18, 0, ScreenWidth-36, ScreenWidth*0.33) imageURLStringsGroup:_urlArr];
        self.scrollView.currentPageDotColor = NavBarColor;
        self.scrollView.pageDotColor = WhiteColor;
        self.scrollView.layer.cornerRadius = 4;
        self.scrollView.clipsToBounds = YES;
    }
    [self.contentView addSubview:self.scrollView];
}

- (void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    
    if (!self.scrollView) {
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 0, ScreenWidth-20, 74) imageNamesGroup:_imgArr];
        self.scrollView.currentPageDotColor = NavBarColor;
        self.scrollView.pageDotColor = WhiteColor;
    }
    [self.contentView addSubview:self.scrollView];
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
