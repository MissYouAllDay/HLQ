//
//  YPHome180904ActivityCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPHome180904ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UILabel *smallLabel1;
@property (weak, nonatomic) IBOutlet UILabel *smallSubLab1;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgV1;
@property (weak, nonatomic) IBOutlet UIButton *smallBtn1;

@property (weak, nonatomic) IBOutlet UILabel *smallLabel2;
@property (weak, nonatomic) IBOutlet UILabel *smallSubLab2;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgV2;
@property (weak, nonatomic) IBOutlet UIButton *smallBtn2;

@property (weak, nonatomic) IBOutlet UILabel *smallLabel3;
@property (weak, nonatomic) IBOutlet UILabel *smallSubLab3;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgV3;
@property (weak, nonatomic) IBOutlet UIButton *smallBtn3;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
