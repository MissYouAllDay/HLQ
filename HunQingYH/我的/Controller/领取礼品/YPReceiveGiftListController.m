//
//  YPReceiveGiftListController.m
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPReceiveGiftListController.h"
//#import "YPReceiveGiftListCell.h"
#import "YPReceiveAddressController.h"
//#import "YPGetMyPrizesStatusList.h"
#import "YPReReceiveGiftListCell.h"

@interface YPReceiveGiftListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic ,strong) NSMutableArray<YPGetMyPrizesStatusList *> *listMarr;

@end

@implementation YPReceiveGiftListController{
    UIView *_navView;
    UIButton *_currentBtn;//当前选中的领奖按钮
//    NSInteger _pageIndex;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
//    _pageIndex = 1;
    
    [self setupNav];
    [self setupUI];
}

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
    titleLab.text = @"领取我的奖品";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];

//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _pageIndex = 1;
//        [self GetMyPrizesStatusList];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _pageIndex ++;
//        [self GetMyPrizesStatusList];
//    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.grades.count > 0) {
        return self.grades.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPReReceiveGiftListCell *cell = [YPReReceiveGiftListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.grades.count > 0) {
        cell.titleLabel.text = [NSString stringWithFormat:@"达标%@",self.grades[indexPath.section]];
    }else{
        cell.titleLabel.text = @"当前无档次";
    }
    
    //    cell.lingquBtn.enabled = NO;
    if (cell.lingquBtn.isEnabled) {
        
        [cell.lingquBtn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.42 blue:0.00 alpha:1.00]];
    }else{
        
        [cell.lingquBtn setBackgroundColor:WhiteColor];
    }
    
    cell.lingquBtn.tag = indexPath.section + 1000;
     if ([self.yaoQingCount integerValue] >= [self.grades[indexPath.section] integerValue]){
         [cell.lingquBtn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.42 blue:0.00 alpha:1.00]];
         [cell.lingquBtn setTitle:@"领取" forState:UIControlStateNormal];
         [cell.lingquBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
         cell.userInteractionEnabled =YES;
         [cell.lingquBtn addTarget:self action:@selector(lingquBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
     }else{
         [cell.lingquBtn setBackgroundColor:[UIColor lightGrayColor]];
         [cell.lingquBtn setTitle:@"不可领取" forState:UIControlStateNormal];
         [cell.lingquBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
         cell.userInteractionEnabled =NO;
      
     }
 
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = [NSString stringWithFormat:@"已邀请用户人数: %@",self.yaoQingCount];
        label1.font = kNormalFont;
        label1.textColor = GrayColor;
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(12);
        }];
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = [NSString stringWithFormat:@"领取截止日: %@",self.endTime];
        label2.textColor = GrayColor;
        label2.font = kNormalFont;
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-12);
        }];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//#pragma mark - YPReceiveAddressSucDelegate
//- (void)receiveAddressSuc{
//    _currentBtn.enabled = NO;
//    [_currentBtn setBackgroundColor:WhiteColor];
//}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lingquBtnClick:(UIButton *)sender{
    
    _currentBtn = sender;
    
    NSLog(@"lingquBtnClick: -- %zd -- %@",sender.tag,self.grades[sender.tag - 1000]);
   
        YPReceiveAddressController *address = [[YPReceiveAddressController alloc]init];
        address.ObjectTypes =self.ObjectTypes;
//        address.sucDelegate = self;
        address.grade = self.grades[sender.tag - 1000];
        address.ActivityID = self.ActivityID;
        [self.navigationController pushViewController:address animated:YES];
 

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
