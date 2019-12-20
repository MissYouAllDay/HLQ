//
//  HRMyCollectionViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRMyCollectionViewController.h"
#import "FL_Button.h"
#import "UIParameter.h"
#import "NinaSelectionView.h"
#import "YPMyCollectionCell.h"
#import "YPCollectionList.h"
#import "HRZHiYeModel.h"
#import "HRHotelViewController.h"
#import "HRSearchCollectionViewController.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页

@interface HRMyCollectionViewController ()<NinaSelectionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_navView;
     FL_Button *SFBtn;
    UITableView *thisTableView;
     NSString *selectZhiYeName;
    NSString *shaixuanStr;
}
@property (nonatomic, copy) NSString *searchID;
@property (nonatomic, strong) NinaSelectionView *ninaSelectionView;
@property (nonatomic, strong) NSMutableArray<YPCollectionList *> *listMarr;
/**职业数组*/
@property(nonatomic,strong)NSMutableArray  *zhiYeArr;
/**身份数组*/
@property(nonatomic,strong)NSMutableArray  *shenFenArr;
@end

@implementation HRMyCollectionViewController
- (NSMutableArray<YPCollectionList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}
-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}
-(NSMutableArray *)shenFenArr{
    if (!_shenFenArr) {
        _shenFenArr = [[NSMutableArray alloc]initWithObjects:@"全部", nil];
    }
    return _shenFenArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchID=@"";
    shaixuanStr =@"全部";
    [self setupNav];
    [self getZhiYeList];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
    titleLab.text = @"我的收藏";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
    
    //设置导航栏右边搜索
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
        self.view.backgroundColor =CHJ_bgColor;
}

- (void)setupUI{


    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor =WhiteColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UIView *line1view = [[UIView alloc]init];
    line1view.backgroundColor =CHJ_bgColor;
    [topView addSubview:line1view];
    [line1view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView);
        make.left.mas_equalTo(topView);
        make.right.mas_equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    
    
    
    //导航栏地址选择按钮
    SFBtn = [FL_Button fl_shareButton];
    [SFBtn setBackgroundColor:[UIColor whiteColor]];
    [SFBtn setImage:[UIImage imageNamed:@"下拉_Red"] forState:UIControlStateNormal];
   
    [SFBtn setTitle:shaixuanStr forState:UIControlStateNormal];
   
    
    [SFBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [SFBtn addTarget:self action:@selector(sfBtnClick) forControlEvents:UIControlEventTouchUpInside];
    SFBtn.status = FLAlignmentStatusCenter;
    SFBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [topView addSubview:SFBtn];
    [SFBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(topView);
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIView *line2view = [[UIView alloc]init];
    line2view.backgroundColor =CHJ_bgColor;
    [topView addSubview:line2view];
    [line2view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView);
        make.left.mas_equalTo(topView);
        make.right.mas_equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.ninaSelectionView];
    
    //tableview
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
}
#pragma mark -------tableviewDatascource ----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.listMarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPCollectionList *list = self.listMarr[indexPath.row];
    
    YPMyCollectionCell *cell = [YPMyCollectionCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (list.CollectionTitle.length > 0) {
        cell.titleLabel.text = list.CollectionTitle;
    }else{
        cell.titleLabel.text = @"无";
    }
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.CollectionLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    return cell;

}
#pragma mark --------tableviewDelegate-------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YPCollectionList *model = self.listMarr[indexPath.row];
    
 
    for (HRZHiYeModel *zyModel in self.zhiYeArr) {
        if ([model.ProfessionID isEqualToString:zyModel.OccupationID]) {
            NSLog(@"%@  - %@",model.ProfessionID  ,zyModel.OccupationName);
            selectZhiYeName =zyModel.OccupationName;
        }
    }
    
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = model.TypeID;
    hotelVC.profession = model.ProfessionID;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick{
    HRSearchCollectionViewController *searchVC = [HRSearchCollectionViewController new];
     searchVC.zhiYeArr =self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(void)sfBtnClick{
     [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
}

#pragma mark - LazyLoad
- (NinaSelectionView *)ninaSelectionView {
    
    
    if (!_ninaSelectionView) {
        _ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:self.shenFenArr PopDirection:NinaPopFromBelowToTop];
        _ninaSelectionView.ninaSelectionDelegate = self;
        _ninaSelectionView.defaultSelected = 1;
        _ninaSelectionView.shadowEffect = YES;
        _ninaSelectionView.shadowAlpha = 0.5;
        _ninaSelectionView.y =NAVIGATION_BAR_HEIGHT+50;
//        _ninaSelectionView.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50);
    }
    return _ninaSelectionView;
}
#pragma mark - NinaSelectionDelegate
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Choose %li button",(long)button.tag);
    if ([button.titleLabel.text isEqualToString:@"全部"]) {
        self.searchID =@"";
        
    }else{
        
        for (HRZHiYeModel *zyModel in self.zhiYeArr) {
            if ([button.titleLabel.text isEqualToString:zyModel.OccupationName]) {
                self.searchID =zyModel.OccupationID;
                
            }
        }
    }
    
    shaixuanStr =button.titleLabel.text;
    [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.3];
    [self CollectionList];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取收藏列表

#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"2";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.zhiYeArr removeAllObjects];
            self.zhiYeArr =[HRZHiYeModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            for (HRZHiYeModel *model in self.zhiYeArr) {
                NSString *str = model.OccupationName;
                [self.shenFenArr addObject:str];
            }
            
            [self CollectionList];
            
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


- (void)CollectionList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CollectionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CollectorsType"] = @"0";//0用户、1公司
    params[@"CollectorsID"] = UserId_New;
    params[@"CollectionType"] = @"0";//0供应商、1方案、2宴会、3全部
    params[@"ProfessionID"] =self.searchID;
    params[@"CollectionTitle"] = @"";
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        NSLog(@"%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.listMarr removeAllObjects];
            self.listMarr = [YPCollectionList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self setupUI];
            [thisTableView reloadData];
            
            if (self.listMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                
                [self showNoDataEmptyView];

                
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        [self showNetErrorEmptyView];
        
    }];
    
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:thisTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
       
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:thisTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getZhiYeList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
