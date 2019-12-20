//
//  HRHotelTingXQViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelTingXQViewController.h"
#import "ImageEnlargeCell.h"
#import "YPGetHotelBanquetlInfo.h"

@interface HRHotelTingXQViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UIView *navView;
    UIView *environmentPhotoView;
    UICollectionView *colView;
    
    NSInteger selectIndex;//选中的图片
    UIWindow *mWindow;
}


@property(nonatomic,strong) NSMutableArray *mImages;//图片
// 显示图片的视图
@property (nonatomic,strong) UIImageView *imageView ;

// 显示缩放视图
@property (nonatomic,strong) UICollectionView *collectionView ;
@property (nonatomic, strong) YPGetHotelBanquetlInfo *infoModel;

@end

@implementation HRHotelTingXQViewController

-(NSMutableArray *)mImages{
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

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor =CHJ_bgColor;
    [self createNav];
    [self GetHotelBanquetlInfo];
 
}
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }]; 
}
-(void)createCollectView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    colView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) collectionViewLayout:layout];
    [colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    colView.backgroundColor = [UIColor clearColor];
    colView.delegate = self;
    colView.dataSource = self;
    [self.view addSubview:colView];
}

/***
 ***
 UICollectionView  delegate
 ***
 ***
 */
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
        cell.contentView.backgroundColor =CHJ_bgColor;
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
    int pageIndex = (int)self.collectionView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    self.label.text = [NSString stringWithFormat:@"%d/%lu",pageIndex+1,(unsigned long)self.imageUrlArrays.count] ;
    NSLog(@"====%f====%f====%d",self.collectionView.contentOffset.x,[UIScreen mainScreen].bounds.size.width ,pageIndex);
    
}
#pragma mark - Show Big Picture
- (void)createWindowForBigPicture
{
    self.imageUrlArrays = _mImages;
    mWindow = [UIApplication sharedApplication].keyWindow;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    flowLayout.minimumInteritemSpacing = 0 ;
    flowLayout.minimumLineSpacing = 0;
    
    // 设置方法
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout] ;
    self.collectionView.backgroundColor = CHJ_bgColor ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.pagingEnabled = YES ;
    self.collectionView.contentOffset = CGPointMake(([UIScreen mainScreen].bounds.size.width)*selectIndex, [UIScreen mainScreen].bounds.size.height);
    self.collectionView.showsHorizontalScrollIndicator = NO ;
    [self.collectionView registerClass:[ImageEnlargeCell class] forCellWithReuseIdentifier:@"cellID"] ;
    [mWindow addSubview:self.collectionView] ;
    
    
    // 创建下面页数显示的文本
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width-200, 20)] ;
    self.label.textAlignment = NSTextAlignmentCenter ;
    self.label.textColor = [UIColor blackColor] ;
    self.label.text = [NSString stringWithFormat:@"%ld/%lu",selectIndex+1,(unsigned long)self.imageUrlArrays.count] ;
    [mWindow addSubview:self.label] ;

    // 自定义返回按键button
    UIImage *image = [UIImage imageNamed:@"back_red"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = CGRectMake(10, NAVIGATION_BAR_HEIGHT-40, 40, 30) ;
    [button setImage:image forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside] ;
    [mWindow addSubview:button] ;
    
}
#pragma mark button等视图的点击事件-------------------------------------
- (void)returnButtonAction:(UIButton *)sender
{
    [self.collectionView removeFromSuperview];
    [self.label removeFromSuperview];
    [sender removeFromSuperview];
}

#pragma mark --------target-------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
  
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            for (YPGetFacilitatorInfoImgData *img in self.infoModel.Data) {
                [self.mImages addObject:img.ImgUrl];
            }
            
            [self createCollectView];
            
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



@end
