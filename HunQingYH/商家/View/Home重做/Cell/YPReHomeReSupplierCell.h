//
//  YPReHomeReSupplierCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWebSupplierList.h"

@protocol YPReHomeReSupplierCellDelegate <NSObject>

@optional
-(void)supplierClickColRow: (NSInteger)CellRow;

@end

@interface YPReHomeReSupplierCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

/**model*/
@property (nonatomic, strong) NSMutableArray<YPGetWebSupplierList *> *gysMarr;

@property (nonatomic, assign) id<YPReHomeReSupplierCellDelegate> supplierDelegate;

@property (weak, nonatomic) IBOutlet UICollectionView *colView;

@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *anliStr;
@property (nonatomic, copy) NSString *zhuangtaiStr;
@property (nonatomic, copy) NSString *danbaoStr;
@property (nonatomic, copy) NSString *giftStr;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
