//
//  YPReHomeFangAnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWebPlanList.h"
#import "YPGetDemoPlanList.h"//5-15 共享方案

@protocol YPReHomeFangAnCellDelegate <NSObject>

@optional
-(void)ClickColRow: (NSInteger)CellRow;

@end

@interface YPReHomeFangAnCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

//@property (nonatomic, strong) NSMutableArray<YPGetWebPlanList *> *planList;

///5-15 共享方案
@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *demoPlanList; 

@property (nonatomic, assign) id<YPReHomeFangAnCellDelegate> cellDelegate;

@property (weak, nonatomic) IBOutlet UICollectionView *colView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
