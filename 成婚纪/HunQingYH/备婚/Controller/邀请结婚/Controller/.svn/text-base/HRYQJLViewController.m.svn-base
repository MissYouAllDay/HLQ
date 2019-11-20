//
//  HRYQJLViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJLViewController.h"
#import "HRYQJLCell.h"
#import "HRPhongYQAddViewController.h"
#import "HRInvitePeopleModel.h"

@interface HRYQJLViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_navView;
    UITableView *thisTableView;
}
/**被邀请人数组*/
@property(nonatomic,strong)NSMutableArray  *peopleArr;
/**总数*/
@property(nonatomic,assign)NSInteger  TotalCount;
@end

@implementation HRYQJLViewController

-(NSMutableArray *)peopleArr{
    if (!_peopleArr) {
        _peopleArr = [NSMutableArray array];
        
    }
    return _peopleArr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPeopleListRequest];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self  setupUI];
    
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"手机号邀请";
//    titleLab.textColor = BlackColor;
//    titleLab.font = [UIFont boldSystemFontOfSize:20];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
    self.view.backgroundColor =CHJ_bgColor;
}
-(void)setupUI{
    
    thisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableView.backgroundColor = WhiteColor;
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
}
#pragma mark ------tableviewDatascource ---------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.peopleArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    HRYQJLCell *cell = [HRYQJLCell cellWithTableView:tableView];
    cell.model =self.peopleArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma mark ------tableviewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headerView.backgroundColor =WhiteColor;
        
        UILabel *textLab = [[UILabel alloc]init];
        textLab.text =@"邀请记录";
        [textLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
        textLab.textAlignment =NSTextAlignmentCenter;
        textLab.textColor =BlackColor;
        [headerView addSubview:textLab];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerView.mas_left).offset(20);
            make.top.mas_equalTo(headerView.mas_top).offset(20);
        }];
    
    
    UILabel *numLab = [[UILabel alloc]init];
    numLab.text =[NSString stringWithFormat:@"已推荐成功%zd人",_TotalCount];
    numLab.font =kFont(15);
    numLab.textAlignment =NSTextAlignmentCenter;
    numLab.textColor =TextNormalColor;
    [headerView addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).offset(20);
        make.top.mas_equalTo(textLab.mas_bottom).offset(10);
    }];
    
        return headerView;
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section==0) {
//        HRPhongYQAddViewController *addVC = [HRPhongYQAddViewController new];
//        [self.navigationController presentViewController:addVC animated:YES completion:nil];
//    }
}
#pragma mark --------------target-------------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------网络请求---------------

//查看被邀请人列表
- (void)getPeopleListRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetNewInformationList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"100";
    params[@"TerminalTypes"] =@"2";//0网页分享、1扫码、2手机APP
    params[@"SubmittingID"] =UserId_New;
    params[@"ObjectTypes"] =@1;//0获取自己(我要结婚),1获取朋友(朋友结婚)
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
        
            self.TotalCount = [[object objectForKey:@"TotalCount"]integerValue];
            self.peopleArr = [HRInvitePeopleModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thisTableView reloadData];
            
            
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

@end
