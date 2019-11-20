//
//  HRLikePeopleListController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRLikePeopleListController.h"
#import "HRLikeListCell.h"
#import "HRZanModel.h"
//#import "YPReMeInfoController.h"
//5-24 替换 个人信息
#import "YPHomeInfoPageController.h"
//5-31 修改 酒店/婚车个人信息
#import "HRHotelViewController.h"
//5-31 修改 其他 个人信息
#import "YPSupplierOtherInfoController.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页

@interface HRLikePeopleListController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_navView;
    UITableView *thisTableView;
    
}
/**点赞数组*/
@property(nonatomic,strong)NSMutableArray  *zanArray;
@end

@implementation HRLikePeopleListController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(NSMutableArray *)zanArray{
    if (!_zanArray) {
        _zanArray =[NSMutableArray array];
    }
    
    return _zanArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self getzanlist];
    [self createUI];
}
- (void)setupNav{
   
    
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
    titleLab.text = @"喜欢";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
    
 
    
}
-(void)createUI{
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
    

}


#pragma mark --------tableviewDatasscoure -------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zanArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRLikeListCell *cell = [HRLikeListCell cellWithTableView:tableView];
    cell.model =_zanArray[indexPath.row];
    return cell;
}

#pragma mark --------tableviewDelegate -----------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HRZanModel *model = _zanArray[indexPath.row];
    
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = model.SupplierID;
    hotelVC.profession = model.OccupationCode;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark ---------target ---------
-(void)backVC{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getzanlist{
    
    NSString *url = @"/api/HQOAApi/GetGivethumbList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]    = UserId_New;
    params[@"DynamicID"] = _DynamicID;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"100000";
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
           
            self.zanArray  =[HRZanModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            [thisTableView reloadData];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        
    }];
}

@end
