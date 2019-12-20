//
//  YPMyCarCheXingController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarCheXingController.h"
#import "YPMyCarCheXingListCell.h"
#import "YPMyCarCheXingDetailController.h"
#import "YPGetSupperTeamInfo.h"

@interface YPMyCarCheXingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetSupperTeamInfo *> *listMarr;

@end

@implementation YPMyCarCheXingController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [self GetSupperTeamInfo];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), ScreenWidth, 50)];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];

//    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sureBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
//    [sureBtn setTitle:@"添加车型" forState:UIControlStateNormal];
//    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:sureBtn];
//    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(view);
//    }];
//    
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = CHJ_bgColor;
//    [view addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(view);
//        make.height.mas_equalTo(1);
//    }];
    
}

//#pragma mark - target
//- (void)sureBtnClick{
//    NSLog(@"添加车型");
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetSupperTeamInfo *info = self.listMarr[indexPath.row];
    
    YPMyCarCheXingListCell *cell = [YPMyCarCheXingListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:info.Img] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if (info.Parent.length > 0) {
        cell.titleLabel.text = info.Parent;
    }else{
        cell.titleLabel.text = @"无车型";
    }
    cell.numLabel.text = info.NumBer;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetSupperTeamInfo *info = self.listMarr[indexPath.row];

    YPMyCarCheXingDetailController *detail = [[YPMyCarCheXingDetailController alloc]init];
    detail.teamInfo = info;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 网络请求
#pragma mark 用户获取供应商车队列表
- (void)GetSupperTeamInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSupperTeamInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetSupperTeamInfo mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
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

#pragma mark - getter
- (NSMutableArray<YPGetSupperTeamInfo *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
      
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetSupperTeamInfo];
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
