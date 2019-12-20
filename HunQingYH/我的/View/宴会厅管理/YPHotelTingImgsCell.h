//
//  YPHotelTingImgsCell.h
//  hunqing
//
//  Created by YanpengLee on 2017/6/2.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YPGetBanquetHallInfoImgs.h"

@interface YPHotelTingImgsCell : UITableViewCell

//测试
@property (nonatomic, strong) NSArray *imgArr;

//@property (nonatomic, strong) NSArray<YPGetBanquetHallInfoImgs *> *imgArr;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UICollectionView *colView;

@property (weak, nonatomic) IBOutlet UIView  *moreImgsView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
