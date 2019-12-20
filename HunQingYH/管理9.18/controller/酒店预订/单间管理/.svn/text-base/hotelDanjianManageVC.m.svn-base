//
//  hotelDanjianManageVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelDanjianManageVC.h"
#import "hotelDJManageCell.h"
#import "hotelAddDanjianVC.h"
#import "danjianModel.h"
@interface hotelDanjianManageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *thisTableView;
}
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation hotelDanjianManageVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    [self createBottomView];
}

- (void)createNav {
    self.view.backgroundColor=WhiteColor ;
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"单间管理";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    

}
-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
}
-(void)createBottomView{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
    [bottomView.layer addSublayer:gradientLayer];
    [self.view addSubview:bottomView];
    
    
    UIButton *addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor=[UIColor clearColor];
    [addBtn setTitle:@"添加单间" forState:UIControlStateNormal];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font =kFont(15);
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(bottomView);
    }];
    
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    hotelDJManageCell *cell =[hotelDJManageCell cellWithTableView:tableView];
    cell.model =self.dataArray[indexPath.row];
    cell.editBtn.tag =indexPath.row;
    cell.model =self.dataArray[indexPath.row];
    [cell.editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark ----------------tableviewDelegate------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --------------------- target---------------------
-(void)addClick{
    hotelAddDanjianVC *addvc =[hotelAddDanjianVC new];
    [self.navigationController pushViewController:addvc animated:YES];
    
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editClick:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    danjianModel *model =self.dataArray[sender.tag];
    hotelAddDanjianVC *addvc = [[hotelAddDanjianVC alloc]init];
    addvc.Id =model.Id;
    addvc.maxStr =model.MaxTableNumber;
    addvc.minStr =model.MinTableNumber;
    addvc.nameStr =model.BanquetName;
    [self.navigationController pushViewController:addvc animated:YES];
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetListRequest];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -------------------网络请求-------------------
- (void)GetListRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelSingleRoomList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] =FacilitatorId_New;
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"人员%@",object);
            //
            self.dataArray = [danjianModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thisTableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}


@end
