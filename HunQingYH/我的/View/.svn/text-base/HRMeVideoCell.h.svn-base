//
//  HRMeVideoCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRMeVideoCell;

@protocol HRMeVideoCellDelegate <NSObject>

- (void)cl_tableViewCellPlayVideoWithCell:(HRMeVideoCell *)cell;
@end
#import "YPGetFileSupplierData.h"
@interface HRMeVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fmImageView;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *buhegeBtn;
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**模型*/
@property(nonatomic,strong)YPGetFileSupplierData  *model;
@property (nonatomic, weak) id <HRMeVideoCellDelegate> delegate;
@end
