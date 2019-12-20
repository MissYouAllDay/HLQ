//
//  YPHome180904TaoCanListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWeddingPackageList.h"

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);

@interface YPHome180904TaoCanListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

/** 图片数组*/
@property (nonatomic, strong) NSArray<YPGetWeddingPackageList *> *listArr;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UICollectionView *colView;

@property (nonatomic, copy) ColCellClick colCellClick;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
