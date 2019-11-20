//
//  YPReHomeYouHuiListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeYouHuiListController.h"
#import "YPGetWebDiscountList.h"
#import "YPReHomeWebViewController.h"

#define itemW ((ScreenWidth-10*3)*0.5)
#define itemH (itemW * 0.5)
#define cellID @"collectionCell"

@interface YPReHomeYouHuiListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

/**优惠信息模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWebDiscountList *> *discountMarr;

@end

@implementation YPReHomeYouHuiListController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetWebDiscountList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"优惠信息";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = bgColor;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, NAVIGATION_BAR_HEIGHT+10, ScreenWidth-20, ScreenHeight-NAVIGATION_BAR_HEIGHT-10) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = bgColor;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.discountMarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    YPGetWebDiscountList *list = self.discountMarr[indexPath.item];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    [imgV sd_setImageWithURL:[NSURL URLWithString:list.ImgUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [cell.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell.contentView);
    }];
    imgV.layer.cornerRadius = 5;
    imgV.clipsToBounds = YES;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetWebDiscountList *list = self.discountMarr[indexPath.item];
    if (list.DiscountURL.length > 0) {
        YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:list.DiscountURL]];//@"http://www.baidu.com"
        webVC.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前功能正在开发,敬请期待" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取优惠信息列表
- (void)GetWebDiscountList{
    
    NSString *url = @"/api/User/GetWebDiscountList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"1000";
    params[@"IsHeat"]   = @"0";//0不是热门 1是热门
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.discountMarr = [YPGetWebDiscountList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.collectionView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetWebDiscountList *> *)discountMarr{
    if (!_discountMarr) {
        _discountMarr = [NSMutableArray array];
    }
    return _discountMarr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
