//
//  HRGuangZhuViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRGuangZhuViewController.h"
#import "FL_Button.h"
#import "HXSearchBar.h"
#import "UIParameter.h"
#import "NinaSelectionView.h"

#import "HRLikeListCell.h"
@interface HRGuangZhuViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,NinaSelectionDelegate>
{
    UITableView *thisTableView;
    FL_Button *leiBth;
    NSString *changeStr;
}
@property (nonatomic, strong) NinaSelectionView *ninaSelectionView;


@end

@implementation HRGuangZhuViewController
- (NinaSelectionView *)ninaSelectionView {
    if (!_ninaSelectionView) {
        _ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:[self titlesArray] PopDirection:NinaPopFromBelowToTop];
        _ninaSelectionView.ninaSelectionDelegate = self;
        _ninaSelectionView.defaultSelected = 1;
        _ninaSelectionView.shadowEffect = YES;
        _ninaSelectionView.shadowAlpha = 0.5;
        
        
    }
    return _ninaSelectionView;
}

#pragma mark - TitlesArray
- (NSArray *)titlesArray {
    return @[
             @"全部",
             @"新人",
             @"婚庆",
             @"酒店",
             @"婚车",
             @"主持",
             @"摄影",
             @"演艺",
             @"灯光",
             
             ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self createUI];
}
-(void)createUI{
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    
    leiBth = [FL_Button fl_shareButton];
    [leiBth setBackgroundColor:[UIColor whiteColor]];
    [leiBth setImage:[UIImage imageNamed:@"下拉_Gray"] forState:UIControlStateNormal];
    [leiBth setTitle:@"全部" forState:UIControlStateNormal];
    [leiBth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leiBth.status = FLAlignmentStatusCenter;
    leiBth.titleLabel.font = [UIFont systemFontOfSize:14];
    [leiBth addTarget:self action:@selector(leiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leiBth];
    [leiBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.left.mas_equalTo(topView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    
    //加上 搜索栏
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(120, 10, ScreenWidth  - 130, 40)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"搜索...";
    //光标颜色
    searchBar.cursorColor =MainColor;
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 4;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    searchBar.searchBarTextField.layer.borderColor = WhiteColor.CGColor;
    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    searchBar.searchBarTextField.backgroundColor =RGB(235, 235, 235);
    
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [topView addSubview:searchBar];
    
    
    
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight -NAVIGATION_BAR_HEIGHT-60) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
    [self.view addSubview:self.ninaSelectionView];
    
}

#pragma mark -----------tableviewDatascource -------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRLikeListCell *cell = [HRLikeListCell cellWithTableView:tableView];
    return cell;
}
#pragma mark -----------tableviewDelegate -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HXSearchBar *sear = (HXSearchBar *)searchBar;
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
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
    //请求网络
    NSLog(@"搜索");
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
}
#pragma mark - NinaSelectionDelegate
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Choose %li button",(long)button.tag);
    changeStr = button.titleLabel.text;
    [leiBth setTitle:changeStr forState:UIControlStateNormal];
    [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.3];
    [thisTableView reloadData];
}

#pragma mark --------target---------
-(void)leiBtnClick{
    [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
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
