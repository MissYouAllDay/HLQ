//
//  YPHome180904TaoCanListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHome180904TaoCanListCell.h"
#import "YPHome180904TaoCanListColCell.h"

@implementation YPHome180904TaoCanListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMe180831MutiBtnCell";
    YPHome180904TaoCanListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome180904TaoCanListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListArr:(NSArray<YPGetWeddingPackageList *> *)listArr{
    _listArr = listArr;
    [self setupColView];
    
    [self.colView reloadData];
}

- (void)setGxArr:(NSArray<YPGetDemoPlanList *> *)gxArr{
    _gxArr = gxArr;
    [self setupColView];
    
    [self.colView reloadData];
}

- (void)setupColView{
    
    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ScreenWidth-36, (ScreenWidth-36)*0.85);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-10, (ScreenWidth-36)*0.85) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = ClearColor;
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.backView);
//        make.left.top.mas_equalTo(self.backView).mas_offset(2);
//        make.bottom.right.mas_equalTo(self.backView).mas_offset(-2);
    }];
    
    [self.colView registerNib:[UINib nibWithNibName:@"YPHome180904TaoCanListColCell" bundle:nil] forCellWithReuseIdentifier:@"YPHome180904TaoCanListColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.gxArr.count > 0) {
        return self.gxArr.count;
    }
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHome180904TaoCanListColCell *cell = (YPHome180904TaoCanListColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPHome180904TaoCanListColCell" forIndexPath:indexPath];
    //colCell圆角阴影
//    cell.layer.cornerRadius = 4;
//    cell.layer.masksToBounds = YES;
//    cell.layer.masksToBounds = NO;
//    cell.layer.contentsScale = [UIScreen mainScreen].scale;
//    cell.layer.shadowOpacity = 0.5f;
//    cell.layer.shadowRadius = 4.0f;
//    cell.layer.shadowColor = LightGrayColor.CGColor;
//    cell.layer.shadowOffset = CGSizeMake(1,1);
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
//    cell.layer.shouldRasterize = YES;
//    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if (self.gxArr.count > 0) {
        YPGetDemoPlanList *list = self.gxArr[indexPath.item];
        if (list.PlanTitle.length > 0) {
            cell.titleLabel.text = list.PlanTitle;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (list.PlanKeyWord.length > 0) {
            cell.tag1.text = [list.PlanKeyWord stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }else{
            cell.tag1.text = @"无关键字";
        }
        cell.priceLabel.text = list.Color;
        
        //18-09-11 修改 只有一张大图
        [cell.zhuWuTaiImgV sd_setImageWithURL:[NSURL URLWithString:list.ShowImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.zhuWuTaiImgV.layer.cornerRadius = 12;
        cell.zhuWuTaiImgV.clipsToBounds = YES;
    }else{
        YPGetWeddingPackageList *list = self.listArr[indexPath.item];
        if (list.Name.length > 0) {
            cell.titleLabel.text = list.Name;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (list.Label.length > 0) {
            cell.tag1.text = [list.Label stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }else{
            cell.tag1.text = @"无关键字";
        }
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%zd",[list.PresentPrice integerValue]];
        
        //18-09-11 修改 只有一张大图
        [cell.zhuWuTaiImgV sd_setImageWithURL:[NSURL URLWithString:list.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.zhuWuTaiImgV.layer.cornerRadius = 12;
        cell.zhuWuTaiImgV.clipsToBounds = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHome180904TaoCanListColCell *cell = (YPHome180904TaoCanListColCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.colCellClick(cell.titleLabel.text, indexPath);
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
