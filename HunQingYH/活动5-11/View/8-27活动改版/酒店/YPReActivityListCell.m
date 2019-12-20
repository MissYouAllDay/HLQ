//
//  YPReActivityListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityListCell.h"
#import "YPReActivityListColCell.h"

@implementation YPReActivityListCell{
    UILabel *_label;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReActivityListCell";
    YPReActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReActivityListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setDataArr:(NSArray<YPGetFacilitatorActivityCoverMapListData *> *)dataArr{
    _dataArr = dataArr;
    
    [self setupUI];
    [self setupColView];
    
    [self.goodsView reloadData];
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 10;
    _backView.clipsToBounds = YES;
}

- (void)setupUI{
    
    if (!self.iconImgV) {
        self.iconImgV = [[UIImageView alloc]init];
    }
    self.iconImgV.layer.cornerRadius = 3;
    self.iconImgV.clipsToBounds = YES;
    [self.backView addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(49, 49));
    }];
    
    if (!self.titleBtn) {
        self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.titleBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
    self.titleBtn.titleLabel.numberOfLines = 2;
    self.titleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImgV);
        make.left.mas_equalTo(self.iconImgV.mas_right).mas_offset(12);
        make.top.bottom.mas_equalTo(self.iconImgV);
    }];
    
    if (!self.allBtn) {
        self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.allBtn setTitle:@"查看全部 >" forState:UIControlStateNormal];
    [self.allBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
    self.allBtn.titleLabel.font = kFont(12);
    [self.backView addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.titleBtn);
        make.width.mas_equalTo(70);
        make.left.mas_greaterThanOrEqualTo(self.titleBtn.mas_right).mas_offset(10);
    }];
    
}

- (void)setupColView{
    
    if (!self.goodsView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ScreenWidth*0.85, ScreenWidth*0.85*0.66);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.goodsView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImgV.frame), ScreenWidth-20-18, ScreenWidth*0.85*0.66) collectionViewLayout:layout];
    }
    self.goodsView.delegate = self;
    self.goodsView.dataSource = self;
    self.goodsView.backgroundColor = ClearColor;
    self.goodsView.showsHorizontalScrollIndicator = NO;
    self.goodsView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.goodsView];
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.descLabel.mas_bottom).mas_offset(5);
        make.top.mas_equalTo(self.iconImgV.mas_bottom);
        make.left.mas_equalTo(self.iconImgV);
        make.right.mas_equalTo(self.backView);
        make.height.mas_equalTo(ScreenWidth*0.85*0.66+20);
    }];
    
    [self.goodsView registerNib:[UINib nibWithNibName:@"YPReActivityListColCell" bundle:nil] forCellWithReuseIdentifier:@"YPReActivityListColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count == 0 ? 1 : self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPReActivityListColCell *cell = (YPReActivityListColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPReActivityListColCell" forIndexPath:indexPath];
    
    if (self.dataArr.count > 0) {
        
        [_label removeFromSuperview];
        
        cell.hidden = NO;
        
        YPGetFacilitatorActivityCoverMapListData *data = self.dataArr[indexPath.item];
        
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:data.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        

    }else if (self.dataArr.count == 0) {
        
        cell.hidden = YES;
        
        if (!_label) {
            _label = [[UILabel alloc]init];
        }
        _label.text = @"暂时没有折扣, 请查看其它";
        [collectionView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(collectionView);
        }];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.colCellClick(self.titleBtn.titleLabel.text, indexPath);
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
