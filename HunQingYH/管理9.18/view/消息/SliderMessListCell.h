//
//  SliderMessListCell.h
//  HunQingYH
//
//  Created by Hiro on 2019/8/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SliderMessListCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
/**<#注释#>*/
@property(nonatomic,strong) messageModel  *model;
@end

NS_ASSUME_NONNULL_END
