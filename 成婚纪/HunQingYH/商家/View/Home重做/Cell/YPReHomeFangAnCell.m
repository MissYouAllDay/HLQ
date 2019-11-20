//
//  YPReHomeFangAnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeFangAnCell.h"
#import "YPReHomeFangAnCollectionCell.h"

static NSInteger colCellW = 250;

@implementation YPReHomeFangAnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeFangAnCell";
    YPReHomeFangAnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeFangAnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setColView:(UICollectionView *)colView{
    _colView = colView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(250, 205);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    if (!colView) {
        colView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 205) collectionViewLayout:layout];
    }
    
    _colView.collectionViewLayout = layout;
    
    _colView.delegate = self;
    _colView.dataSource = self;
    _colView.scrollsToTop = NO;
    _colView.showsVerticalScrollIndicator = NO;
    _colView.showsHorizontalScrollIndicator = NO;
    
//    _colView.frame = CGRectMake(0, 10, ScreenWidth, 205);

    [_colView registerNib:[UINib nibWithNibName:@"YPReHomeFangAnCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"YPReHomeFangAnCollectionCell"];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.planList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetWebPlanList *plan = self.planList[indexPath.item];
    
    YPReHomeFangAnCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPReHomeFangAnCollectionCell" forIndexPath:indexPath];
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:plan.ImgUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.titleLabel.text = plan.PlanName;
    cell.collectionLabel.hidden = YES;//暂时隐藏收藏数
    cell.collectionTitle.hidden = YES;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collection -- %zd",indexPath.item);
    
    if ([self.cellDelegate respondsToSelector:@selector(ClickColRow:)]) {
        [self.cellDelegate ClickColRow:indexPath.item];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
