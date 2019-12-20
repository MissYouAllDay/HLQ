//
//  YPMyCarMemberController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarMemberController.h"
#import "YPMyCarMemberCell.h"
#import "HRCarNumSearchViewController.h"
#import "YPGetTeamInfoList.h"

@interface YPMyCarMemberController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetTeamInfoList *> *listMarr;

@end

@implementation YPMyCarMemberController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [self GetTeamInfoList:@""];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.placeholder = @"搜索姓名";
    self.searchBar.backgroundColor = CHJ_bgColor;
    self.searchBar.backgroundImage = [[UIImage alloc]init];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40-50-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), ScreenWidth, 50)];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"添加成员" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - target
- (void)sureBtnClick{
    NSLog(@"添加成员");
    
    HRCarNumSearchViewController *carMem = [[HRCarNumSearchViewController alloc]init];
    [self.navigationController pushViewController:carMem animated:YES];
}

- (void)moreBtnClick:(UIButton *)sender{
    
    YPGetTeamInfoList *info = self.listMarr[sender.tag - 1000];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",info.Phone]]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetTeamInfoList *info = self.listMarr[indexPath.row];
    
    YPMyCarMemberCell *cell = [YPMyCarMemberCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:info.Headportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.titleLabel.text = info.TrueName;
    cell.carName.text = info.Parent;
    
    cell.moreBtn.tag = indexPath.row + 1000;
    [cell.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetTeamInfoList *info = self.listMarr[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"是否开除 - %@",info.TrueName] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    sheet.tag = indexPath.row + 1000;
    [sheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSLog(@"确定");
        
        YPGetTeamInfoList *info = self.listMarr[actionSheet.tag - 1000];
        [self FiredAndAgreedTeamWithRelaID:info.RelaID AndSupplierID:FacilitatorId_New AndType:@"1"];//0同意、1开除、3拒绝
    }
}

#pragma mark - UISearchBarDelegate
//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBar.text  :  %@",searchBar.text);
    
    [self GetTeamInfoList:searchBar.text];
}

#pragma mark - 网络请求
#pragma mark 队长获取车队列表
- (void)GetTeamInfoList:(NSString *)searchStr{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetTeamInfoList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"TrueName"] = searchStr;//车手名 - 搜索使用
    params[@"Type"] = @"0";//0全部、1队长发起的邀请、2队员发起的申请
    params[@"ExamineStatus"] = @"2";//0全部、1未审核、2审核通过、3审核驳回
    params[@"ModelID"] = @"0";//注意: -
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetTeamInfoList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
                self.tableView.tableHeaderView = nil;
                
            }else{
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

#pragma mark 开除或同意车队成员
- (void)FiredAndAgreedTeamWithRelaID:(NSString *)relaID AndSupplierID:(NSString *)supplierID AndType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/FiredAndAgreedTeam";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RelaID"] = relaID;
    params[@"TeamType"] = type;//0同意、1开除、3拒绝
    params[@"RejectedWhy"] = @"";
    params[@"SupplierID"] = supplierID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
        
            [EasyShowTextView showSuccessText:@"开除成功!"];
            
            [self GetTeamInfoList:@""];
            
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
- (NSMutableArray<YPGetTeamInfoList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

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
