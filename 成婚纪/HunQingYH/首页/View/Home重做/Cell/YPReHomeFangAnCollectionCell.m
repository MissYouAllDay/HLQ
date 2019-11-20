//
//  YPReHomeFangAnCollectionCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeFangAnCollectionCell.h"

@implementation YPReHomeFangAnCollectionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)colView AndIndex:(NSIndexPath *)index{
    
    static NSString *reusedID = @"YPReHomeFangAnCollectionCell";
    YPReHomeFangAnCollectionCell *cell = [colView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeFangAnCollectionCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
