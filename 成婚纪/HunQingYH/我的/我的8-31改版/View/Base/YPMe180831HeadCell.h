//
//  YPMe180831HeadCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/31.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMe180831HeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *professionBtn;
@property (weak, nonatomic) IBOutlet UIButton *goHomePageBtn;
@property (weak, nonatomic) IBOutlet UILabel *guanzhu;
@property (weak, nonatomic) IBOutlet UILabel *fensi;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *fensiLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuFensiBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
