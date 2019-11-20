//
//  YPHotelImgColCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/2.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPHotelImgColCell.h"

@implementation YPHotelImgColCell

+ (instancetype)cellWithColView:(UICollectionView *)colView IndexPath:(NSIndexPath *)indexPath{
//    static NSString *reusedID = @"YPHotelImgColCell";
    YPHotelImgColCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelImgColCell" owner:nil options:nil] lastObject];;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
