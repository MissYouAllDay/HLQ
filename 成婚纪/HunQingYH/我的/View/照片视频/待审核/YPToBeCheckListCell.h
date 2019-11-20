//
//  YPToBeCheckListCell.h
//  hunqing
//
//  Created by Else丶 on 2018/3/15.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetUploadedFileList.h"

@interface YPToBeCheckListCell : UITableViewCell

/**模型*/
@property (nonatomic, strong) YPGetUploadedFileList *listModel;

@property (weak, nonatomic) IBOutlet UIView *manView;
@property (weak, nonatomic) IBOutlet UIView *womanView;
@property (weak, nonatomic) IBOutlet UILabel *manName;
@property (weak, nonatomic) IBOutlet UILabel *manPhone;
@property (weak, nonatomic) IBOutlet UILabel *womanName;
@property (weak, nonatomic) IBOutlet UILabel *womanPhone;
@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
