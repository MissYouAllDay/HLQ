//
//  YPInviteFriendsWedNormalThreeBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ColCellClick)(NSString *sectionName,NSIndexPath *indexPath);

@interface YPInviteFriendsWedNormalThreeBtnCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

/** 按钮数组*/
@property (nonatomic, strong) NSArray *nameArr;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UICollectionView *colView;

@property (nonatomic, copy) ColCellClick colCellClick;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
