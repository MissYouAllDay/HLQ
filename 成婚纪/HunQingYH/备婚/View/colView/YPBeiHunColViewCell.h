//
//  YPBeiHunColViewCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBeiHunColViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithColView:(UICollectionView *)colView AndIndexPath:(NSIndexPath *)index;

@end
