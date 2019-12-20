//
//  YPCarTypeController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCarTypeController.h"
#import "ContactModel.h"
#import "YPCheckInCarController.h"//登记车辆
#import "YPAddCarTypeInfoController.h"//添加车型

@interface YPCarTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *selectCarType;
@property (nonatomic, copy) NSString *selectCarID;
@property (nonatomic, copy) NSString *selectCarColor;

@property(nonatomic,strong)NSIndexPath *lastPath;//上次选中的索引

@end

@implementation YPCarTypeController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetCarModelList];//获取车系
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
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.tableView];
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"自行添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(view);
        make.top.mas_equalTo(view).mas_offset(1);
    }];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    NSInteger row = [indexPath row];
    
    NSInteger oldRow = [_lastPath row];
    
    if (row == oldRow && _lastPath!=nil) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    ContactModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",model.Name,model.Color];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger newRow = [indexPath row];
    
    NSInteger oldRow = (self.lastPath !=nil)?[self.lastPath row]:-1;
    
    if (newRow != oldRow) {
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
        
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        self .lastPath = indexPath;
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactModel *model = self.dataArr[indexPath.row];
    self.selectCarType = model.Name;
    self.selectCarID = model.CarModelID;
    self.selectCarColor = model.Color;
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");

    if ([self.carTypeDelegate respondsToSelector:@selector(carType:andCarModelID:andCarColor:)]) {
        [self.carTypeDelegate carType:self.selectCarType andCarModelID:self.selectCarID andCarColor:self.selectCarColor];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)addBtnClick{
    NSLog(@"addBtnClick");
    
    YPAddCarTypeInfoController *addInfo = [[YPAddCarTypeInfoController alloc]init];
    addInfo.carBrand = self.titleStr;
    addInfo.carBrandID = self.carModelID;
    [self.navigationController pushViewController:addInfo animated:YES];
}

#pragma mark -------网络请求----------
#pragma mark 获取品牌/型号列表
-(void)GetCarModelList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetCarModelList";
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CarModelID"] = self.carModelID;//1获取品牌；品牌ID获取型号列表
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [self.dataArr removeAllObjects];
            
            self.dataArr = [ContactModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            
            if (self.dataArr.count > 0) {
                
                [self hidenEmptyView];
                
            }else{
                
//                [EasyShowTextView showSuccessText:@"当前没有数据!"];
                
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

#pragma mark - getter
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {

    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetCarModelList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
