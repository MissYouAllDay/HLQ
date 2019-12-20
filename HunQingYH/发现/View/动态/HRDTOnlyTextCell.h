//
//  HRDTOnlyTextCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/25.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRDongTaiModel.h"
@interface HRDTOnlyTextCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**动态模型*/
@property(nonatomic,strong)HRDongTaiModel  *dtModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *shenfenLab;
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *desLab;

@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UILabel *photoNumLab;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@end
