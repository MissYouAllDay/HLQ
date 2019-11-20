//
//  YPReMeFourBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);

@interface YPReMeFourBtnCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>

/** 按钮数组*/
@property (nonatomic, strong) NSArray *nameArr;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UICollectionView *colView;

@property (nonatomic, copy) ColCellClick colCellClick;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
