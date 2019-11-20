//
//  HRCarNumSearchViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRCarNumSearchViewController.h"
#import "HRSearchBar.h"
#import "YPMyCarMemberCell.h"
#import "YPMotorCadeList.h"

@interface HRCarNumSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *navView;
    UITableView *thisTableView;
}

@property (nonatomic, strong) NSMutableArray<YPMotorCadeList *> *listMarr;

@end

@implementation HRCarNumSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupMainUI];
}
- (void)setupNav{
    
    
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    
    //加上 搜索栏
    HRSearchBar *searchBar = [[HRSearchBar alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 35)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"请通过手机号搜索,输入空格查全部";
    //光标颜色
    searchBar.cursorColor = NavBarColor;
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 5;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    searchBar.searchBarTextField.layer.borderColor = RGB(234, 235, 237).CGColor;
    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    [searchBar.searchBarTextField becomeFirstResponder];
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [navView addSubview:searchBar];
 
    
}
-(void)setupMainUI{

    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.rowHeight = UITableViewAutomaticDimension;
    thisTableView.estimatedRowHeight = 100;//
    [self.view addSubview:thisTableView];
    
}
#pragma mark ----tableViewDataScouce ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPMotorCadeList *info = self.listMarr[indexPath.row];
    
    YPMyCarMemberCell *cell = [YPMyCarMemberCell cellWithTableView:tableView];
    
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:info.Headportrait]];
    cell.titleLabel.text = info.TrueName;
    cell.carName.text = info.Parent;
    
    cell.moreBtn.tag = indexPath.row + 1000;
    [cell.moreBtn setImage:[UIImage imageNamed:@"add-yellow"] forState:UIControlStateNormal];
    [cell.moreBtn addTarget:self action:@selector(inviteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - target
- (void)inviteBtnClick:(UIButton *)sender{
    
    YPMotorCadeList *list = self.listMarr[sender.tag - 1000];
    
    [self AddDriverSupplierRelationship:list.UserID];
}

#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HRSearchBar *sear = (HRSearchBar *)searchBar;
    //取消按钮
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self MotorCadeList:searchBar.text];
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 队长搜索车手
- (void)MotorCadeList:(NSString *)searchStr{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/MotorCadeList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"UserPhone"] = searchStr;//手机号 - 搜索使用
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPMotorCadeList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [thisTableView reloadData];
            
            if (self.listMarr.count > 0) {
                
            }else{
                [EasyShowTextView showText:@"当前无匹配数据,请重试!"];
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

#pragma mark 车手加入
- (void)AddDriverSupplierRelationship:(NSString *)driverID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddDriverSupplierRelationship";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"UserID"] = driverID;
    params[@"Type"] = @"1";//1邀请、2申请
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"邀请成功,请提醒对方同意!"];
            
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
- (NSMutableArray<YPMotorCadeList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
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
