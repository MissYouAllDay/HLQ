//
//  danjianOrderCell.h
//  HunQingYH
//
//  Created by xl on 2019/6/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "danjianOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface danjianOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *wancanBtn;
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**<#注释#>*/
@property (weak, nonatomic) IBOutlet UIButton *wucanBtn;
@property (weak, nonatomic) IBOutlet UILabel *danjianNameLab;
@property (weak, nonatomic) IBOutlet UIView *wucanBgView;
@property (weak, nonatomic) IBOutlet UILabel *wucanLab;
@property (weak, nonatomic) IBOutlet UILabel *wucanName;
@property (weak, nonatomic) IBOutlet UILabel *wucanPhone;
@property (weak, nonatomic) IBOutlet UILabel *wucanNum;
@property (weak, nonatomic) IBOutlet UIView *wancanBgView;
@property (weak, nonatomic) IBOutlet UILabel *wancanLab;
@property (weak, nonatomic) IBOutlet UILabel *wancanNam;
@property (weak, nonatomic) IBOutlet UILabel *wancanPhone;
@property (weak, nonatomic) IBOutlet UILabel *wancanNum;
@property(nonatomic,strong)danjianOrderModel  *model;
@end

NS_ASSUME_NONNULL_END
