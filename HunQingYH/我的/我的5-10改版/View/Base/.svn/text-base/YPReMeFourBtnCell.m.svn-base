//
//  YPReMeFourBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeFourBtnCell.h"
#import "YPReMeFourBtnColCell.h"

@implementation YPReMeFourBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMeFourBtnCell";
    YPReMeFourBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMeFourBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setNameArr:(NSArray *)nameArr{
    _nameArr = nameArr;
    
    [self setupColView];
    
    [self.colView reloadData];
}

- (void)setupColView{

    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ScreenWidth-(self.nameArr.count-1))/self.nameArr.count, 80);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = ClearColor;
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-1);
    }];
    
    [self.colView registerNib:[UINib nibWithNibName:@"YPReMeFourBtnColCell" bundle:nil] forCellWithReuseIdentifier:@"YPReMeFourBtnColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPReMeFourBtnColCell *cell = (YPReMeFourBtnColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPReMeFourBtnColCell" forIndexPath:indexPath];
    
    NSDictionary *dict = self.nameArr[indexPath.item];
    [cell.iconImgV setImage:[UIImage imageNamed:dict[@"img"]]];
    cell.titleLabel.text = dict[@"name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPReMeFourBtnColCell *cell = (YPReMeFourBtnColCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
