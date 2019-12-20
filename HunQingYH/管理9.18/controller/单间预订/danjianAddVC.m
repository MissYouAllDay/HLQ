//
//  danjianAddVC.m
//  HunQingYH
//
//  Created by xl on 2019/7/8.
//  Copyright © 2019 xl. All rights reserved.
//

#import "danjianAddVC.h"
#import "orderAddTitleClickCell.h"
#import "customerModel.h"
#import "WTTableAlertView.h"
#import "hotelAddButtonCell.h"
#import "hoteaddInputCell.h"
#import "hotelAddTextAreaCell.h"
#import <BRPickerView.h>
#import "yuangongModel.h"
@interface danjianAddVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *thisTableView;
    UILabel *tingnameLab;
    UILabel *timeLab ;
    
    NSString *renshuoStr;
    NSString *TimeStr;
    NSString *yudingRenStr;
    NSString *xiaoShouStr;
    NSString *yudingID;
    NSString *xiaoshouID;
    NSString *zhuoshuStr;
    NSString *beizhustr;
    NSString *yudingtimeStr;
}
/**客户数组*/
@property(nonatomic,strong)NSMutableArray   *customerArray;
@property(nonatomic,strong)NSMutableArray  *shenfenArray;
@end

@implementation danjianAddVC
-(NSMutableArray *)shenfenArray{
    if (_shenfenArray) {
        _shenfenArray =[NSMutableArray array];
    }
    return _shenfenArray;
}
-(NSMutableArray *)customerArray{
    if (!_customerArray) {
        _customerArray =[NSMutableArray array];
    }
    return _customerArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.formType integerValue]==1) {
        [self GetdetailRequest];
    }else{
        [self addCustomer];
        renshuoStr =@"";
        beizhustr =@"";
    }

    [self createNav];
    [self createUI];
}
-(void)addCustomer{
    customerModel *custmodel =[customerModel new];
    custmodel.shenfenStr =@"身份";
    [self.customerArray addObject:custmodel];
    
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
    titleLab.text = @"添加预订";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    saveBtn.titleLabel.font =kFont(15);
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
}

-(void)createUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableView.tableHeaderView =[self addTableHeaderView];
    thisTableView.estimatedRowHeight =150;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if (section==1) {
        return self.customerArray.count;
    }else if (section==2){
        return 2;
    }else if (section==3){
        return 1;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return nil;
    }else if (indexPath.section==1) {
        orderAddTitleClickCell *cell =[orderAddTitleClickCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleBtn.tag =indexPath.row;
        cell.model =_customerArray[indexPath.row];
        cell.oneTextField.delegate =self;
        cell.twoTextField.delegate =self;
        cell.oneTextField.tag =100+indexPath.row;
        cell.twoTextField.tag =200+indexPath.row;
        cell.twoTextField.keyboardType =UIKeyboardTypeNumberPad;
        cell.titleBtn.hidden =YES;
        cell.xiaImageView.hidden =YES;
//        [cell.titleBtn addTarget:self action:@selector(shenfencClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }if (indexPath.section==2) {
        if (indexPath.row ==0) {
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"用餐时间";
            cell.desLab.text =TimeStr;
            return cell;
        }else{
            hoteaddInputCell *cell =[hoteaddInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"人数";
            cell.inputTextField.placeholder =@"请输入人数";
            cell.inputTextField.delegate =self;
            cell.inputTextField.tag =1;
            cell.inputTextField.text =renshuoStr;
            return cell;
        }
    }else if (indexPath.section==3){
   
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"预订人员";
            cell.desLab.text =yudingRenStr;
            return cell;
      
    }
    else{
        hotelAddTextAreaCell *cell =[hotelAddTextAreaCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.beizhuTextView.delegate =self;
        cell.beizhuTextView.text =beizhustr;
        return cell;
    }

}

#pragma mark ----------------tableviewDelegate------------------

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 0;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            //支付时间
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeTime defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
                TimeStr = selectValue;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
                [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
            }];
        }
    }
    if (indexPath.section ==3) {
        if (indexPath.row==0) {
            NSLog(@"点击预订人员");
            if ([self.formType integerValue]==1) {
                [EasyShowTextView showText:@"预订人员不支持修改"];
            }else{
                [self GetListWithId:@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2"];

            }
            
            
        }
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    if (section==0||section==3||section==4) {
        UILabel *tingnameLab = [[UILabel alloc]init];
        tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        if (section ==0) {
            tingnameLab.text =@"请填写预订信息";
        }else if (section==3){
            tingnameLab.text =@"其他";
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
        if (section==1) {
            UILabel *tingnameLab = [[UILabel alloc]init];
            tingnameLab.font =kFont(15);
            tingnameLab.text=@"客户";
            [headerView addSubview:tingnameLab];
            [tingnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView);
                make.left.mas_equalTo(headerView.mas_left).offset(15);
            }];
            
            UIButton *addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setTitle:@"" forState:UIControlStateNormal];
            [addBtn setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addCustomerClick) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:addBtn];
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView);
                make.right.mas_equalTo(headerView.mas_right).offset(-15);
                make.size.mas_equalTo(CGSizeMake(16, 16));
            }];
            return headerView;
        }else{
            return nil;
        }
    }
    
    
}

-(UIView*)addTableHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    headerView.backgroundColor =RGBA(246, 247, 249, 1);
    tingnameLab = [[UILabel alloc]init];
    tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    tingnameLab.text =_danjianName;
    [headerView addSubview:tingnameLab];
    [tingnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(headerView.mas_left).offset(15);
    }];
    
    timeLab = [[UILabel alloc]init];
    timeLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    
    
    NSString *currentDateString = [[self dateFormatter] stringFromDate:_timeDate];
    
    yudingtimeStr =currentDateString;
    timeLab.text =currentDateString;
    [headerView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.right.mas_equalTo(headerView.mas_right).offset(-15);
    }];
    
    return headerView;
}

#pragma mark --------------------- target---------------------
-(void)saveClick{
    
    if ([self.formType integerValue]==1) {
        [self editRequest];
    }else{
        
        customerModel *model =self.customerArray[0];
        
        if ([model.nameStr isEqualToString:@""]||[model.phoneStr isEqualToString:@""]||!model.nameStr||!model.phoneStr) {
            [EasyShowTextView showText:@"请添加客户信息"];
        }else if (!TimeStr||[TimeStr isEqualToString:@""]){
            [EasyShowTextView showText:@"请选择用餐时间"];
            
        }else if (!renshuoStr||[renshuoStr isEqualToString:@""]){
            [EasyShowTextView showText:@"请选择输入人数"];
            
        }else{
            [self saveRequest];
            
        }
        
       

    }
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy年MM月dd日";
    }
    
    return dateFormatter;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==1) {
        renshuoStr =textField.text;
    }
    
    if(textField.tag>99&&textField.tag<199){
        customerModel *model =_customerArray[textField.tag%100];
        model.nameStr =textField.text;
        NSLog(@"姓名:%@：%zd",textField.text,textField.tag%100);
    }
    if(textField.tag>199){
        customerModel *model =_customerArray[textField.tag%200];
        model.phoneStr =textField.text;
        NSLog(@"手机:%@：%zd",textField.text,textField.tag%200);
        
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    beizhustr =textView.text;
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
//身份
-(void)shenfencClick:(UIButton*)btn{
    NSLog(@"%zd",btn.tag);
    NSArray *shenfenArr=@[@"新郎",@"新娘"];
    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择身份" options:shenfenArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            customerModel *model =_customerArray[btn.tag];
            model.shenfenStr =shenfenArr[index];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:1];
            [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            //            [selectview.areaBtn setTitle:tingArr[index] forState:UIControlStateNormal];
            
        }
        
    }];
    alertview.hiddenConfirBtn = YES;
    [alertview show];
}
//添加客户
-(void)addCustomerClick{
    [self addCustomer];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [thisTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
#pragma mark-----------------------网络请求---------------------

- (void)GetListWithId:(NSString *)Id{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelPersonnelList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"IdentityId"] =Id;
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
            self.shenfenArray = [yuangongModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            if ([Id isEqualToString:@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2"]) {
                //预订
                
                NSMutableArray *arr =[NSMutableArray array];
                for (yuangongModel *model in _shenfenArray) {
                    [arr addObject:model.Name];
                }
                WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择人员" options:arr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
                    for (id obj in options) {
                        NSLog(@"单选，且隐藏确定按钮:%@", obj);
                        NSInteger index =[obj integerValue];
                        yudingRenStr =arr[index];
                        yuangongModel*selectmodel =_shenfenArray[index];
                        yudingID =selectmodel.Id;
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
                        [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        //            [selectview.areaBtn setTitle:tingArr[index] forState:UIControlStateNormal];
                        
                    }
                    
                }];
                alertview.hiddenConfirBtn = YES;
                [alertview show];
                
            }else{
                
                NSMutableArray *arr =[NSMutableArray array];
                for (yuangongModel *model in _shenfenArray) {
                    [arr addObject:model.Name];
                }
                WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择人员" options:arr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
                    for (id obj in options) {
                        NSLog(@"单选，且隐藏确定按钮:%@", obj);
                        NSInteger index =[obj integerValue];
                        xiaoShouStr =arr[index];
                        yuangongModel*selectmodel =_shenfenArray[index];
                        xiaoshouID =selectmodel.Id;
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:3];
                        [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        //            [selectview.areaBtn setTitle:tingArr[index] forState:UIControlStateNormal];
                        
                    }
                    
                }];
                alertview.hiddenConfirBtn = YES;
                [alertview show];
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

-(void)saveRequest{
    
    
    [EasyShowLodingView showLoding];
    NSString *str =@"";
    for (int i =0; i<_customerArray.count; i++) {
        customerModel *model =_customerArray[i];
        str =[str stringByAppendingString:[NSString stringWithFormat:@"%@,%@;",model.nameStr,model.phoneStr]];
        
    }
    
    
    NSString *url = @"/api/HQOAApi/CreateSinglelReserveTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BanquetCustomer"] =str;//新郎,姓名,手机号;新娘,姓名,手机号;(分号)
    params[@"SingleId"] = self.Id;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self.timeDate];
    params[@"ReserveTime"] =strDate;
    params[@"Type"] =self.type;
    params[@"DinnerTime"] = TimeStr;
    params[@"PeopleNumber"] = renshuoStr;
    params[@"Meno"] = beizhustr;
    params[@"ScheduledPeopleId"] = yudingID;
    params[@"Source"] = @"1";//0个人,1酒店自身
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    


    
    NSLog(@"添加参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {


        [EasyShowLodingView hidenLoding];

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {



            [EasyShowTextView showText:@"添加成功!"];
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

- (void)GetdetailRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSinglelReserveInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =self.recordId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"单间详情%@",object);
//
            _danjianName =[object objectForKey:@"SingleName"];
            tingnameLab.text =_danjianName;
            yudingtimeStr =[object objectForKey:@"ReserveTime"];
            timeLab.text =yudingtimeStr;
            TimeStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"DinnerTime"]];
            renshuoStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"PeopleNumber"]];
            yudingRenStr =[object objectForKey:@"ScheduledPeopleName"];
            beizhustr =[object objectForKey:@"Meno"];



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

-(void)editRequest{
    
    
    [EasyShowLodingView showLoding];
    NSString *str =@"";
    for (int i =0; i<_customerArray.count; i++) {
        customerModel *model =_customerArray[i];
        str =[str stringByAppendingString:[NSString stringWithFormat:@"%@,%@;",model.nameStr,model.phoneStr]];
        
    }
    
    
    NSString *url = @"/api/HQOAApi/UpdateSinglelReserveTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.recordId;
    params[@"SingleId"] = self.Id;
    params[@"ReserveTime"] =yudingtimeStr;
    params[@"DinnerTime"] = TimeStr;
    params[@"PeopleNumber"] = renshuoStr;
    params[@"Meno"] = beizhustr;
    params[@"Type"] =self.type;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    params[@"BanquetCustomer"] =str;//新郎,姓名,手机号;新娘,姓名,手机号;(分号)
    


    
    
    
    
    NSLog(@"修改参数%@",params);
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

@end
