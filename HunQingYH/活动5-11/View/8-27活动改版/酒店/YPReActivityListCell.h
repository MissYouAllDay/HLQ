//
//  YPReActivityListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetFacilitatorActivityCoverMapListData.h"

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);
//typedef void(^SupplierHomePageBtnBlock)(NSIndexPath *indexPath);

@interface YPReActivityListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

//@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UIImageView *iconImgV;
@property (nonatomic, strong) UIButton *titleBtn;
@property (strong, nonatomic) UIButton *allBtn;
@property (strong, nonatomic) UICollectionView *goodsView;

@property (nonatomic, strong) NSArray<YPGetFacilitatorActivityCoverMapListData *> *dataArr; 

@property (nonatomic, copy) ColCellClick colCellClick;
//@property (nonatomic, copy) SupplierHomePageBtnBlock homePageBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
