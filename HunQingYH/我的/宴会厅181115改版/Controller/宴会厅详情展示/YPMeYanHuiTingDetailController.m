//
//  YPMeYanHuiTingDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeYanHuiTingDetailController.h"
#import "ImageEnlargeCell.h"
#import "YPGetHotelBanquetlInfo.h"
#import "YPMeYanHuiTingDetailInfoView.h"

@interface YPMeYanHuiTingDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *mImages;//图片
// 显示图片的视图
@property (nonatomic,strong) UIImageView *imageView ;

// 显示缩放视图
@property (nonatomic,strong) UICollectionView *collectionView ;
@property (nonatomic, strong) YPGetHotelBanquetlInfo *infoModel;

@end

@implementation YPMeYanHuiTingDetailController{
    UIView *navView;
    
    UIButton *_backBtn;
    UILabel *_countLabel;
    YPMeYanHuiTingDetailInfoView *_infoView;
    
    UIView *environmentPhotoView;
    
    NSInteger selectIndex;//选中的图片
}

#pragma mark - getter
- (NSMutableArray *)mImages{
    if (!_mImages) {
        _mImages = [NSMutableArray array];
        
    }
    return _mImages;
}

- (YPGetHotelBanquetlInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetHotelBanquetlInfo alloc]init];
    }
    return _infoModel;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BlackColor;
    [self GetHotelBanquetlInfo];
    
}
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = ClearColor;
    [self.view addSubview:navView];
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    _backBtn.layer.cornerRadius = 16;
    _backBtn.clipsToBounds = YES;
    _backBtn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
    }
    _countLabel.text = [NSString stringWithFormat:@"%ld/%zd",selectIndex+1,self.imageUrlArrays.count];
    _countLabel.textColor = WhiteColor;
    _countLabel.backgroundColor = RGBA(0, 0, 0, 0.4);
    _countLabel.layer.cornerRadius = 16;
    _countLabel.clipsToBounds = YES;
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backBtn);
        make.height.mas_equalTo(32);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(88);
    }];
}

#pragma mark - Show Big Picture
- (void)createWindowForBigPicture
{
    self.imageUrlArrays = _mImages;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    flowLayout.minimumInteritemSpacing = 0 ;
    flowLayout.minimumLineSpacing = 0;
    
    // 设置方法
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout] ;
    self.collectionView.backgroundColor = BlackColor;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.pagingEnabled = YES ;
    self.collectionView.contentOffset = CGPointMake(([UIScreen mainScreen].bounds.size.width)*selectIndex, [UIScreen mainScreen].bounds.size.height);
    self.collectionView.showsHorizontalScrollIndicator = NO ;
    [self.collectionView registerClass:[ImageEnlargeCell class] forCellWithReuseIdentifier:@"cellID"] ;
    [self.view addSubview:self.collectionView] ;
    
    
    // 创建下面页数显示的文本
    if (!_infoView) {
        _infoView = [YPMeYanHuiTingDetailInfoView yp_MeYanHuiTingDetailInfoView];
    }
    if (self.infoModel.BanquetHallName.length > 0) {
        _infoView.tingName.text = self.infoModel.BanquetHallName;
    }else{
        _infoView.tingName.text = @"无名称";
    }
    _infoView.mianji.text = [NSString stringWithFormat:@"%.2f㎡",self.infoModel.Acreage.floatValue];
    _infoView.cenggao.text = [NSString stringWithFormat:@"%.2fm",self.infoModel.Height.floatValue];
    _infoView.whLabel.text = [NSString stringWithFormat:@"%.2fm·%.2fm",self.infoModel.Length.floatValue,self.infoModel.Width.floatValue];
    _infoView.tableCount.text = [NSString stringWithFormat:@"%zd~%zd桌",self.infoModel.MinTableCount.integerValue,self.infoModel.MaxTableCount.integerValue];
    [_infoView.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.HotelLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    if (self.infoModel.HotelName.length > 0) {
        _infoView.titleLabel.text = self.infoModel.HotelName;
    }else{
        _infoView.titleLabel.text = @"无名称";
    }
    
    [self.view addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(175);
    }];
    
    [self createNav];
    
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionView  delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return self.imageUrlArrays.count;
    }
    NSLog(@"%lu",(unsigned long)_mImages.count);
    return _mImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        static NSString *cellID = @"cellID" ;
        ImageEnlargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath] ;
        cell.contentView.backgroundColor = BlackColor;
        // 传数据
        cell.imageUrlString = self.imageUrlArrays[indexPath.row] ;
        // 刷新视图
        [cell setNeedsLayout] ;
        return cell ;
    }
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if (_mImages.count > 0) {
        UIImageView *mImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        mImageView.backgroundColor = [UIColor clearColor];
        mImageView.contentMode = UIViewContentModeScaleToFill;
        [mImageView sd_setImageWithURL:[NSURL URLWithString:_mImages[indexPath.row]]];
        [cell.contentView addSubview:mImageView];
    }
    
    
    return cell;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout
//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        return CGSizeMake(ScreenWidth, ScreenHeight);
    }
    return CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-30)/2);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    [self createWindowForBigPicture];
}
#pragma mark - UICollectionView 继承父类的方法------------------------------------
// 减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"停止减速，滑动视图停止了");
    
    // 视图停止滑动的时候执行一些操作
    int pageIndex = (int)self.collectionView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width);
    _countLabel.text = [NSString stringWithFormat:@"%d/%lu",pageIndex+1,(unsigned long)self.imageUrlArrays.count];
//    NSLog(@"====%f====%f====%d",self.collectionView.contentOffset.x,[UIScreen mainScreen].bounds.size.width ,pageIndex);
    
}

#pragma mark 根据宴会厅id获取宴会厅详情
- (void)GetHotelBanquetlInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelBanquetlInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.BanquetID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.BanquetID = [object objectForKey:@"BanquetID"];
            self.infoModel.BanquetHallName = [object objectForKey:@"BanquetHallName"];
            self.infoModel.FloorPrice = [object objectForKey:@"FloorPrice"];
            self.infoModel.MaxTableCount = [object objectForKey:@"MaxTableCount"];
            self.infoModel.HotelLogo = [object objectForKey:@"HotelLogo"];
            self.infoModel.FacilitatorId = [object objectForKey:@"FacilitatorId"];
            
            //18-11-19
            self.infoModel.Data = [YPGetFacilitatorInfoImgData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            self.infoModel.MinTableCount = [object objectForKey:@"MinTableCount"];
            self.infoModel.Acreage = [object objectForKey:@"Acreage"];
            self.infoModel.Length = [object objectForKey:@"Length"];
            self.infoModel.Width = [object objectForKey:@"Width"];
            self.infoModel.Height = [object objectForKey:@"Height"];
            self.infoModel.TypeContent = [object objectForKey:@"TypeContent"];
            self.infoModel.HotelName = [object objectForKey:@"HotelName"];
            
            for (YPGetFacilitatorInfoImgData *img in self.infoModel.Data) {
                [self.mImages addObject:img.ImgUrl];
            }
            
            [self createWindowForBigPicture];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
