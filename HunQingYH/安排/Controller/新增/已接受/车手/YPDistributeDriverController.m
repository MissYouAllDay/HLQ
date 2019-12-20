//
//  YPDistributeDriverController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDistributeDriverController.h"
#import "YPDriverSelectCell.h"
#import "YPGetDriverListBySupplierID.h"
//#import "YPANAAcceptDetailController.h"
#import "YPDistributeCarBrandController.h"

@interface YPDistributeDriverController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger selectCount;//选中人数

//@property (nonatomic, strong) NSMutableArray *selectMarr;//选中数组

@property (nonatomic, strong) NSMutableArray<YPGetDriverListBySupplierID *> *listMarr;

@property (nonatomic, copy) NSString *driverIDs;;

@end

@implementation YPDistributeDriverController{
    UIView      *_navView;

    //避免重复创建
    UIView      *_top;
    UILabel     *time;
    UILabel     *type;
    UIView      *view;
    UIImageView *icon;
    UILabel     *label;
    UIButton    *doneBtn;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    [self setupTableView];
    
    [self GetDriverListBySupplierID];
    
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
    titleLab.text = @"分配车手";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    //设置导航栏右边
//    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:searchBtn];
//    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
//    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!_top) {
        _top = [[UIView alloc]init];
    }
    _top.backgroundColor = WhiteColor;
    [self.view addSubview:_top];
    [_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    if (!time) {
        time = [[UILabel alloc]init];
    }
    time.text = self.weddingTime;
    time.textColor = GrayColor;
    [_top addSubview:time];
    
    if (!type) {
        type = [[UILabel alloc]init];
    }
    type.text = @"他们都有空";
    type.textColor = GrayColor;
    [_top addSubview:type];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(_top);
    }];
    
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(time.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(time);
    }];

    if (!view) {
        view = [[UIView alloc]init];
    }
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    if (!icon) {
        icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"已选人"]];
    }
    [view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
//    self.selectCount = 0;

    if (!label) {
        label = [[UILabel alloc]init];
    }
    label.text = [NSString stringWithFormat:@"已选%zd人",self.selectCount];
    label.font = kNormalFont;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(icon);
    }];
    
    if (!doneBtn) {
        doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:NavBarColor];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(view);
        make.width.mas_equalTo(125);
    }];
    
}

- (void)setupTableView{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+41, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-41-50) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.listMarr.count;

//    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetDriverListBySupplierID *model = self.listMarr[indexPath.row];
    
    YPDriverSelectCell *cell = [YPDriverSelectCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.DriverImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.titleLabel.text = model.DriverName;
    cell.phone.text = model.DriverPhone;
    
    if (model.IsSelected == 1) {//1.选中 0/2.未选中
        cell.selectBtn.selected = YES;
    }else {//1.选中 2.未选中
        cell.selectBtn.selected = NO;
    }
    
    cell.selectBtn.tag = indexPath.row + 1000;
    cell.phoneBtn.tag = indexPath.row + 2000;
    [cell.selectBtn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)searchBtnClick{
//    NSLog(@"searchBtnClick");
//    
//    
//}

- (void)buttonSelect:(UIButton *)sender{
    
    YPGetDriverListBySupplierID *model = self.listMarr[sender.tag - 1000];
    
    if (model.IsSelected == 1) {//1.选中 0/2.未选中
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < self.listMarr.count; i ++) {
            if (i == sender.tag - 1000) {
                model.IsSelected = 2;
                [marr addObject:model];
            }else{
                [marr addObject:self.listMarr[i]];
            }

        }
        
        if (self.selectCount > 0) {
            self.selectCount --;
        }else{
            self.selectCount = 0;
        }
        
        self.listMarr = marr;

    }else {//1.选中 2.未选中
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < self.listMarr.count; i ++) {
            if (i == sender.tag - 1000) {
                model.IsSelected = 1;
                [marr addObject:model];
            }else{
                [marr addObject:self.listMarr[i]];
            }
        }
        
        self.selectCount ++;
        
        self.listMarr = marr;

    }
    
    [self setupUI];
    [self.tableView reloadData];
    
//    for (YPGetDriverListBySupplierID *list in self.listMarr) {
//        if (list.IsSelected == 1) {//1.选中 0/2.未选中
//            self.selectCount ++;
//        }
//    }

}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick -- %@ ",self.listMarr);
    
    for (YPGetDriverListBySupplierID *model in self.listMarr) {
        if (model.IsSelected == 1) {//1.选中 2.未选中
            NSMutableArray *marr = [NSMutableArray array];
            [marr addObject:model.DriverID];
            self.driverIDs = [marr componentsJoinedByString:@","];
        }
    }
    
    [self AssignmentDriverSupplierOrder];
}

- (void)phoneBtnClick:(UIButton *)sender{
    
    YPGetDriverListBySupplierID *model = self.listMarr[sender.tag - 2000];

    NSLog(@"phoneBtn %@",model.DriverPhone);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",model.DriverPhone]]];
}

#pragma mark - 网络请求
#pragma mark 队长根据车型获取车手列表
- (void)GetDriverListBySupplierID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetDriverListBySupplierID";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"CarID"] = self.carID;
    if (self.weddingTime.length > 0) {
        params[@"DriverTime"] = self.weddingTime;//日期为空查所有 婚期
    }else{
        params[@"DriverTime"] = @"";//日期为空查所有 婚期
    }
    
    params[@"PhoneOrName"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetDriverListBySupplierID mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
            }
            
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

#pragma mark 队长分配档期给车手
- (void)AssignmentDriverSupplierOrder{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AssignmentDriverSupplierOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierOrderID"] = self.supplierOrderID;
    if (self.driverIDs.length > 0) {
        params[@"DriverID"] = self.driverIDs;
    }else{
        params[@"DriverID"] = @"";
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"分配成功!"];
            
            UIViewController *mineVC = nil;
            for (UIViewController * controller in self.navigationController.viewControllers) {
                //遍历
                if([controller isKindOfClass:[YPDistributeCarBrandController class]]){
                    //这里判断是否为你想要跳转的页面
                    mineVC = controller;
                    break;
                }
            }
            [self.navigationController popToViewController:mineVC  animated:YES];
            
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

- (UIViewController *)getviewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - getter
- (NSMutableArray<YPGetDriverListBySupplierID *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

//- (NSString *)driverIDs{
//    if (!_driverIDs) {
//        _driverIDs = [[NSMutableString alloc]init];
//    }
//    return _driverIDs;
//}

//#pragma mark - 缺省
//-(void)showNoDataEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        <#way#>
//    }];
//
//}
//-(void)showNetErrorEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        <#way#>
//    }];
//
//}
//-(void)hidenEmptyView{
//    [ EasyShowEmptyView hiddenEmptyView:self.view];
//}

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
