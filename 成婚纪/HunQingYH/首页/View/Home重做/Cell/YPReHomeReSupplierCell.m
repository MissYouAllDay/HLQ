
//
//  YPReHomeReSupplierCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeReSupplierCell.h"
#import "YPReHomeSupplierColCell.h"

static NSInteger colCellH = 190;
static NSInteger colMargin = 10;
//static NSInteger colCellW = (ScreenWidth-colMargin*3)*0.5;

@implementation YPReHomeReSupplierCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeReSupplierCell";
    YPReHomeReSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeReSupplierCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

//- (void)setGysMarr:(NSMutableArray<HRGYSModel *> *)gysMarr{
//    _gysMarr = gysMarr;
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake((ScreenWidth-colMargin*3)*0.5, colCellH);
//    layout.minimumInteritemSpacing = colMargin;
//    layout.minimumLineSpacing = colMargin;
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//
//    if (_gysMarr.count <= 6) {
//
//        //            colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*3) collectionViewLayout:layout];
//
//        if (_gysMarr.count == 0) {
//
//            [_colView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(30);
//            }];
//
//        }else if (_gysMarr.count <= 2) {
//
//            [_colView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(colCellH*1+colMargin*1);
//            }];
//        }else if (_gysMarr.count <= 4){
//            [_colView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(colCellH*2+colMargin*2);
//            }];
//        }else if (_gysMarr.count <= 6){
//            [_colView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(colCellH*3+colMargin*3);
//            }];
//        }
//
//    }else{
//
//        [_colView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(colCellH*3+colMargin*3);
//        }];
//
//    }
//
//}

- (void)setColView:(UICollectionView *)colView{
    _colView = colView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
//    if (self.gysMarr.count == 0) {
//
//        layout.itemSize = CGSizeMake(ScreenWidth-colMargin*2, 30);
//    }else{
    
        layout.itemSize = CGSizeMake((ScreenWidth-colMargin*3)*0.5, colCellH);
//    }
    
    layout.minimumInteritemSpacing = colMargin;
    layout.minimumLineSpacing = colMargin;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    if (!colView) {

        if (self.gysMarr.count <= 6) {
            
            if (self.gysMarr.count == 0) {
                colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, 0, ScreenWidth-colMargin*2, 30) collectionViewLayout:layout];
            }else if (self.gysMarr.count <= 2) {
                colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*1+colMargin*1) collectionViewLayout:layout];
            }else if (self.gysMarr.count <= 4){
                colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*2+colMargin*2) collectionViewLayout:layout];
            }else if (self.gysMarr.count <= 6){
                colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*3) collectionViewLayout:layout];
            }
            
        }else{
            
            colView = [[UICollectionView alloc]initWithFrame:CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*3) collectionViewLayout:layout];
            
        }
    }
    
    _colView.collectionViewLayout = layout;
    
    _colView.delegate = self;
    _colView.dataSource = self;
    _colView.scrollsToTop = NO;
    _colView.showsVerticalScrollIndicator = NO;
    _colView.showsHorizontalScrollIndicator = NO;
    
    if (_gysMarr.count <= 6) {

        if (_gysMarr.count == 0) {

            _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, 30);

        }else if (_gysMarr.count <= 2) {

            _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*1+colMargin*1);

        }else if (_gysMarr.count <= 4){

            _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*2+colMargin*2);

        }else if (_gysMarr.count <= 6){

            _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*3);

        }

    }else{

        _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*3);

    }
    
//    _colView.frame = CGRectMake(colMargin, colMargin, ScreenWidth-colMargin*2, colCellH*3+colMargin*2);
    
    [_colView registerNib:[UINib nibWithNibName:@"YPReHomeSupplierColCell" bundle:nil] forCellWithReuseIdentifier:@"YPReHomeSupplierColCell"];
//    [_colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.gysMarr.count < 6) {
//        if (self.gysMarr.count == 0) {
//            return 1;
//        }else{
            return self.gysMarr.count;
//        }
    }else{
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

//    if (self.gysMarr.count == 0) {
//
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"当前无供应商";
//        [cell.contentView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(cell.contentView);
//        }];
//        return cell;
//
//    }else{
    
        YPGetFacilitatorList *gysmodel = self.gysMarr[indexPath.item];
        
        YPReHomeSupplierColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPReHomeSupplierColCell" forIndexPath:indexPath];

        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:gysmodel.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];

        if (gysmodel.Name.length > 0){
            cell.titleLabel.text = gysmodel.Name;
        }else{
            cell.titleLabel.text = @"当前无名称";
        }
//        if (gysmodel.CaseCount.length > 0){
            cell.anliCount.text = gysmodel.AnliCount;
//        }
//        if (gysmodel.StateCount.length > 0){
            cell.zhuangtaiCount.text = gysmodel.StateCount;
//        }
    
        //18-08-10 一直显示-窦
        cell.danbaoImgV.hidden = NO;
        cell.giftImgV.hidden = NO;
    
        return cell;
//    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collection -- %zd",indexPath.item);
    
    if ([self.supplierDelegate respondsToSelector:@selector(supplierClickColRow:)]) {
        [self.supplierDelegate supplierClickColRow:indexPath.item];
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
