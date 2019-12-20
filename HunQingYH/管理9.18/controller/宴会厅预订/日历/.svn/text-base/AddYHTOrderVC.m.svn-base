//
//  AddYHTOrderVC.m
//  HunQingYH
//
//  Created by xl on 2019/6/21.
//  Copyright © 2019 xl. All rights reserved.
//

#import "AddYHTOrderVC.h"
#import "hotelAddButtonCell.h"
#import "orderAddTitleClickCell.h"
#import "hoteaddInputCell.h"
#import "hotelAddCheckBoxCell.h"
#import "hotelAddTextAreaCell.h"
#import "customerModel.h"
#import "yhtAddTwoBtnCell.h"
#import <BRPickerView.h>
#import "WTTableAlertView.h"
#import "canbiaoModel.h"
#import "yuangongModel.h"
@interface AddYHTOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>{
    UITableView *thisTableview;
    UILabel *tingnameLab;
    UILabel *timeLab;
    NSString *starTimeStr;
    NSString *endTimeStr;
    NSString *canbiaoStr;
    NSString *zhifuTimeStr;
    NSString *yudingRenStr;
    NSString *xiaoShouStr;
    NSString *yudingID;
    NSString *xiaoshouID;
    NSString *zhuoshuStr;
    NSString *jineStr;
    NSString *beizhustr;
    NSString *canbiaoID;
    NSString *zhifuState;
    NSString *yudingTimestr;
    
}
/**客户数组*/
@property(nonatomic,strong)NSMutableArray   *customerArray;
/**<#注释#>*/
@property(nonatomic,strong)NSMutableArray  *canbiaoArray;
/**<#注释#>*/
@property(nonatomic,strong)NSMutableArray  *shenfenArray;
@end

@implementation AddYHTOrderVC
-(NSMutableArray *)shenfenArray{
    if (_shenfenArray) {
        _shenfenArray =[NSMutableArray array];
    }
    return _shenfenArray;
}
-(NSMutableArray *)canbiaoArray{
    if (_canbiaoArray) {
        _canbiaoArray =[NSMutableArray array];
    }
    return _canbiaoArray;
}
-(NSMutableArray *)customerArray{
    if (!_customerArray) {
        _customerArray =[NSMutableArray array];
    }
    return _customerArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =WhiteColor;
    if ([self.formType integerValue]==1) {
        [self GetdetailRequest];
    }else{
        [self addCustomer];
        starTimeStr =@"开始时间";
        endTimeStr =@"结束时间";
        canbiaoStr =@"请选择餐标";
        zhifuTimeStr =@"请选择支付时间";
        xiaoShouStr=@"请选择销售人员";
        yudingRenStr =@"请选择预订人员";
        beizhustr =@"";
        zhifuState =@"0";
    }
   
    [self createNav];
    [self createUI];
    [self GetCanbiaoListRequestWithID:self.tingID];

}
-(void)addCustomer{
    customerModel *custmodel =[customerModel new];
    custmodel.shenfenStr =@"身份";
    [self.customerArray addObject:custmodel];

}
- (void)createNav {
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
    if ([self.formType integerValue]==1) {
        titleLab.text = @"编辑";

    }else{
        titleLab.text = @"添加预订";

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
    saveBtn.titleLabel.font =kFont(15);
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
}
-(void)createUI{
    thisTableview =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    thisTableview.delegate =self;
    thisTableview.dataSource =self;
    thisTableview.estimatedRowHeight =150;
    thisTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    thisTableview.tableHeaderView =[self addtableHeaderView];
    [self.view addSubview:thisTableview];
    
    
}
#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section==1){
        return  self.customerArray.count;
    }else if (section==2){
        return 3;
    }else if(section==3){
        if ([zhifuState integerValue]==0) {
            //未交
            return 1;
        }else{
            return 3;
        }

    }else if(section==4){
        return 2;
    }
    else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text =@"宴会类型";
        cell.desLab.text=@"婚宴";
        return cell;
    }else if (indexPath.section ==1){
        //客户
        orderAddTitleClickCell *cell =[orderAddTitleClickCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleBtn.tag =indexPath.row;
        cell.model =_customerArray[indexPath.row];
        cell.oneTextField.delegate =self;
        cell.twoTextField.delegate =self;
        cell.oneTextField.tag =100+indexPath.row;
        cell.twoTextField.tag =200+indexPath.row;
        cell.twoTextField.keyboardType =UIKeyboardTypeNumberPad;
        [cell.titleBtn addTarget:self action:@selector(shenfencClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section ==2){
        if (indexPath.row==0) {
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"时间";
            cell.desLab.text =starTimeStr;
            return cell;
//            yhtAddTwoBtnCell *cell =[yhtAddTwoBtnCell cellWithTableView:tableView];
//            [cell.startTimeBtn setTitle:starTimeStr forState:UIControlStateNormal];
//            [cell.startTimeBtn addTarget:self action:@selector(startTimeClick) forControlEvents:UIControlEventTouchUpInside];
//            [cell.endTimeBtn setTitle:endTimeStr forState:UIControlStateNormal];
//            [cell.endTimeBtn addTarget:self action:@selector(endTimeClick) forControlEvents:UIControlEventTouchUpInside];
//            return cell;
        }else if (indexPath.row ==1){
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"餐标";
            cell.desLab.text =canbiaoStr;
            return cell;
        }else{
            hoteaddInputCell *cell =[hoteaddInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"桌数";
            cell.inputTextField.placeholder =@"请输入桌数";
            cell.inputTextField.keyboardType =UIKeyboardTypeNumberPad;
            cell.inputTextField.delegate =self;
            cell.inputTextField.tag =1;
            cell.inputTextField.text =zhuoshuStr;
            return cell;
        }
      
    }else if (indexPath.section==3){
                if ([zhifuState integerValue]==0) {
                    hotelAddCheckBoxCell *cell =[hotelAddCheckBoxCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if ([zhifuState integerValue]==0) {
                        //未交
                        [cell.weixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
                        [cell.yixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
                        
                    }else{
                        [cell.weixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
                        [cell.yixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
                        
                    }
                    [cell.yixuanBtn addTarget:self action:@selector(yizhifuClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.weixuanBtn addTarget:self action:@selector(weizhifuClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }else{
                    if (indexPath.row ==0) {
                        hotelAddCheckBoxCell *cell =[hotelAddCheckBoxCell cellWithTableView:tableView];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        if ([zhifuState integerValue]==0) {
                            //未交
                            [cell.weixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
                            [cell.yixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
                            
                        }else{
                            [cell.weixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
                            [cell.yixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
                            
                        }
                        [cell.yixuanBtn addTarget:self action:@selector(yizhifuClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.weixuanBtn addTarget:self action:@selector(weizhifuClick:) forControlEvents:UIControlEventTouchUpInside];
                        return cell;
                    }else if (indexPath.row==1){
                        hoteaddInputCell *cell =[hoteaddInputCell cellWithTableView:tableView];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.titleLab.text =@"金额";
                        cell.inputTextField.delegate =self;
                        cell.inputTextField.tag =2;
                        cell.inputTextField.text =jineStr;
                        return cell;
                        
                    }else{
                        hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.titleLab.text =@"支付时间";
                        cell.desLab.text =zhifuTimeStr;
                        return cell;
                        
                    }
                }
       
    }else if (indexPath.section==4){
        if (indexPath.row==0) {
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"预订人员";
            cell.desLab.text =yudingRenStr;
            return cell;
        }else{
            hotelAddButtonCell *cell =[hotelAddButtonCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text =@"销售代表";
            cell.desLab.text =xiaoShouStr;
            return cell;
        }
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
    
    if (indexPath.section ==2) {
        if (indexPath.row ==0) {
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeTime defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
                
                starTimeStr =selectValue;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
                [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
            }];
        }
        if (indexPath.row ==1) {
            NSLog(@"点击餐标");
            NSMutableArray *arr =[NSMutableArray array];
            for (canbiaoModel *model in _canbiaoArray) {
                [arr addObject:model.Price];
            }
            WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择餐标" options:arr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
                for (id obj in options) {
                    NSLog(@"单选，且隐藏确定按钮:%@", obj);
                    NSInteger index =[obj integerValue];
                    canbiaoStr =arr[index];
                    canbiaoModel *mo =_canbiaoArray[index];
                    canbiaoID =mo.Id;
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
                    [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    
                    //            [selectview.areaBtn setTitle:tingArr[index] forState:UIControlStateNormal];
                    
                }
                
            }];
            alertview.hiddenConfirBtn = YES;
            [alertview show];
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==2) {
            //支付时间
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
                zhifuTimeStr = selectValue;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:3];
                [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
            }];
        }
    }
    if (indexPath.section ==4) {
        if (indexPath.row==0) {
            NSLog(@"点击预订人员");
            if ([self.formType integerValue] ==1) {
                [EasyShowTextView showText:@"预订人员不支持修改"];
            }else{
                [self GetListWithId:@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2"];

            }


        }else{
            NSLog(@"点击销售人员");
            if ([self.formType integerValue] ==1) {
                [EasyShowTextView showText:@"销售人员不支持修改"];
            }else{
                [self GetListWithId:@"E420424F-98FE-4FE2-A342-D530F3893BFB"];

            }

        }
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    if (section==0||section==3||section==4||section==5) {
        UILabel *tingnameLab = [[UILabel alloc]init];
        tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        if (section ==0) {
            tingnameLab.text =@"请填写预订信息";
        }else if (section==3){
            tingnameLab.text =@"定金";
        }else if (section==4){
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
-(UIView*)addtableHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    headerView.backgroundColor =WhiteColor;
    tingnameLab = [[UILabel alloc]init];
    tingnameLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    tingnameLab.text =_tingName;
    [headerView addSubview:tingnameLab];
    [tingnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(headerView.mas_left).offset(15);
    }];
    
    timeLab = [[UILabel alloc]init];
    timeLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    
    
    NSString *currentDateString = [[self dateFormatter] stringFromDate:_timeDate];

 
    timeLab.text =currentDateString;
    [headerView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.right.mas_equalTo(headerView.mas_right).offset(-15);
    }];
    
    return headerView;
}
#pragma mark ---------------- target----------------
-(void)saveClick{
    if ([self.formType integerValue]==1) {
        [self editRequest];
    }else{
        customerModel *model =self.customerArray[0];
        
            if ([model.shenfenStr isEqualToString:@"身份"]|!model.shenfenStr) {
                 [EasyShowTextView showText:@"请选择客户身份"];
            }else if([model.nameStr isEqualToString:@""]||!model.nameStr){
                [EasyShowTextView showText:@"请输入客户姓名"];

            }else if ([model.phoneStr isEqualToString:@""]||!model.phoneStr){
                [EasyShowTextView showText:@"请输入客户手机"];

            }else if (!starTimeStr||[starTimeStr isEqualToString:@"开始时间"]){
            [EasyShowTextView showText:@"请选择时间"];

        }else if (!canbiaoID){
            [EasyShowTextView showText:@"请选择餐标"];

        }else if (!zhuoshuStr||[zhuoshuStr isEqualToString:@""]){
            [EasyShowTextView showText:@"请选择输入桌数"];
            
        }else{
            [self saveRequest];

        }
        

    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==1) {
        zhuoshuStr =textField.text;
    }
    if (textField.tag ==2) {
        jineStr =textField.text;
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
            [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
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
    [thisTableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
//开始时间
-(void)startTimeClick{
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeTime defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
       
        starTimeStr =selectValue;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
        [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}
//结束时间
-(void)endTimeClick{
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeTime defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        endTimeStr = selectValue;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
        [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];    }];
}
//已支付
-(void)yizhifuClick:(id)sender{
    //获取点击的cell
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [thisTableview indexPathForCell:cell];
    hotelAddCheckBoxCell *cell1 = [thisTableview cellForRowAtIndexPath:path];
    [cell1.yixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
    [cell1.weixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    zhifuState =@"1";
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
    [thisTableview reloadSections:indexSet withRowAnimation:NO];
}
//未支付
-(void)weizhifuClick:(id)sender{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [thisTableview indexPathForCell:cell];
    hotelAddCheckBoxCell *cell1 = [thisTableview cellForRowAtIndexPath:path];
    [cell1.yixuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    [cell1.weixuanBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
    zhifuState =@"0";
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
    [thisTableview reloadSections:indexSet withRowAnimation:NO];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)GetCanbiaoListRequestWithID:(NSString*)Id{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetMealTable";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"BanquetId"] =Id;
    
    
    NSLog(@"餐标参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"餐标%@",object);
            //
            self.canbiaoArray = [canbiaoModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
         
            
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
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:4];
                        [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:4];
                        [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
        str =[str stringByAppendingString:[NSString stringWithFormat:@"%@,%@,%@;",model.shenfenStr,model.nameStr,model.phoneStr]];
        
    }
    
    
    NSString *url = @"/api/HQOAApi/CreateBanquetlReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BanquetId"] = self.tingID;

    params[@"BanquetCustomer"] =str;//新郎,姓名,手机号;新娘,姓名,手机号;(分号)
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self.timeDate];
    params[@"ReserveTime"] =strDate;
    params[@"Type"] =@"婚宴";
    params[@"DinnerTime"] = starTimeStr;
    params[@"MealId"] = canbiaoID;
    params[@"TableNumber"] = zhuoshuStr;
    params[@"EarnestType"] = zhifuState;//0未缴纳,1已缴纳
    params[@"EarnestMoney"] = jineStr;
    params[@"EarnestTime"] = zhifuTimeStr;
    params[@"Meno"] = beizhustr;
    params[@"ScheduledPeopleId"] = yudingID;
    params[@"RepresentativeId"] = xiaoshouID;
    params[@"Source"] = @"1";//0个人,1酒店自身
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    
    NSLog(@"添加参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"添加成功!"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"rilireload" object:self];
            [self.navigationController popViewControllerAnimated:YES];
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
            
            _tingName =[object objectForKey:@"BanquetName"];
            tingnameLab.text =_tingName;
            canbiaoStr =[object objectForKey:@"MealPrice"];
            zhuoshuStr =[NSString stringWithFormat:@"%@",[object objectForKey:@"TableNumber"]];
            jineStr =[object objectForKey:@"EarnestMoney"];
            yudingRenStr =[object objectForKey:@"ScheduledPeopleName"];
            xiaoShouStr =[object objectForKey:@"RepresentativeName"];
//            yudingID =[object objectForKey:@"ScheduledPeopleName"];
            beizhustr =[object objectForKey:@"Meno"];
            zhifuState =[object objectForKey:@"EarnestType"];
            zhifuTimeStr =[object objectForKey:@"EarnestTime"];
            starTimeStr =[object objectForKey:@"DinnerTime"];
            yudingTimestr =[object objectForKey:@"ReserveTime"];
            timeLab.text =yudingTimestr;
            canbiaoID =[object objectForKey:@"MealId"];
                 NSString    *customerStr =[object objectForKey:@"BanquetCustomer"];

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
                    }

                    [self.customerArray addObject:model];
                }

            }
            
            [thisTableview reloadData];
//
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
        str =[str stringByAppendingString:[NSString stringWithFormat:@"%@,%@,%@;",model.shenfenStr,model.nameStr,model.phoneStr]];
        
    }
    
    
    NSString *url = @"/api/HQOAApi/UpdateBanquetlReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.Id;
    params[@"ReserveTime"] =yudingTimestr;
    params[@"DinnerTime"] = starTimeStr;
    params[@"MealId"] = canbiaoID;
    params[@"TableNumber"] = zhuoshuStr;
    params[@"EarnestType"] = zhifuState;//0未缴纳,1已缴纳
    if ([zhifuState integerValue]==0) {
        //未交
        params[@"EarnestMoney"] = @"";
        params[@"EarnestTime"] = @"";
    }else{
        params[@"EarnestMoney"] = jineStr;
        params[@"EarnestTime"] = zhifuTimeStr;
    }

    params[@"Meno"] = beizhustr;
    params[@"BanquetCustomer"] =str;//新郎,姓名,手机号;新娘,姓名,手机号;(分号)
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    
    NSLog(@"修改参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
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
