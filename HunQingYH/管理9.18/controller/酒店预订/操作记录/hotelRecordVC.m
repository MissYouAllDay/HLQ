//
//  hotelRecordVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/28.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelRecordVC.h"
#import "YPHYTHThreeSelectView.h"
#import "hotelRecordCell.h"
#import "WTTableAlertView.h"
#import "yuangongModel.h"
#import "caozuoModel.h"
@interface hotelRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
       UITableView     *thisTableView;
       YPHYTHThreeSelectView *selectview;
    NSString *shenfenStr;
    NSString*shenfenID;
    NSString *type;
    
}
@property(nonatomic,strong)NSMutableArray  *dataArray;

/**<#注释#>*/
@property(nonatomic,strong)NSMutableArray  *shenfenArray;
@end

@implementation hotelRecordVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)shenfenArray{
    if (_shenfenArray) {
        _shenfenArray =[NSMutableArray array];
    }
    return _shenfenArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createTopView];
    [self createUI];
    [self GetRenYuanRequest];
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
    titleLab.text = @"操作记录";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
 
    
}


-(void)createTopView{

    
    UIView *shaixuanView =[[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, 50)];
    shaixuanView.backgroundColor =WhiteColor;
    [self.view addSubview:shaixuanView];
    
    
    selectview = [YPHYTHThreeSelectView yp_threeSelectView];
    [selectview.areaBtn addTarget:self action:@selector(shenfengClick) forControlEvents:UIControlEventTouchUpInside];
    [selectview.areaBtn setTitle:@"身份" forState:UIControlStateNormal];
    [selectview.xiaoliangBtn setTitle:@"操作" forState:UIControlStateNormal];
    selectview.xiaoliangBtn.hidden =YES;
    [selectview.xiaoliangBtn addTarget:self action:@selector(caozuoClick) forControlEvents:UIControlEventTouchUpInside];
    [selectview.priceBtn setTitle:@"全部" forState:UIControlStateNormal];
    [selectview.priceBtn addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
    selectview.frame =shaixuanView.bounds;
    [shaixuanView addSubview:selectview];
    
    
}
-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    hotelRecordCell *cell =[hotelRecordCell cellWithTableView:tableView];
    cell.model =self.dataArray[indexPath.row];
    return cell;
}

#pragma mark ----------------tableviewDelegate------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark --------------------- target---------------------
-(void)shenfengClick{
//    NSArray *stateArr=@[@"预留",@"已预订",@"订满"];
//    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择宴会厅" options:stateArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
//        for (id obj in options) {
//            NSLog(@"单选，且隐藏确定按钮:%@", obj);
//            NSInteger index =[obj integerValue];
//
//            [selectview.priceBtn setTitle:stateArr[index] forState:UIControlStateNormal];
//
//        }
//
//    }];
//    alertview.hiddenConfirBtn = YES;
//    [alertview show];
    
    NSMutableArray *arr =[NSMutableArray array];
    for (yuangongModel *model in _shenfenArray) {
        [arr addObject:model.Name];
    }
    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择人员" options:arr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            shenfenStr =arr[index];
            yuangongModel*selectmodel =_shenfenArray[index];
            shenfenID =selectmodel.Id;
            [selectview.areaBtn setTitle:shenfenStr forState:UIControlStateNormal];
            [self GetListWithID:shenfenID AndType:type];

            //            [selectview.areaBtn setTitle:tingArr[index] forState:UIControlStateNormal];
            
        }
        
    }];
    alertview.hiddenConfirBtn = YES;
    [alertview show];
}
-(void)caozuoClick{
    
}
-(void)timeClick{
        NSArray *stateArr=@[@"全部",@"登录",@"退出",@"添加",@"修改",@"删除"];
        WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择操作" options:stateArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
            for (id obj in options) {
                NSLog(@"单选，且隐藏确定按钮:%@", obj);
                NSInteger index =[obj integerValue];
                type =[NSString stringWithFormat:@"%zd",index];
                [selectview.priceBtn setTitle:stateArr[index] forState:UIControlStateNormal];
                [self GetListWithID:shenfenID AndType:type];
    
            }
    
        }];
        alertview.hiddenConfirBtn = YES;
        [alertview show];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)GetRenYuanRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelPersonnelList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"IdentityId"] =@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2";
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
            [self.shenfenArray removeAllObjects];
            self.shenfenArray = [yuangongModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            yuangongModel*selectmodel =_shenfenArray[0];
            shenfenID =selectmodel.Id;
            shenfenStr =selectmodel.Name;
            [selectview.areaBtn setTitle:shenfenStr forState:UIControlStateNormal];
            [self GetListWithID:shenfenID AndType:type];
            
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
- (void)GetListWithID:(NSString*)Id AndType:(NSString*)type{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelReserLogEntityList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PeoPleId"] =Id;
    params[@"PageIndex"] =@"1";
    params[@"PageCount"] =@"10000000000";
    params[@"Type"] =type;
    params[@"FacilitatorId"] =FacilitatorId_New;
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"操作%@",object);
            //
            self.dataArray = [caozuoModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
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
