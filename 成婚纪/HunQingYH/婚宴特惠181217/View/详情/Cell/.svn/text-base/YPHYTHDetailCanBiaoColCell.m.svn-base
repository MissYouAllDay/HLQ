//
//  YPHYTHDetailCanBiaoColCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailCanBiaoColCell.h"
#import "YPHYTHDetailCanBiaoCollectCell.h"

@implementation YPHYTHDetailCanBiaoColCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailCanBiaoColCell";
    YPHYTHDetailCanBiaoColCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailCanBiaoColCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListArr:(NSArray<YPGetPreferentialCommodityPriceList *> *)listArr{
    _listArr = listArr;

    [self setupColView];

    [self.colView reloadData];
}

- (void)setupColView{
    
    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(140, 100);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth-10, 100) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = [UIColor clearColor];
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.backView).mas_offset(2);
        make.bottom.right.mas_equalTo(self.backView).mas_offset(-2);
    }];
    
    [self.colView registerNib:[UINib nibWithNibName:@"YPHYTHDetailCanBiaoCollectCell" bundle:nil] forCellWithReuseIdentifier:@"YPHYTHDetailCanBiaoCollectCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHYTHDetailCanBiaoCollectCell *cell = (YPHYTHDetailCanBiaoCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPHYTHDetailCanBiaoCollectCell" forIndexPath:indexPath];
    
    YPGetPreferentialCommodityPriceList *list = self.listArr[indexPath.item];
    if (list.Name.length > 0) {
        cell.titleLabel.text = list.Name;
    }else{
        cell.titleLabel.text = @"无名称";
    }
    cell.priceLabel.text = [NSString stringWithFormat:@"%.1f",[list.Price floatValue]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHYTHDetailCanBiaoCollectCell *cell = (YPHYTHDetailCanBiaoCollectCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
