//
//  YPBeiHunColViewCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPBeiHunColViewCell.h"

@implementation YPBeiHunColViewCell

+ (instancetype)cellWithColView:(UICollectionView *)colView AndIndexPath:(NSIndexPath *)index{
    static NSString *reusedID = @"YPBeiHunColViewCell";
    YPBeiHunColViewCell *cell = [colView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPBeiHunColViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
