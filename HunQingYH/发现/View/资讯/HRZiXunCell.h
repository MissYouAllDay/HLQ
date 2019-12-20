//
//  HRZiXunCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetInformationArticleList.h"

@interface HRZiXunCell : UITableViewCell

/**模型*/
@property (nonatomic, strong) YPGetInformationArticleList *infoModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
