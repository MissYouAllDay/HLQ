//
//  YPReHomeFuLiCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/2/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface YPReHomeFuLiCell : UITableViewCell

/**网址*/
@property (nonatomic, strong) NSArray *urlArr;
/**本地图片*/
@property (nonatomic, strong) NSArray *imgArr;
/**滚动视图*/
@property (nonatomic, strong) SDCycleScrollView *scrollView;
/**红包按钮*/
//@property (nonatomic, strong) UIButton *redWalletBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
