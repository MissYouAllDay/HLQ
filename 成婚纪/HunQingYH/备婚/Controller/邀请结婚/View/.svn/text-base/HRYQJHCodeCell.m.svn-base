//
//  HRYQJHCodeCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJHCodeCell.h"

@implementation HRYQJHCodeCell
+ (instancetype)cellWithColView:(UICollectionView *)colView AndIndexPath:(NSIndexPath *)index{
    static NSString *reusedID = @"HRYQJHCodeCell";
    HRYQJHCodeCell *cell = [colView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRYQJHCodeCell" owner:nil options:nil] lastObject];
    }
        return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
