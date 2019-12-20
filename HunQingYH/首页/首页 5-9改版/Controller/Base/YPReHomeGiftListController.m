//
//  YPReHomeGiftListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeGiftListController.h"
#import "YPActivityPrizesListData.h"
#import "HRYQPrisentCell.h"
#import "HRPresentXQViewController.h"

#define itemW ((ScreenWidth-1)*0.5)
#define itemH (itemW+70)
#define cellID @"HRYQPrisentCell"

@interface YPReHomeGiftListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

/**礼物模型*/
@property (nonatomic, strong) NSMutableArray<YPActivityPrizesListData *> *listMarr;

@end

@implementation YPReHomeGiftListController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self getPresetListRequest];
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
    titleLab.text = @"奖品列表";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    self.collectionView.showsVerticalScrollIndicator =NO;
    self.collectionView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[HRYQPrisentCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listMarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    YPActivityPrizesListData *data = self.listMarr[indexPath.item];
    
    HRYQPrisentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = WhiteColor;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.ShowImg] placeholderImage:[UIImage imageNamed:@"头"]];
    if (data.CommodityName.length > 0) {
        cell.nameLab.text = data.CommodityName;
    }else{
        cell.nameLab.text = @"无名称";
    }
    if (data.Country.length > 0) {
        cell.desLab.text = data.Country;
    }else{
        cell.desLab.text = @"无产地";
    }
    if (data.MarketPrice.length > 0) {
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",data.MarketPrice];
    }else{
        cell.priceLabel.text = @"¥0";
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YPActivityPrizesListData *data = self.listMarr[indexPath.row];
    
    NSLog(@"%zd,%zd",(long)indexPath.section, indexPath.item);
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = data.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 查看活动奖品列表
- (void)getPresetListRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityPrizesList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"10000000";

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"奖品列表%@",object);
            self.listMarr = [YPActivityPrizesListData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.collectionView reloadData];
            
            
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

#pragma mark - getter
- (NSMutableArray<YPActivityPrizesListData *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
