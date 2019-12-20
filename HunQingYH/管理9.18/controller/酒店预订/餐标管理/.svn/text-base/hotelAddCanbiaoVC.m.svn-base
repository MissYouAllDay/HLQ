//
//  hotelAddCanbiaoVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelAddCanbiaoVC.h"
#import "hotelAddButtonCell.h"
#import "hoteaddInputCell.h"
#import "hotelAddOnlyInputCell.h"
#import "YPGetBanquetHallList.h"
#import "WTTableAlertView.h"

@interface hotelAddCanbiaoVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *thisTableView;
   
    
}
@property(nonatomic,strong)NSMutableArray  *dataArray;
/**宴会厅数组*/
@property(nonatomic,strong)NSMutableArray  *tingArray;
@end

@implementation hotelAddCanbiaoVC

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
    if ([self.Id isEqualToString:@""]||!self.Id) {
 
        //添加
        _price =@"";
        _tingName =@"";
        [self addData];

    }else{
        //修改
        [self GetdetailList];
        [self createBottomView];
    }

    [self createUI];

}

- (void)createNav {
    self.view.backgroundColor=CHJ_bgColor ;
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
    if ([self.Id isEqualToString:@""]||!self.Id) {
        
        //添加
        titleLab.text = @"添加餐标";

        
    }else{
        //修改
        titleLab.text = @"编辑餐标";

    }
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.font =kFont(15);
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
}

#pragma mark --------------------- target---------------------
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveClick{
    if ([_tingName isEqualToString:@""]) {
        [EasyShowTextView showText:@"请输入名称"];
    }else  if ([_price isEqualToString:@""]) {
        [EasyShowTextView showText:@"请输入价格"];
    }else{
        
        if ([self.Id isEqualToString:@""]||!self.Id) {
                [self addRequest];

            
        }else{
            //修改
            [self editRequest];
        }
    
    }
}
-(void)addData{
    [self.dataArray addObject:@""];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [thisTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)delClick{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除该餐标？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
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




-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.estimatedRowHeight =150;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
}
-(void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];
    UIButton *delBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    [delBtn setBackgroundColor:WhiteColor];
    delBtn.frame =bottomView.bounds;
    [bottomView addSubview:delBtn];
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return self.dataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            hoteaddInputCell *cell =[hoteaddInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"名称";
            cell.inputTextField.delegate =self;
            cell.inputTextField.tag =10;
            if ([self.tingName isEqualToString:@""]||!self.tingName) {
                cell.inputTextField.placeholder=@"请输入名称";
            }else{
                cell.inputTextField.text =self.tingName;
            }
            return cell;
        }else{
            hoteaddInputCell *cell =[hoteaddInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"价格";
            if ([self.price isEqualToString:@""]||!self.tingName) {
                cell.inputTextField.placeholder=@"0.0￥";
            }else{
                cell.inputTextField.text =self.price;
            }
            cell.inputTextField.delegate =self;
            cell.inputTextField.tag =11;
            return cell;
        }

    }else{
        hotelAddOnlyInputCell *cell =[hotelAddOnlyInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.inputTextField.delegate =self;
        cell.inputTextField.tag =(indexPath.section+1)*10+indexPath.row;
        NSString *str  =self.dataArray[indexPath.row];
            if ([str isEqualToString:@""]) {
                cell.inputTextField.placeholder =@"请输入菜品名称";
            }else{
                cell.inputTextField.text =str;
            }
        
        return cell;
    }

}

#pragma mark ----------------tableviewDelegate------------------

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return nil;
    }else{
        UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headerView.backgroundColor =WhiteColor;
        
        UILabel *titleLab =[[UILabel alloc]init];
        titleLab.text =@"菜品";
        [headerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(headerView.mas_left).offset(15);
        }];
        
        UIButton *addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"继续添加" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitleColor:MainColor forState:UIControlStateNormal];
        addBtn.titleLabel.font =kFont(15);
        [headerView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.right.mas_equalTo(headerView.mas_right);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        return headerView;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag ==10){
        _tingName =textField.text;
    }else  if (textField.tag ==11) {
        _price =textField.text;
    }else{
        NSInteger tagnum =textField.tag%20;
        [self.dataArray replaceObjectAtIndex:tagnum withObject:textField.text];
        
    }
}

#pragma mark -------------------网络请求-------------------

//添加宴会厅
-(void)addRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateBanquetMealTable";
    NSString *str =[NSString new];
    for (int i =0; i<self.dataArray.count; i++) {
        if (i==0) {
            str =[str stringByAppendingString:_dataArray[i]];
        }else{
            str =[str stringByAppendingString:[NSString stringWithFormat:@",%@",_dataArray[i]]];
        }
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BanquetId"] =_tingID;
    params[@"Name"] = _tingName;
    params[@"Price"] =_price;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    params[@"Menu"] = str;
    NSLog(@"餐标参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showText:@"添加成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
- (void)GetdetailList{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetlMealMenu";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =self.Id;
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"宴会厅列表返回%@",object);
            self.tingName =[object objectForKey:@"Name"];
            self.price =[object objectForKey:@"Price"];
            self.Menu =[object objectForKey:@"Menu"];
            NSArray *arr=[_Menu componentsSeparatedByString:@","];
            self.dataArray =[NSMutableArray arrayWithArray:arr];
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


- (void)editRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdateBanquetMealTable";
    NSString *str =[NSString new];
    for (int i =0; i<self.dataArray.count; i++) {
        if (i==0) {
            str =[str stringByAppendingString:_dataArray[i]];
        }else{
            str =[str stringByAppendingString:[NSString stringWithFormat:@",%@",_dataArray[i]]];
        }
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =_Id;
    params[@"Name"] = _tingName;
    params[@"Price"] =_price;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    params[@"Menu"] = str;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showText:@"修改成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
-(void)delteRequest{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/DeleteBanquetMealTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"BanquetId"] =self.tingID;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            
            [EasyShowTextView showText:@"删除成功!"];
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
