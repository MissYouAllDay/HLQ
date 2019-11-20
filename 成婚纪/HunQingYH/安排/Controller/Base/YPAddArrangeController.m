//
//  YPAddArrangeController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddArrangeController.h"
#import "YPAddArrangeTitleCell.h"
#import "YPAddArrangeSelectCell.h"
#import "UITextView+WZB.h"
#import "WSDatePickerView.h"

@interface YPAddArrangeController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//标题
@property (nonatomic, strong) UITextField *titleTF;
//简介
@property (nonatomic, strong) UITextView *inputView;

@end

@implementation YPAddArrangeController{
    UIView *_navView;
    CGFloat _cellHeight;
    NSInteger editFlag; //0未编辑  1 已经编辑
    
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.anpaiNeiRong isEqualToString:@""] || !self.anpaiNeiRong) {
        _cellHeight = 50;
    }else{
        _cellHeight =[self getHeighWithTitle:self.anpaiNeiRong font:kBigFont width:ScreenWidth-100]+30;
    }
    editFlag =0;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"添加安排";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPAddArrangeTitleCell *cell = [YPAddArrangeTitleCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"安排标题";
        if ([self.leixingStr isEqualToString:@"1"]) {//新增
                cell.inputTF.placeholder = @"请输入安排标题";
        }else{
            cell.inputTF.text =self.anpaiTitle;
        }
   
        self.titleTF = cell.inputTF;
        return cell;
    }else if (indexPath.row == 1) {
        YPAddArrangeSelectCell *cell = [YPAddArrangeSelectCell cellWithTableView:tableView];
        cell.titleLabel.text = @"执行时间";
        if (self.selectTime.length > 0) {
            cell.time.text = self.selectTime;
        }else{
            cell.time.text = @"请选择时间";
        }
        return cell;
    }else if (indexPath.row == 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"安排内容";
        label.textColor = GrayColor;
        [label setFont:[UIFont systemFontOfSize:17]];
        
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.centerY.mas_equalTo(cell.contentView);
         
        }];
      
        if ([self.leixingStr isEqualToString:@"1"]) {//新增
            
            self.inputView.wzb_placeholder = @"请输入安排内容";
            
            self.inputView.wzb_placeholderColor = LightGrayColor;
            
            
        }else   {
            
            self.inputView.text =self.anpaiNeiRong;
            self.inputView.textColor = [UIColor blackColor];
        }

        [cell.contentView addSubview:self.inputView];

        NSLog(@"%lf",_cellHeight);
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(cell.contentView).mas_offset(100);
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.height.mas_equalTo(_cellHeight);
        }];
       
//        __weak typeof (self) weakSelf = self;
//        if (editFlag ==0) {
//            [weakSelf.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(_cellHeight);
//            }];
//            
//        }else{
//            [weakSelf.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(_cellHeight);
//            }];
//        }
//        // 最大高度为100，监听高度改变的block
//        [self.inputView autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
//            
//          
//            
//            _cellHeight = currentTextViewHeight;
//            editFlag =1;
//            NSLog(@"=================");
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            
//            
//        }];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (indexPath.row == 2) {
       
        return _cellHeight;
        
        
    }else{
        
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            NSLog(@"选择的年月日：%@",date);
      
              self.selectTime = date;
            
            
            [self.tableView reloadData];
            
        }];
        datepicker.doneButtonColor = NavBarColor;
        datepicker.dateLabelColor = NavBarColor;
        
        [datepicker show];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if (self.titleTF.text.length == 0) {
        Alertmsg(@"请输入标题", nil)
    }else if (self.selectTime.length == 0){
        Alertmsg(@"请选择时间", nil)
    }else if (self.inputView.text.length == 0){
        Alertmsg(@"请输入简介", nil)
    }else{

        if (CheShou(Profession_New)) {//9.25 修改 车手可添加安排
            if ([self.leixingStr isEqualToString:@"1"]) {
                [self AddDriverSchedule];
            }else if ([self.leixingStr isEqualToString:@"2"]){
                [self UpDriverSchedule];
            }
        }else{
            if ([self.leixingStr isEqualToString:@"1"]) {
                [self AddSupplierSchedule];
            }else if ([self.leixingStr isEqualToString:@"2"]){
                [self xiugaiRequest];
            }
        }
    }
}

#pragma mark - getter
- (UITextView *)inputView{
    if (!_inputView) {
        _inputView = [[UITextView alloc]init];
        // 设置文本框占位图文字
  
        _inputView.font = kBigFont;
        _inputView.wzb_minHeight = 50;
        
        _inputView.delegate = self;
       
      
    }
        return _inputView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 150) {
        textView.textColor = [UIColor redColor];
        Alertmsg(@"您输入的字数超出已限制", nil)
    }else{
        _cellHeight =[self getHeighWithTitle:textView.text font:kBigFont width:ScreenWidth -100]+30;
//
        textView.textColor = BlackColor;
        self.anpaiNeiRong =textView.text;
      

    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView ==self.inputView) {
//        self.inputView.height =_cellHeight;
        
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_equalTo(_cellHeight);
                        }];
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        //        // 最大高度为100，监听高度改变的block
//                [_inputView autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
//        
//        
//        
//                    _cellHeight = currentTextViewHeight;
//                    editFlag =1;
//                    NSLog(@"=================");
//                    
//                    //一个cell刷新
//                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
//                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//                }];
        
     
        
    }
}
#pragma mark - 网络请求
#pragma mark 供应商添加档期
- (void)AddSupplierSchedule{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddSupplierSchedule";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierTime"] = self.selectTime;
    params[@"LogContent"] = self.inputView.text;
    params[@"Title"] = self.titleTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText: @"添加成功!"];
            //block传值
            if (self.wanchengBlock) {
                self.wanchengBlock(@"完成");
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}
#pragma mark 供应商修改档期
- (void)xiugaiRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpSupplierSchedule";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierTime"] = self.selectTime;
    params[@"LogContent"] = self.inputView.text;
    params[@"Title"] = self.titleTF.text;
    params[@"ScheduleID"] = [NSString stringWithFormat:@"%zd",self.ScheduleID];
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"修改成功!"];
            //block传值
            if (self.wanchengBlock) {
                self.wanchengBlock(@"完成");
            }
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 车手添加档期
- (void)AddDriverSchedule{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddDriverSchedule";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"DriverID"] = UserId_New;
    params[@"SupplierTime"] = self.selectTime;
    params[@"LogContent"] = self.inputView.text;
    params[@"Title"] = self.titleTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"添加成功!"];
            //block传值
            if (self.wanchengBlock) {
                self.wanchengBlock(@"完成");
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}
#pragma mark 车手修改自己添加的档期
- (void)UpDriverSchedule{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpDriverSchedule";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"DriverID"] = UserId_New;
    params[@"SupplierTime"] = self.selectTime;
    params[@"LogContent"] = self.inputView.text;
    params[@"Title"] = self.titleTF.text;
    params[@"ScheduleID"] = [NSString stringWithFormat:@"%zd",self.ScheduleID];
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            [EasyShowTextView showSuccessText:@"修改成功!"];
            //block传值
            if (self.wanchengBlock) {
                self.wanchengBlock(@"完成");
            }
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
