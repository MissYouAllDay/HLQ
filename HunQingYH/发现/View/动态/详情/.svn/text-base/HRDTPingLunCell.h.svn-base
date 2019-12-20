//
//  HRDTPingLunCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRPingLunModel.h"
#import "YPGetWeddingPackageEvaluateList.h"//6-13

@interface HRDTPingLunCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;

//4-13 添加
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
///5-28 添加
@property (weak, nonatomic) IBOutlet UILabel *shenfenLabel;

/**评论模型*/
@property(nonatomic,strong)HRPingLunModel  *model;
/**6-13 婚礼套餐 评价模型*/
@property (nonatomic, strong) YPGetWeddingPackageEvaluateList *pingModel;

@end
