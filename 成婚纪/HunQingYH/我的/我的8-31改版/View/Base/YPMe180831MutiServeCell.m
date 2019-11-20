//
//  YPMe180831MutiServeCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/31.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMe180831MutiServeCell.h"
#import "YPMe180831MutiServeColCell.h"

@implementation YPMe180831MutiServeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMe180831MutiServeCell";
    YPMe180831MutiServeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMe180831MutiServeCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setNameArr:(NSArray *)nameArr{
    _nameArr = nameArr;
    
    [self setupColView];
    
    [self.colView reloadData];
    
//    [self.colView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo((ScreenWidth-20*2)/3.0*(self.nameArr.count/3+1));
//    }];
//    
//    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo((ScreenWidth-20*2)/3.0*(self.nameArr.count/3.0));
//    }];
}

- (void)setupColView{
    
    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ScreenWidth-20*2)/3.0, (ScreenWidth-20*2)/3.0*0.75);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-40, (ScreenWidth-20*2)/3.0*0.75*(self.nameArr.count/3+1)) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = ClearColor;
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.backView);
        make.width.mas_equalTo(ScreenWidth-40);
        make.height.mas_equalTo((ScreenWidth-20*2)/3.0*0.75*(self.nameArr.count/3+1));
    }];
    
    [self.colView registerNib:[UINib nibWithNibName:@"YPMe180831MutiServeColCell" bundle:nil] forCellWithReuseIdentifier:@"YPMe180831MutiServeColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPMe180831MutiServeColCell *cell = (YPMe180831MutiServeColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPMe180831MutiServeColCell" forIndexPath:indexPath];
    
    NSDictionary *dict = self.nameArr[indexPath.item];
    [cell.iconImgV setImage:[UIImage imageNamed:dict[@"img"]]];
    cell.titleLabel.text = dict[@"name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPMe180831MutiServeColCell *cell = (YPMe180831MutiServeColCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
