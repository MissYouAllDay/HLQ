//
//  YPSupplierHomePageCycleHeadCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPSupplierHomePageCycleHeadCell : UITableViewCell

/**网址*/
@property (nonatomic, strong) NSArray *urlArr;
/**本地图片*/
@property (nonatomic, strong) NSArray *imgArr;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *profession;
@property (weak, nonatomic) IBOutlet UILabel *imgCount;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tehuiLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
