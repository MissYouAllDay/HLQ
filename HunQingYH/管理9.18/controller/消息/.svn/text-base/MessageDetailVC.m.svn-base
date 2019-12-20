//
//  MessageDetailVC.m
//  HunQingYH
//
//  Created by xl on 2019/8/14.
//  Copyright © 2019 xl. All rights reserved.
//

#import "MessageDetailVC.h"
#import "yhtorderdetailTopView.h"
#import "ythorderdetailFourInfoCell.h"
#import "yhtorderOneCordCell.h"
#import "WPAlertControl.h"
#import "WPView.h"
#import "messCanleView.h"
#import "customerModel.h"
@interface MessageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *thisTableView;
    NSString *tingName;
    NSString *canbiaoStr;
    NSString *zhuoshuStr;
    NSString *dingjinStr;
    NSString *yudingrenStr;
    NSString *yudingPhone;
    NSString *xiaoshouStr;
    NSString *xiaoshouPhone;
    NSString *beizhuiStr;
    NSString *customerStr;
    NSString *timeStr;
    NSString *orderTimeStr;
    NSString *phoneStr;
    yhtorderdetailTopView *topview ;
    NSString *dingjinStateStr;
    UIButton *acceptBtn;
    UIView *bianView;
    UIButton *cancleBtn;
    NSString *canclereaStr;
    
    NSString *danjianNameStr;
    NSString *yongcanstyleStr;
}
/**M*/
@property(nonatomic,strong)messCanleView  *alertView;
@property(nonatomic,strong)NSMutableArray  *customerArray;

@end

@implementation MessageDetailVC
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
    if ([self.type isEqualToString:@"0"]) {
        [self GetyhtdetailRequest];
        canclereaStr =@"该宴会厅已经确认被预留或已交定金";

    }else{
        [self GetdanjiandetailRequest];
        canclereaStr =@"该单间已经被预订";

    }

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
    titleLab.text = @"订单详情";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    
    
}
-(void)createBottomView{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
 
    
    bianView =[[UIView alloc]init];
    bianView.clipsToBounds=YES;
    bianView.layer.cornerRadius =15;
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
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.mas_equalTo(bottomView.mas_right).offset(-15);
        
   
    }];
    acceptBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    acceptBtn.backgroundColor=[UIColor clearColor];
    [acceptBtn setTitle:@"接收订单" forState:UIControlStateNormal];
    [acceptBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    acceptBtn.titleLabel.font =kFont(15);
    [acceptBtn addTarget:self action:@selector(acceptClick) forControlEvents:UIControlEventTouchUpInside];
    [bianView addSubview:acceptBtn];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bianView);
        make.size.mas_equalTo(bianView);
    }];
    
    cancleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"拒绝订单" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:WhiteColor];
    cancleBtn.titleLabel.font =kFont(15);
    cancleBtn.clipsToBounds =YES;
    cancleBtn.layer.cornerRadius =15;
    cancleBtn.layer.borderColor =LineColor.CGColor;
    cancleBtn.layer.borderWidth =1;
    [cancleBtn addTarget:self action:@selector(quxiaoclick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(bianView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
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
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ythorderdetailFourInfoCell *cell =[ythorderdetailFourInfoCell cellWithTableView:tableView ];
        cell.contentView.backgroundColor =CHJ_bgColor;
        if ([self.type isEqualToString:@"1"]) {
            cell.nameTitleLab.text =@"单间";
            cell.canbiaoTitleLab.text =@"类型";
            cell.namLab.text =danjianNameStr;
            cell.canbiaoLab.text =yongcanstyleStr;
        }else{
            cell.namLab.text =tingName;
            cell.canbiaoLab.text =[NSString stringWithFormat:@"￥%@/桌",canbiaoStr];
        }
     
        cell.numLab.text =[NSString stringWithFormat:@"%@桌",zhuoshuStr];
        cell.timeLab.text =timeStr;
        return cell;
    }else {
        yhtorderOneCordCell *cell =[yhtorderOneCordCell cellWithTableView:tableView];
        cell.contentView.backgroundColor =CHJ_bgColor;
        cell.titleLab.text =@"下单时间";
        cell.desLab.text =orderTimeStr;
        return cell;
    }
    
}

#pragma mark ----------------tableviewDelegate------------------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)addTableHeaderView{
    topview = [yhtorderdetailTopView initViewWithXib];
    topview.frame =CGRectMake(0, 0, ScreenWidth, 230);
    [topview.phontBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
    
    return topview;
}
#pragma mark --------------------- target---------------------
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)quxiaoclick{
    NSLog(@"拒绝");
    [self centerAlert];
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    dingjinStr =textField.text;
}
-(void)acceptClick{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"接收订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
}
-(void)callClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
}
- (void)centerAlert
{
    WPView *view1 = [WPView viewWithTapClick:^(id other) {
        
        
        
    }];
    view1.frame = CGRectMake(0, 0, ScreenWidth-800 , 350);
    view1.backgroundColor = [UIColor clearColor];
    
    _alertView =[messCanleView initViewWithXib];
    _alertView.frame =view1.bounds;
    _alertView.layer.masksToBounds =YES;
    _alertView.layer.cornerRadius =10;
    [view1 addSubview:_alertView];
    if ([self.type isEqualToString:@"0"]) {
        _alertView.oneReasonLab.text =@"该宴会厅已经确认被预留或已交定金";
        _alertView.twoReasonLab.text =@"该宴会厅因装修或其他原因";

    }else{
        _alertView.oneReasonLab.text =@"该单间已经被预订";
        _alertView.twoReasonLab.text =@"该单间因装修或其他原因";
        
    }
    [_alertView.oneReasonBtn addTarget:self action:@selector(oneReasonBtnClick) forControlEvents:UIControlEventTouchUpInside];
 [_alertView.twoReasonBtn addTarget:self action:@selector(twoReasonBtnClick) forControlEvents:UIControlEventTouchUpInside];    [_alertView.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView.sureBtn addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
    [WPAlertControl alertForView:view1 begin:WPAlertBeginCenter end:WPAlertEndCenter animateType:WPAlertAnimateBounce constant:0 animageBeginInterval:0.3 animageEndInterval:0.3 maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] pan:NO rootControl:self maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
        return YES;
    } animateStatus:nil];
    
}
-(void)oneReasonBtnClick{
    if ([self.type isEqualToString:@"0"]) {
        canclereaStr =@"该宴会厅已经确认被预留或已交定金";

    }else{
        canclereaStr =@"该单间已经被预订";

    }
    [_alertView.oneReasonBtn setImage:[UIImage imageNamed:@"cancle_xuanze"] forState:UIControlStateNormal];
    [_alertView.twoReasonBtn setImage:[UIImage imageNamed:@"cancle_weixuan"] forState:UIControlStateNormal];

}
-(void)twoReasonBtnClick{
    if ([self.type isEqualToString:@"0"]) {
        canclereaStr =@"该宴会厅因装修或其他原因";
        
    }else{
        canclereaStr =@"该单间因装修或其他原因";
        
    }
    [_alertView.oneReasonBtn setImage:[UIImage imageNamed:@"cancle_weixuan"] forState:UIControlStateNormal];
    [_alertView.twoReasonBtn setImage:[UIImage imageNamed:@"cancle_xuanze"] forState:UIControlStateNormal];
}
-(void)sureclick{
    //确定

     [self updateStateRequestWithtype:@"2" WithDES:canclereaStr];
    
}
-(void)cancleBtnClick{
    NSLog(@"取消");
    [WPAlertControl alertHiddenForRootControl:self completion:nil];
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

#pragma mark***********************网络请求*********************

- (void)GetyhtdetailRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetlReserveInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =self.Id;
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"%@",object);
            
            tingName =[object objectForKey:@"BanquetName"];
            dingjinStateStr =[object objectForKey:@"EarnestType"];
            if ([self.ReceiptType isEqualToString:@"2"]) {
                //拒单
                topview.topcolorView.backgroundColor =RGB(207, 207, 207);
                topview.stateLab.text =@"订单已取消";
                topview.stateLab.textColor =GrayColor;
                acceptBtn.hidden =YES;
                bianView.hidden =YES;
                 cancleBtn.hidden =YES;
            }else if([self.ReceiptType isEqualToString:@"1"]){
                //已接单
                //                topview.backgroundColor =RGB(255, 50, 117);
                topview.stateLab.text =@"订单已接收";
                acceptBtn.hidden =YES;
                bianView.hidden =YES;
                     cancleBtn.hidden =YES;
            }else{
                //未接单
//                topview.backgroundColor =RGB(255, 50, 117);
                if ([dingjinStateStr integerValue]==0) {
                    topview.stateLab.text =@"未支付定金,等待接单";
               
                    
                }else{
                    topview.stateLab.text =@"已支付定金,等待接单";
                   
                }
                acceptBtn.hidden =NO;
                bianView.hidden =NO;
                cancleBtn.hidden =NO;
            }
            
          
            
            canbiaoStr =[object objectForKey:@"MealPrice"];
            zhuoshuStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"TableNumber"]];
            dingjinStr =[object objectForKey:@"EarnestMoney"];
            yudingrenStr =[object objectForKey:@"ScheduledPeopleName"];
            xiaoshouStr =[object objectForKey:@"RepresentativeName"];
            beizhuiStr =[object objectForKey:@"Meno"];
            yudingPhone =[object objectForKey:@"ScheduledPeoplePhone"];
            xiaoshouPhone =[object objectForKey:@"RepresentativePhone"];
            customerStr =[object objectForKey:@"BanquetCustomer"];
            timeStr =[object objectForKey:@"DinnerTime"];
            orderTimeStr =[object objectForKey:@"ReserveTime"];
            
            NSArray *array1 = [customerStr componentsSeparatedByString:@";"]; //从字符A中分隔成2个元素的数组
            for (NSString *str  in array1) {
                if (![str isEqualToString:@""]) {
                    NSArray *array2 = [str componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
                    customerModel *model =[customerModel new];
                    if (array2.count>0) {
                        model.shenfenStr =array2[0];
                    }
                    if (array2.count>1) {
                        model.nameStr =array2[1];
                    }
                    if (array2.count>2) {
                        model.phoneStr =array2[2];
                        phoneStr =model.phoneStr;
                    }
                    
                    topview.nameLab.text =model.nameStr;
                    topview.phoneLab.text =model.phoneStr;
                    [self.customerArray addObject:model];
                }
                
            }
            
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
-(void)updateStateRequestWithtype:(NSString*)type WithDES:(NSString*)des{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"";
    if ([self.type isEqualToString:@"0"]) {
       url = @"/api/HQOAApi/UpdateBanquetlReserveReceiptType";
    }else{
        url =@"/api/HQOAApi/UpdateSinglelReserveReceiptType";;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"ReceiptType"] = type;//0待定，1接单，2拒单
       params[@"RefundMeno"] = des;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [WPAlertControl alertHiddenForRootControl:self completion:nil];
            
            if ([type isEqualToString:@"1"]) {
                [EasyShowTextView showSuccessText:@"接单成功!"];

            }
            if ([type isEqualToString:@"2"]) {
                [EasyShowTextView showSuccessText:@"拒单成功!"];

            }
            [self performSelector:@selector(backVC) withObject:nil afterDelay:1];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
//单间
- (void)GetdanjiandetailRequest{
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
            
            if ([[object objectForKey:@"Type"]integerValue] ==0) {
                yongcanstyleStr =@"午餐";
            }else{
                yongcanstyleStr =@"晚餐";
            }
            zhuoshuStr =[object objectForKey:@"PeopleNumber"];
            
            timeStr =[object objectForKey:@"DinnerTime"];
            orderTimeStr =[object objectForKey:@"ReserveTime"];
            if ([self.ReceiptType isEqualToString:@"2"]) {
                //拒单
                topview.topcolorView.backgroundColor =RGB(207, 207, 207);
                topview.stateLab.text =@"订单已取消";
                topview.stateLab.textColor =GrayColor;
                acceptBtn.hidden =YES;
                bianView.hidden =YES;
                cancleBtn.hidden =YES;
            }else if([self.ReceiptType isEqualToString:@"1"]){
                //已接单
                //                topview.backgroundColor =RGB(255, 50, 117);
                topview.stateLab.text =@"订单已接收";
                acceptBtn.hidden =YES;
                bianView.hidden =YES;
                cancleBtn.hidden =YES;
            }else{
                //未接单
                //                topview.backgroundColor =RGB(255, 50, 117);
                if ([dingjinStateStr integerValue]==0) {
                    topview.stateLab.text =@"等待接单";
                    
                    
                }else{
                    topview.stateLab.text =@"等待接单";
                    
                }
                acceptBtn.hidden =NO;
                bianView.hidden =NO;
                cancleBtn.hidden =NO;
            }
            
            
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
                    topview.nameLab.text =model.nameStr;
                    topview.phoneLab.text =model.phoneStr;
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    if(buttonIndex == 1 && alertView.tag == 1001) {
        
        
        [self updateStateRequestWithtype:@"1" WithDES:@""];
    }
}
@end
