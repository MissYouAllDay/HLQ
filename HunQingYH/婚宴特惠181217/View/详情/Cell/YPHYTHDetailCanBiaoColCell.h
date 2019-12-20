//
//  YPHYTHDetailCanBiaoColCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetPreferentialCommodityPriceList.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);

@interface YPHYTHDetailCanBiaoColCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<YPGetPreferentialCommodityPriceList *> *listArr; 

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UICollectionView *colView;

@property (nonatomic, copy) ColCellClick colCellClick;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
