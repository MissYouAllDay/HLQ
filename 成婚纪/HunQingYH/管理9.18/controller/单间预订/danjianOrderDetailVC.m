//
//  danjianOrderDetailVC.m
//  HunQingYH
//
//  Created by xl on 2019/7/7.
//  Copyright © 2019 xl. All rights reserved.
//

#import "danjianOrderDetailVC.h"
#import "yhtcustomerCell.h"
#import "orderOndeDesCell.h"
#import "hotelAddTextAreaCell.h"
#import "danjianAddVC.h"
#import "WTTableAlertView.h"
#import "danjianOrderModel.h"

@interface danjianOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView *thisTableView;
    NSString *danjianNameStr;
    UILabel *danjianNameLab;
    NSString *timeStr;
    NSString *numStr;
    NSString *yudingNameStr;
    NSString *yudingPhoneStr;
    NSString *beizhuStr;
    NSString *phoneStr;
    NSString *ReceiptType;//0未接单，1接单，2拒单
    
}
@property(nonatomic,strong)NSMutableArray  *customerArray;
@end

@implementation danjianOrderDetailVC
-(NSMutableArray *)customerArray{
    if (!_customerArray) {
        _customerArray =[NSMutableArray array];
    }
    return _customerArray;
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
    titleLab.text = @"预订详情";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [saveBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    saveBtn.titleLabel.font =kFont(15);
    [saveBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
}
-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.tableHeaderView =[self addTableHeaderView];
    thisTableView.estimatedRowHeight =150;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
}
-(void)createBottomView{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *bianView =[[UIView alloc]init];
    bianView.clipsToBounds=YES;
    bianView.layer.cornerRadius =5;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 80, 40);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
    [bianView.layer addSublayer:gradientLayer];
    [bottomView addSubview:bianView];
    [bianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(bottomView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    UIButton *callBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    callBtn.backgroundColor=[UIColor clearColor];
    [callBtn setTitle:@"联系客户" forState:UIControlStateNormal];
    [callBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    callBtn.titleLabel.font =kFont(15);
    [bianView addSubview:callBtn];
    [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bianView);
        make.size.mas_equalTo(bianView);
    }];
    
    UIButton *editBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"转包间" forState:UIControlStateNormal];
    [editBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [editBtn setBackgroundColor:WhiteColor];
    editBtn.titleLabel.font =kFont(15);
    editBtn.clipsToBounds =YES;
    editBtn.layer.cornerRadius =5;
    editBtn.layer.borderColor =LineColor.CGColor;
    editBtn.layer.borderWidth =1;
    [editBtn addTarget:self action:@selector(baojianClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bianView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.mas_equalTo(bianView.mas_left).offset(-15);
    }];
    UIButton *cancleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消预订" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:WhiteColor];
    cancleBtn.titleLabel.font =kFont(15);
    cancleBtn.clipsToBounds =YES;
    cancleBtn.layer.cornerRadius =5;
    cancleBtn.layer.borderColor =LineColor.CGColor;
    cancleBtn.layer.borderWidth =1;
    [cancleBtn addTarget:self action:@selector(quxiaoclick) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bianView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.mas_equalTo(editBtn.mas_left).offset(-15);
    }];
    UIButton *cleanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setTitle:@"清台" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [cleanBtn setBackgroundColor:WhiteColor];
    cleanBtn.titleLabel.font =kFont(15);
    [cleanBtn addTarget:self action:@selector(cleanClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bianView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.mas_equalTo(cancleBtn.mas_left).offset(-15);
    }];
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
           return self.customerArray.count;
    }else if (section==1){
        return 3;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        yhtcustomerCell *cell =[yhtcustomerCell cellWithTableView:tableView];
        cell.model =self.customerArray[indexPath.row];
        return cell;
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
        
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"预计用餐时间";
            cell.desLab.text =timeStr;
            return cell;
        }else   if (indexPath.row ==1) {
        
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"人数";
            cell.desLab.text =numStr;
            return cell;
        }else  {
            yhtcustomerCell *cell =[yhtcustomerCell cellWithTableView:tableView];
//            cell.model =self.customerArray[indexPath.row];
            cell.titleLab.text =@"预订人员";
            cell.shenfenLab.hidden =YES;
            cell.nameLab.text =yudingNameStr;
            cell.phoneLab.text =yudingPhoneStr;
            return cell;
        }
    }else{
        if (indexPath.row==0) {
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =beizhuStr;
            cell.desLab.hidden =YES;
            return cell;
        }else{
            
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"来源";
            cell.desLab.text =@"平台";
            return cell;
        }
    }
}

#pragma mark ----------------tableviewDelegate------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return 0;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    if (section==0||section==2) {
        UILabel *tingnameLab = [[UILabel alloc]init];
        tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        if (section ==0) {
            tingnameLab.text =@"订单详情";
        }else{
            tingnameLab.text =@"备注";
        }
        [headerView addSubview:tingnameLab];
        [tingnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(headerView.mas_left).offset(15);
        }];
        return headerView;
    }else{
        return nil;
    }
}
-(UIView*)addTableHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    
    UIImageView *iconImageview =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
    iconImageview.image =[UIImage imageNamed:@"1024"];
    [headerView addSubview:iconImageview];
    danjianNameLab = [[UILabel alloc]init];
    danjianNameLab.text =@"单间名称";
    [headerView addSubview:danjianNameLab];
    [danjianNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(iconImageview.mas_right).offset(15);
    }];
    
    return headerView;
}

#pragma mark --------------------- target---------------------
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)callClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
}
-(void)editClick{
    NSLog(@"编辑");

    danjianAddVC *addvc = [danjianAddVC new];
    addvc.recordId =self.Id;
    addvc.formType =@"1";
    addvc.type =self.type;
    addvc.Id =self.danjianId;
    [self.navigationController pushViewController:addvc animated:YES];
}
-(void)baojianClick{
    NSLog(@"转包间");

    NSMutableArray *titleArr =[NSMutableArray array];
    for (int i =0; i<self.danjianArray.count; i++) {
        danjianOrderModel *model =self.danjianArray[i];
        [titleArr addObject:model.Name];
    }
    
    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择包间" options:titleArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            danjianOrderModel *model =self.danjianArray[index];
            [self baojianRequestWithID:model.RoomId];
            
        }
        
    }];
    alertview.hiddenConfirBtn = NO;
    [alertview show];
}
-(void)cleanClick{
    NSLog(@"清台");
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确认清台？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1002;
    [alertView show];
}
-(void)quxiaoclick{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"取消该预订？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetdetailRequest];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


#pragma mark***********************网络请求*********************

- (void)GetdetailRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSinglelReserveInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =self.Id;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"单间详情%@",object);
            
            danjianNameStr =[object objectForKey:@"SingleName"];
            danjianNameLab.text =danjianNameStr;
            timeStr =@"";
            timeStr =[NSString stringWithFormat:@"%@ %@",[object objectForKey:@"ReserveTime"],[object objectForKey:@"DinnerTime"]];
            numStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"PeopleNumber"]];
             yudingPhoneStr =[object objectForKey:@"ScheduledPeoplePhone"];
            yudingNameStr =[object objectForKey:@"ScheduledPeopleName"];
            beizhuStr =[object objectForKey:@"Meno"];
            ReceiptType =[object objectForKey:@"ReceiptType"];


            [self.customerArray removeAllObjects];
            NSArray *array1 = [[object objectForKey:@"BanquetCustomer"] componentsSeparatedByString:@";"]; //从字符A中分隔成2个元素的数组
            for (NSString *str  in array1) {
                if (![str isEqualToString:@""]) {
                    NSArray *array2 = [str componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
                    customerModel *model =[customerModel new];
//                    if (array2.count>0) {
//                        model.shenfenStr =array2[0];
//                    }
                    if (array2.count>0) {
                        model.nameStr =array2[0];
                    }
                    if (array2.count>1) {
                        model.phoneStr =array2[1];
                        phoneStr =model.phoneStr;
                    }
                    
                    [self.customerArray addObject:model];
                }
                
            }
//
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
-(void)delteRequest{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/DeleteSinglelReserveTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"删除成功"];

            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"danjiReload" object:self];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
-(void)baojianRequestWithID:(NSString*)baojianId{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/TurnSinglelReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"SingleId"]=baojianId;
    params[@"ReceiptType"] =ReceiptType;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            
            [EasyShowTextView showSuccessText:@"该订单已成功转移到该包间"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"danjiReload" object:self];
            [self performSelector:@selector(backVC) withObject:nil afterDelay:1.5];

            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

-(void)cleanRequest{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/UpdateSinglelReserveOrderStatus";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"OrderStatus"]=@"1";
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"操作成功"];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"danjiReload" object:self];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    if(buttonIndex == 1 && alertView.tag == 1001) {
        
        
        [self delteRequest];
    }
    if(buttonIndex == 1 && alertView.tag == 1002) {
        
        
        [self cleanRequest];
    }
  
}
@end
