//
//  YPInviteFriendsWedNormalThreeBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedNormalThreeBtnCell.h"
#import "YPReMeFourBtnColCell.h"

@implementation YPInviteFriendsWedNormalThreeBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPInviteFriendsWedNormalThreeBtnCell";
    YPInviteFriendsWedNormalThreeBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPInviteFriendsWedNormalThreeBtnCell" owner:nil options:nil] lastObject];
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
        layout.itemSize = CGSizeMake((ScreenWidth-18*2)/self.nameArr.count, 80);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth-36, 90) collectionViewLayout:layout];
    }
    self.colView.delegate = self;
    self.colView.dataSource = self;
    self.colView.backgroundColor = ClearColor;
    self.colView.showsHorizontalScrollIndicator = NO;
    self.colView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.backView);
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
