//
//  YPHYTHOrderPayWayCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/4.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YPPayWayBtnClickBlock)(UIButton *btn1,UILabel *lab1,UILabel*lab2,UIButton *btn2,UILabel *lab3,UILabel*lab4);

@interface YPHYTHOrderPayWayCell : UITableViewCell

@property (nonatomic, copy) YPPayWayBtnClickBlock yp_payWayBlock;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UILabel *allLab1;
@property (weak, nonatomic) IBOutlet UILabel *allLab2;
@property (weak, nonatomic) IBOutlet UIButton *restBtn;
@property (weak, nonatomic) IBOutlet UILabel *restLab1;
@property (weak, nonatomic) IBOutlet UILabel *restLab2;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
