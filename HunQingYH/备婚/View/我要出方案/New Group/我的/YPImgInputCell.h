//
//  YPImgInputCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPImgInputCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *inputTF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
