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

- (void)setupColView{
    
    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ScreenWidth-15*2-10, 240);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-15, 250) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = ClearColor;
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.mas_equalTo(self.backView);
        make.left.top.mas_equalTo(self.backView).mas_offset(2);
        make.bottom.right.mas_equalTo(self.backView).mas_offset(-2);
    }];
    
    [self.colView registerNib:[UINib nibWithNibName:@"YPHome180904TaoCanListColCell" bundle:nil] forCellWithReuseIdentifier:@"YPHome180904TaoCanListColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHome180904TaoCanListColCell *cell = (YPHome180904TaoCanListColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPHome180904TaoCanListColCell" forIndexPath:indexPath];

    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.layer.masksToBounds = NO;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.shadowRadius = 4.0f;
    cell.layer.shadowColor = LightGrayColor.CGColor;
    cell.layer.shadowOffset = CGSizeMake(1,1);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
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
    
    NSArray<YPGetWeddingPackageListAreaData *> *areaArr = list.AreaData;
    YPGetWeddingPackageListAreaData *areaData;
    YPGetWeddingPackageListAreaDataImageData *imgData;
    if (areaArr.count >= 3) {
        //图片1
        areaData = areaArr[0];
        if (areaData.AreaName.length > 0) {
            cell.bigLab.text = areaData.AreaName;
        }else{
            cell.bigLab.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.zhuWuTaiImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.zhuWuTaiImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
        //图片2
        areaData = areaArr[1];
        if (areaData.AreaName.length > 0) {
            cell.label2.text = areaData.AreaName;
        }else{
            cell.label2.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.qianDaoImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.qianDaoImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
        //图片3
        areaData = areaArr[2];
        if (areaData.AreaName.length > 0) {
            cell.label3.text = areaData.AreaName;
        }else{
            cell.label3.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.yingBinImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.yingBinImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
    }else if (areaArr.count == 2){
        
        //图片1
        areaData = areaArr[0];
        if (areaData.AreaName.length > 0) {
            cell.bigLab.text = areaData.AreaName;
        }else{
            cell.bigLab.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.zhuWuTaiImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.zhuWuTaiImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
        //图片2
        areaData = areaArr[1];
        if (areaData.AreaName.length > 0) {
            cell.label2.text = areaData.AreaName;
        }else{
            cell.label2.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.qianDaoImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.qianDaoImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
        //图片3
        cell.label3.text = @"无名称";
        [cell.yingBinImgV setImage:[UIImage imageNamed:@"图片占位"]];
        
    }else if (areaArr.count == 1){
        
        //图片1
        areaData = areaArr[0];
        if (areaData.AreaName.length > 0) {
            cell.bigLab.text = areaData.AreaName;
        }else{
            cell.bigLab.text = @"无名称";
        }
        if (areaData.ImageData.count > 0) {
            imgData = areaData.ImageData[0];
            [cell.zhuWuTaiImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        }else{
            [cell.zhuWuTaiImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        
        //图片2
        cell.label2.text = @"无名称";
        [cell.qianDaoImgV setImage:[UIImage imageNamed:@"图片占位"]];
        
        //图片3
        cell.label3.text = @"无名称";
        [cell.yingBinImgV setImage:[UIImage imageNamed:@"图片占位"]];
        
    }else if (areaArr.count == 0){
        
        //图片1
        cell.bigLab.text = @"无名称";
        [cell.zhuWuTaiImgV setImage:[UIImage imageNamed:@"图片占位"]];
        
        //图片2
        cell.label2.text = @"无名称";
        [cell.qianDaoImgV setImage:[UIImage imageNamed:@"图片占位"]];
        
        //图片3
        cell.label3.text = @"无名称";
        [cell.yingBinImgV setImage:[UIImage imageNamed:@"图片占位"]];
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
