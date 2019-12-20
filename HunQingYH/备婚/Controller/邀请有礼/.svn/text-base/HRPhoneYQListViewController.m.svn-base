//
//  HRPhoneYQListViewController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRPhoneYQListViewController.h"
#import "HRPhoneYQTopCell.h"
#import "HRPhongYQAddViewController.h"
#import "HRInvitePeopleModel.h"
@interface HRPhoneYQListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     UIView *_navView;
    UITableView *thisTableView;
}
/**被邀请人数组*/
@property(nonatomic,strong)NSMutableArray  *peopleArr;

@end

@implementation HRPhoneYQListViewController
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
    _navView.backgroundColor = CHJ_bgColor;
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
    titleLab.text = @"手机号邀请";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    self.view.backgroundColor =CHJ_bgColor;
}
-(void)setupUI{
    
    thisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    [self.view addSubview:thisTableView];
}
#pragma mark ------tableviewDatascource ---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return self.peopleArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        HRPhoneYQTopCell *cell = [HRPhoneYQTopCell cellWithTableView:tableView];
        return cell;
    }else{
         static NSString* indentifier = @"cell";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        HRInvitePeopleModel *model = self.peopleArr[indexPath.row];
        
        cell.textLabel.text =model.BeinvitedName;
        cell.detailTextLabel.text =model.BeinvitedPhone;
        cell.detailTextLabel.textColor =TextNormalColor;
        return cell;
    }
}
#pragma mark ------tableviewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else{
        return 50;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headerView.backgroundColor =CHJ_bgColor;
        
        UILabel *textLab = [[UILabel alloc]init];
        textLab.text =@"邀请记录";
        textLab.textAlignment =NSTextAlignmentCenter;
        textLab.textColor =TextNormalColor;
        [headerView addSubview:textLab];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(headerView);
        }];
        
        return headerView;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        HRPhongYQAddViewController *addVC = [HRPhongYQAddViewController new];
        [self.navigationController presentViewController:addVC animated:YES completion:nil];
    }
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
    NSString *url = @"/api/HQOAApi/GetInviteList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"10000000";
    params[@"InviteID"] =@0;
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"奖品列表%@",object);
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
