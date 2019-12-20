//
//  YPEDuGoodsListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetCommodityTypeTableList.h"

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);

@interface YPEDuGoodsListCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) YPGetCommodityTypeTableList *listModel; 
@property (nonatomic, strong) NSArray<YPGetCommodityTypeTableListData *> *dataArr; 

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UIButton *allBtn;
@property (strong, nonatomic) UICollectionView *goodsView;

@property (nonatomic, copy) ColCellClick colCellClick;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
