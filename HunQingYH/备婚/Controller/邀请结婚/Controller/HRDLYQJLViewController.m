//
//  HRDLYQJLViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDLYQJLViewController.h"
#import "HRDLYQJLCell.h"
#import "HRYQJLModel.h"
@interface HRDLYQJLViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_navView;
    UITableView *thisTableView;
}
/**邀请记录数组*/
@property(nonatomic,strong)NSMutableArray<HRYQJLModel *>  *yqArray;


@end

@implementation HRDLYQJLViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
-(NSMutableArray<HRYQJLModel *> *)yqArray{
    if (!_yqArray) {
        _yqArray  = [NSMutableArray array];
    }
    return _yqArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self getPeopleListRequest];
 
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
    thisTableView.tableHeaderView  =[self addHeadView];
    [self.view addSubview:thisTableView];
}
#pragma mark ------tableviewDatascource ---------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.yqArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HRYQJLModel *yqm = self.yqArray[section];
    return yqm.Data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HRDLYQJLCell *cell = [HRDLYQJLCell cellWithTableView:tableView];
    HRYQJLModel *yqmodel = self.yqArray[indexPath.section];
    NSArray *dataArray = [NSArray arrayWithArray:yqmodel.Data];
    HRInvitePeopleModel *peoModel = dataArray[indexPath.row];
    if ([peoModel.BrideName isEqualToString:@""]) {
       
        cell.nameLab.text =peoModel.GroomName;
        cell.phoneLab.text =peoModel.GroomPhone;
       
    }else{
   
            cell.nameLab.text =peoModel.BrideName;
            cell.phoneLab.text =peoModel.BridePhone;
       

   
    }
    if (self.typeFlag ==1) {//输入邀请
        cell.qiandanLab.hidden =NO;
        
    }else{//扫码邀请
        cell.qiandanLab.hidden =YES;
        
    }
    return cell;
    
}
#pragma mark ------tableviewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(UIView *)addHeadView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    headerView.backgroundColor =WhiteColor;
    
    UILabel *textLab = [[UILabel alloc]init];
    textLab.text =@"邀请记录";
    [textLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    textLab.textAlignment =NSTextAlignmentCenter;
    textLab.textColor =BlackColor;
    [headerView addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).offset(20);
        make.top.mas_equalTo(headerView.mas_top).offset(20);
    }];
    
    
    
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HRYQJLModel *model = self.yqArray[section];
    UIView *secHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    secHeaderView.backgroundColor =WhiteColor;
    UILabel *timeLab = [[UILabel alloc]init];
    
    timeLab.text =model.Time;
    [timeLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [secHeaderView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(secHeaderView.mas_left).offset(15);
        make.bottom.mas_equalTo(secHeaderView);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 50));
    }];
    
    UILabel *numLab = [[UILabel alloc]init];
    numLab.text =[NSString stringWithFormat:@"%zd人",model.TimeCount];
    [numLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [secHeaderView addSubview:numLab];
    numLab.textAlignment =NSTextAlignmentRight ;
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(secHeaderView.mas_right).offset(-15);
        make.bottom.mas_equalTo(secHeaderView);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 50));
    }];
    
    
    return secHeaderView;
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if (_typeFlag ==1) {
          params[@"TerminalTypes"] =@"2";//0网页分享、1扫码、2手机APP
    }else{
         params[@"TerminalTypes"] =@"1";//0网页分享、1扫码、2手机APP
    }
 
    params[@"SubmittingID"] =UserId_New;
    params[@"ObjectTypes"] =@1;//0获取自己(我要结婚),1获取朋友(朋友结婚)
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"邀请列表%@",object);
            
            self.yqArray = [HRYQJLModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"TimeData"]];

            
           
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
