//
//  YPHome190223FiveBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHome190223FiveBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cehuaImgV;
@property (weak, nonatomic) IBOutlet UILabel *cehua;
@property (weak, nonatomic) IBOutlet UIButton *cehuaBtn;

@property (weak, nonatomic) IBOutlet UIImageView *dinghunyanImgV;
@property (weak, nonatomic) IBOutlet UILabel *dinghunyan;
@property (weak, nonatomic) IBOutlet UIButton *dinghunyanBtn;

@property (weak, nonatomic) IBOutlet UIImageView *hunlixiuImgV;
@property (weak, nonatomic) IBOutlet UILabel *hunlixiu;

@property (weak, nonatomic) IBOutlet UIImageView *beihunImgV;
@property (weak, nonatomic) IBOutlet UILabel *beihun;


@property (weak, nonatomic) IBOutlet UIImageView *zhaoshangjiaImgV;
@property (weak, nonatomic) IBOutlet UILabel *zhaoshangjia;




@property (strong, nonatomic)  UIButton *hunlixiuBtn;
@property (strong, nonatomic)  UIButton *beihunBtn;
@property (strong, nonatomic)  UIButton *zhaoshangjiaBtn;





@property (weak, nonatomic) IBOutlet UIView *bgView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
