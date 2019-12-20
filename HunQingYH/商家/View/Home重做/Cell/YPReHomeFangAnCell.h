//
//  YPReHomeFangAnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWebPlanList.h"

@protocol YPReHomeFangAnCellDelegate <NSObject>

@optional
-(void)ClickColRow: (NSInteger)CellRow;

@end

@interface YPReHomeFangAnCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<YPGetWebPlanList *> *planList;

@property (nonatomic, assign) id<YPReHomeFangAnCellDelegate> cellDelegate;

@property (weak, nonatomic) IBOutlet UICollectionView *colView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
