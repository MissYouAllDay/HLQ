//
//  YPEDuAddAddressInputCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPEDuAddAddressInputCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *addressBook;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
