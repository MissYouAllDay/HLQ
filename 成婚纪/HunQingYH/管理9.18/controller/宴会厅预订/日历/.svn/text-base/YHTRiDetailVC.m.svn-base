//
//  YHTRiDetailVC.m
//  HunQingYH
//
//  Created by xl on 2019/6/21.
//  Copyright © 2019 xl. All rights reserved.
//

#import "YHTRiDetailVC.h"
#import "orderOndeDesCell.h"
#import "orderTwoDesCell.h"
#import "customerModel.h"
#import "yhtcustomerCell.h"
#import "AddYHTOrderVC.h"
#import "YPMeYanHuiTingDetailMoreController.h"
@interface YHTRiDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *thisTableView;
        UILabel *tingnameLab;
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
    NSString *phoneStr;
    UIImageView *iconImageView;
 
}
/***/
@property(nonatomic,strong)NSMutableArray  *customerArray;
@end

@implementation YHTRiDetailVC
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
    phoneStr =@"";
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
    

    
}
-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.tableHeaderView=[self addtableHeaderView];
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.estimatedRowHeight =150;

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
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [editBtn setBackgroundColor:WhiteColor];
    editBtn.titleLabel.font =kFont(15);
    editBtn.clipsToBounds =YES;
    editBtn.layer.cornerRadius =5;
    editBtn.layer.borderColor =LineColor.CGColor;
    editBtn.layer.borderWidth =1;
    [editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
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
   
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.customerArray.count;
    }else if (section==1) {
        return 5;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        yhtcustomerCell *cell =[yhtcustomerCell cellWithTableView:tableView];
        cell.shenfenLab.hidden =NO;
        cell.model =self.customerArray[indexPath.row];
        return cell;
    }else if (indexPath.section ==1) {
         if (indexPath.row==0) {
             orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
             cell.titleLab.text =@"时间";
             cell.desLab.text =timeStr;
             
             return cell;
        }else if (indexPath.row==1){
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"餐标";
            cell.desLab.text =canbiaoStr;
            return cell;
        }else if (indexPath.row==2){
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"桌数";
            cell.desLab.text =zhuoshuStr;
            return cell;
        }else if (indexPath.row==3){
            orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"定金";
            cell.desLab.text =dingjinStr;

            return cell;
        }else{
            orderTwoDesCell *cell = [orderTwoDesCell cellWithTableView:tableView];
            cell.titleLab.text =@"预订人员";
            cell.shenfen1des.hidden =YES;
            cell.shenfen2des.hidden =YES;
            cell.name1des.text =yudingrenStr;
            cell.name2des.text =xiaoshouStr;
            cell.phone1des.text =yudingPhone;
            cell.phone2des.text =xiaoshouPhone;
            cell.title2Lab.text =@"销售代表";
            return cell;
        }
    }else{
        orderOndeDesCell *cell =[orderOndeDesCell cellWithTableView:tableView];
        cell.titleLab.text =beizhuiStr;
        cell.desLab.hidden =YES;
        return cell;
    }
}

#pragma mark ----------------tableviewDelegate------------------

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 0;
    }else{
        return 50;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headerView.backgroundColor =WhiteColor;
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
    }

}
-(UIView*)addtableHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    headerView.backgroundColor =WhiteColor;
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor =WhiteColor;
    [self addShadowToView:contentView withColor:TextNormalColor];
    contentView.clipsToBounds =YES;
    contentView.layer.cornerRadius =5;
    contentView.clipsToBounds =NO;
    [headerView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-60, 80));
    }];
    
    iconImageView =[[UIImageView alloc]init];
    iconImageView.image=[UIImage imageNamed:@"1024"];
    [contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView);
        make.left.mas_equalTo(contentView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    iconImageView.clipsToBounds =YES;
    iconImageView.layer.cornerRadius =5;
    
    tingnameLab = [[UILabel alloc]init];
    tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    [contentView addSubview:tingnameLab];
    [tingnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView);
        make.left.mas_equalTo(iconImageView.mas_right).offset(15);
    }];
    
    UIButton *jianBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [jianBtn setTitle:@"" forState:UIControlStateNormal];
    [jianBtn setBackgroundImage:[UIImage imageNamed:@"back_rightblack"] forState:UIControlStateNormal];
    [contentView addSubview:jianBtn];
    [jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView);
        make.right.mas_equalTo(contentView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(22, 22 ));
    }];
    headerView.userInteractionEnabled =YES;
    //添加手势
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tingclick)];
 
    [headerView addGestureRecognizer:tapGesture];
    
    [tapGesture setNumberOfTapsRequired:1];
    return headerView;
    
    
}
#pragma mark --------------------- target---------------------
-(void)tingclick{
    
    
    YPMeYanHuiTingDetailMoreController *detail = [[YPMeYanHuiTingDetailMoreController alloc]init];
    detail.BanquetID = self.tingId;
    [self.navigationController yp_pushViewController:detail animated:YES];
}
-(void)quxiaoclick{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"取消该订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
}
-(void)callClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
 
}
-(void)editClick{
    AddYHTOrderVC *addvc =[AddYHTOrderVC new];
    addvc.tingID =self.tingId;
    addvc.Id =self.Id;
    addvc.formType =@"1";
    [self.navigationController pushViewController:addvc animated:YES];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 3;
    
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
            tingnameLab.text =tingName;
            canbiaoStr =[object objectForKey:@"MealPrice"];
            zhuoshuStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"TableNumber"]];
            dingjinStr =[object objectForKey:@"EarnestMoney"];
            yudingrenStr =[object objectForKey:@"ScheduledPeopleName"];
            xiaoshouStr =[object objectForKey:@"RepresentativeName"];
            beizhuiStr =[object objectForKey:@"Meno"];
            yudingPhone =[object objectForKey:@"ScheduledPeoplePhone"];
            xiaoshouPhone =[object objectForKey:@"RepresentativePhone"];
            customerStr =[object objectForKey:@"BanquetCustomer"];
            [iconImageView sd_setImageWithURL:[NSURL URLWithString:[object objectForKey:@"BanquetImage"]]];
            timeStr =[NSString stringWithFormat:@"%@ %@",[object objectForKey:@"ReserveTime"],[object objectForKey:@"DinnerTime"]];
            
            [_customerArray removeAllObjects];
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
-(void)delteRequest{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/DeleteBanquetlReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            
            [EasyShowTextView showText:@"删除成功!"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"rilireload" object:self];
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
}
@end
