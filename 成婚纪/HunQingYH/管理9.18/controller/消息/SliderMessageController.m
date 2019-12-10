//
//  SliderMessageController.m
//  HunQingYH
//
//  Created by xl on 2019/6/21.
//  Copyright © 2019 xl. All rights reserved.
//

#import "SliderMessageController.h"
#import "JXCategoryView.h"
#import "SliderMessListCell.h"
#import "MessageDetailVC.h"
#import "messageModel.h"
#import "danjianOrderDetailVC.h"
@interface SliderMessageController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIView *_navView;
    UITableView *thisTableView;
    UILabel *allNumLab;
     NSInteger type;//0宴会厅消息，1 用餐消息
}
/**<#注释#>*/
@property(nonatomic,strong)JXCategoryTitleView  *categoryView;
/**<#注释#>*/
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation SliderMessageController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(241, 244, 247);
    type =0;
    [self setupNav];
    [self createUI];
}
- (void)setupNav{
//
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
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

    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(ScreenWidth/2-100,30, 200, 34)];
    self.categoryView.delegate = self;
    [_navView addSubview:self.categoryView];
    self.categoryView.titles = @[@"宴会厅消息", @"用餐消息"];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleSelectedColor =MainColor;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = MainColor;
//    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];

}
-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.tableHeaderView =[self addTableHeaderView];
    thisTableView.estimatedRowHeight =150;
    thisTableView.backgroundColor =RGB(241, 244, 247);
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
    SliderMessListCell *cell =[SliderMessListCell cellWithTableView:tableView];
    cell.model =self.dataArray[indexPath.row];
    return cell;
}

#pragma mark ----------------tableviewDelegate------------------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    messageModel *model =self.dataArray[indexPath.row];
    MessageDetailVC *detailVC =[MessageDetailVC new];
    detailVC.Id =model.Id;
    detailVC.ReceiptType =model.ReceiptType;
    detailVC.type =[NSString stringWithFormat:@"%zd",type];
    [self.navigationController pushViewController:detailVC animated:YES];

}

-(UIView*)addTableHeaderView{
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    allNumLab =[[UILabel alloc]init];
    allNumLab.font =kFont(15);
    allNumLab.text =@"共0条消息";
    allNumLab.textColor =RGB(102, 102, 102);
    [headerView addSubview:allNumLab];
    [allNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(headerView.mas_left).offset(15);
        
    }];
//    UILabel *weiNumLab =[[UILabel alloc]init];
//    weiNumLab.font =kFont(15);
//    weiNumLab.textColor =MainColor;
//    weiNumLab.text =@"2";
//    [headerView addSubview:weiNumLab];
//    [weiNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(allNumLab);
//        make.left.mas_equalTo(allNumLab.mas_right);
//    }];
//    UILabel *desLab =[[UILabel alloc]init];
//    desLab.font =kFont(15);
//    desLab.text =@"条未读";
//    desLab.textColor =RGB(102, 102, 102);
//    [headerView addSubview:desLab];
//    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(weiNumLab);
//        make.left.mas_equalTo(weiNumLab.mas_right);
//
//    }];
    return headerView;
}
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"%zd",index);
    type =index;
    if (index ==0) {
        [self GetBanquetHallList];
    }else{
        [self GetDanjianListRequest];
    }
}

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
}

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
    
}



#pragma mark --------------------- target---------------------
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (type ==0) {
        [self GetBanquetHallList];

    }else{
        [self GetDanjianListRequest];
    }

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark***********************网络请求*********************
//获取宴会厅消息
- (void)GetBanquetHallList{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUnansweredBanquetlReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] =FacilitatorId_New;
       params[@"PageIndex"] =@"1";
    params[@"PageCount"] =@"1000000";
    params[@"ReceiptType"] =@"0";  //0全部，1未接单，2接单，3拒单

    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"宴会厅列表返回%@",object);
            
            self.dataArray = [messageModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            allNumLab.text =[NSString stringWithFormat:@"共%zd条消息",self.dataArray.count];
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

//单间
- (void)GetDanjianListRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUnansweredSinglelReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] =FacilitatorId_New;
    params[@"PageIndex"] =@"1";
    params[@"PageCount"] =@"1000000";
    params[@"ReceiptType"] =@"0";  //0全部，1未接单，2接单，3拒单

    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"预订列表%@",object);
            //
            self.dataArray = [messageModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [thisTableView reloadData];
            allNumLab.text =[NSString stringWithFormat:@"共%zd条消息",self.dataArray.count];

            
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
