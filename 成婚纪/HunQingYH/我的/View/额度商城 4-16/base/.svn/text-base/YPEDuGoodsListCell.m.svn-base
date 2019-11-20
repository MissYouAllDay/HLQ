//
//  YPEDuGoodsListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuGoodsListCell.h"
#import "YPEDuGoodColCell.h"

@implementation YPEDuGoodsListCell{
    UILabel *_label;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEDuGoodsListCell";
    YPEDuGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEDuGoodsListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setColorArr:(NSArray *)colorArr{
    _colorArr = colorArr;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, ScreenWidth-10, CGRectGetHeight(_backView.frame));
    gradient.colors = _colorArr;
    [_backView.layer addSublayer:gradient];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth-10, CGRectGetHeight(_backView.frame)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10,10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _backView.bounds;
    maskLayer.path = maskPath.CGPath;
    _backView.layer.masksToBounds = YES;
    _backView.layer.mask = maskLayer;
    
    [self setupUI];
}

- (void)setListModel:(YPGetCommodityTypeTableList *)listModel{
    _listModel = listModel;

    if (_listModel.TypeName.length > 0) {
        self.titleLabel.text = _listModel.TypeName;
    }else{
        self.titleLabel.text = @"无名称";
    }
    if (_listModel.Introduction.length > 0) {
        self.descLabel.text = _listModel.Introduction;
    }else{
        self.descLabel.text = @"无描述";
    }
}

- (void)setDataArr:(NSArray<YPGetCommodityTypeTableListData *> *)dataArr{
    _dataArr = dataArr;
    
    [self setupColView];
}

- (void)setupUI{
    
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc]init];
    }
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textColor = WhiteColor;
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(15);
    }];

//    if (!self.descLabel) {
//        self.descLabel = [[UILabel alloc]init];
//    }
//    self.descLabel.font = [UIFont systemFontOfSize:15];
//    self.descLabel.textColor = WhiteColor;
//    [self.backView addSubview:self.descLabel];
//    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
//        make.left.mas_equalTo(self.titleLabel);
//    }];

    if (!self.allBtn) {
        self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.allBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.backView addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    
}

- (void)setupColView{
    
    if (!self.goodsView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(120, 170);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.goodsView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 55, ScreenWidth-10-15, 170) collectionViewLayout:layout];
    }
    self.goodsView.delegate = self;
    self.goodsView.dataSource = self;
    self.goodsView.backgroundColor = ClearColor;
    self.goodsView.showsHorizontalScrollIndicator = NO;
    self.goodsView.showsVerticalScrollIndicator = NO;
    [self.backView addSubview:self.goodsView];
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.descLabel.mas_bottom).mas_offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(170);
    }];
    
    [self.goodsView registerNib:[UINib nibWithNibName:@"YPEDuGoodColCell" bundle:nil] forCellWithReuseIdentifier:@"YPEDuGoodColCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count == 0 ? 1 : self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPEDuGoodColCell *cell = (YPEDuGoodColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPEDuGoodColCell" forIndexPath:indexPath];

    if (self.dataArr.count > 0) {
        
        [_label removeFromSuperview];
        
        cell.hidden = NO;
        
        YPGetCommodityTypeTableListData *dataModel = self.dataArr[indexPath.item];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:dataModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.titleLabel.text = dataModel.CommodityName;
        cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",dataModel.Quota];
        
    }else if (self.dataArr.count == 0) {
        
        cell.hidden = YES;
        
        if (!_label) {
            _label = [[UILabel alloc]init];
        }
        _label.text = @"暂时没有礼品, 请查看其它礼品";
        [collectionView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(collectionView);
        }];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.colCellClick(self.titleLabel.text, indexPath);
}

//- (void)setBackView:(UIView *)backView{
//    _backView = backView;
//
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0, 0, ScreenWidth-10, CGRectGetHeight(_backView.frame));
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)RGB(67, 196, 254).CGColor,
//                       (id)RGB(126, 214, 252).CGColor,
//                       (id)[UIColor whiteColor].CGColor, nil];
//    [_backView.layer addSublayer:gradient];
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth-10, CGRectGetHeight(_backView.frame)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10,10)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = _backView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    _backView.layer.masksToBounds = YES;
//    _backView.layer.mask = maskLayer;
//
//    [self setupUI];
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
