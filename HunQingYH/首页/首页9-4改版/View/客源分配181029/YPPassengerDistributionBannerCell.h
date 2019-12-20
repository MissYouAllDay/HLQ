//
//  YPPassengerDistributionBannerCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/29.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPassengerDistributionBannerCell : UITableViewCell

/**网址*/
@property (nonatomic, strong) NSArray *urlArr;
/**本地图片*/
@property (nonatomic, strong) NSArray *imgArr;
/**滚动视图*/
@property (nonatomic, strong) SDCycleScrollView *scrollView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
