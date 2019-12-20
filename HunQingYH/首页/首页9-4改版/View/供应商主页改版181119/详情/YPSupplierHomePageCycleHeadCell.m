//
//  YPSupplierHomePageCycleHeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierHomePageCycleHeadCell.h"

@implementation YPSupplierHomePageCycleHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPSupplierHomePageCycleHeadCell";
    YPSupplierHomePageCycleHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPSupplierHomePageCycleHeadCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setUrlArr:(NSArray *)urlArr{
    _urlArr = urlArr;
    
    _cycleView.imageURLStringsGroup = _urlArr;
    _cycleView.currentPageDotColor = NavBarColor;
    _cycleView.pageDotColor = WhiteColor;
}

- (void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    
    _cycleView.localizationImageNamesGroup = _imgArr;
    _cycleView.currentPageDotColor = NavBarColor;
    _cycleView.pageDotColor = WhiteColor;
}

- (void)setCycleView:(SDCycleScrollView *)cycleView{
    _cycleView = cycleView;
    _cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleView.layer.cornerRadius = 8;
    _cycleView.clipsToBounds = YES;
}

- (void)setProfession:(UILabel *)profession{
    _profession = profession;
    _profession.layer.cornerRadius = 4;
    _profession.clipsToBounds = YES;
    _profession.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
}

- (void)setImgCount:(UILabel *)imgCount{
    _imgCount = imgCount;
    _imgCount.layer.cornerRadius = 9;
    _imgCount.clipsToBounds = YES;
    _imgCount.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
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
