//
//  HRYQJHTextCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJHTextCell.h"

@implementation HRYQJHTextCell
+ (instancetype)cellWithColView:(UICollectionView *)colView AndIndexPath:(NSIndexPath *)index{
    static NSString *reusedID = @"HRYQJHTextCell";
    HRYQJHTextCell *cell = [colView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRYQJHTextCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
