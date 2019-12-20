//
//  hotelCanBiaoVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelCanBiaoVC.h"
#import "hotelCanbiaoManageCell.h"
#import "hotelAddCanbiaoVC.h"
#import "YPGetBanquetHallList.h"
#import "canbiaoModel.h"
#import "WTTableAlertView.h"
#import "checkCanbiaoVC.h"
@interface hotelCanBiaoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *thisTableView;
    UIButton *tingnameBtn;
    NSString *tingID;
}
/**宴会厅数组*/
@property(nonatomic,strong)NSMutableArray  *tingArray;
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation hotelCanBiaoVC
-(NSMutableArray *)tingArray{
    if (!_tingArray) {
        _tingArray =[NSMutableArray array];
    }
    return _tingArray;
}
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
    titleLab.text = @"餐标管理";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
 
}

#pragma mark --------------------- target---------------------
-(void)addClick{
    hotelAddCanbiaoVC *addvc =[hotelAddCanbiaoVC new];
    addvc.tingID =tingID;
    [self.navigationController pushViewController:addvc animated:YES];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)checkClick:(UIButton*)btn{
    
    canbiaoModel *model =self.dataArray[btn.tag];
    checkCanbiaoVC *checkvc =[checkCanbiaoVC new];
    checkvc.Id =model.Id;
    [self.navigationController pushViewController:checkvc animated:YES];
    
}
-(void)editClick:(UIButton*)btn{
    
    canbiaoModel *model =self.dataArray[btn.tag];
    hotelAddCanbiaoVC *addvc =[hotelAddCanbiaoVC new];
    addvc.tingID =tingID;
    addvc.Id =model.Id;
    [self.navigationController pushViewController:addvc animated:YES];
    
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetBanquetHallList];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}




-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.tableHeaderView =[self addTableHeaderView];
    //    thisTableView.estimatedRowHeight =150;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    hotelCanbiaoManageCell *cell =[hotelCanbiaoManageCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model =self.dataArray[indexPath.row];
    cell.editBtn.tag =indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.menBtn.tag =indexPath.row;
    [cell.menBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark ----------------tableviewDelegate------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView*)addTableHeaderView{
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =RGB(246, 247, 249);
    
    tingnameBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [tingnameBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [tingnameBtn setTitle:@"" forState:UIControlStateNormal];
    [tingnameBtn addTarget:self action:@selector(tingnameClick) forControlEvents:UIControlEventTouchUpInside];
    
    tingnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //距左的边距为10
    tingnameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headerView addSubview:tingnameBtn];
    [tingnameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(headerView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenWidth-30));
    }];
    
    UIButton *xiaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [xiaBtn setTitle:@"" forState:UIControlStateNormal];
    [xiaBtn setImage:[UIImage imageNamed:@"标签-向下箭头"] forState:UIControlStateNormal];
    [headerView addSubview:xiaBtn];
    [xiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.mas_equalTo(headerView);
        make.right.mas_equalTo(headerView.mas_right).offset(-15);
    }];
    
    return headerView;
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
    [addBtn setTitle:@"添加餐标" forState:UIControlStateNormal];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font =kFont(15);
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(bottomView);
    }];
    
}
-(void)tingnameClick{
    NSMutableArray *arr =[NSMutableArray array];
    for (YPGetBanquetHallList *mod in self.tingArray) {
        [arr addObject:mod.BanquetHallName];
    }
    
    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择宴会厅" options:arr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            YPGetBanquetHallList *model =self.tingArray[index];
            [tingnameBtn setTitle:model.BanquetHallName forState:UIControlStateNormal];
            tingID =model.BanquetID;
            [self GetCanbiaoListRequestWithID:model.BanquetID];
        }
        
    }];
    alertview.hiddenConfirBtn = YES;
    [alertview show];
}


#pragma mark -------------------网络请求-------------------
//根据服务商id获取宴会厅列表
- (void)GetBanquetHallList{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetHallList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =FacilitatorId_New;
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"宴会厅列表返回%@",object);
            
            self.tingArray = [YPGetBanquetHallList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            if (self.tingArray.count>0) {
                YPGetBanquetHallList *model =self.tingArray[0];
                [tingnameBtn setTitle:model.BanquetHallName forState:UIControlStateNormal];
                tingID =model.BanquetID;
                [self GetCanbiaoListRequestWithID:model.BanquetID];
            }

         
            
          
            
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

- (void)GetCanbiaoListRequestWithID:(NSString*)Id{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetMealTable";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"BanquetId"] =Id;
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"餐标%@",object);
            //
            self.dataArray = [canbiaoModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

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
