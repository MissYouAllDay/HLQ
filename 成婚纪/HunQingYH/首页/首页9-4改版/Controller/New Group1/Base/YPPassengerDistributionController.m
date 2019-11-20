//
//  YPPassengerDistributionController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/29.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPPassengerDistributionController.h"
#import "YPPassengerDistributionBannerCell.h"
#import "YPPassengerDistributionListCell.h"
#import "YPGetAllOccupationList.h"
#import "YPGetJSJTableList.h"

#import "FSCustomButton.h"
#import "LeeDatePickerView.h"

#define UnselectedColor RGBS(248)
#define SelectedColor RGB(250, 80, 120)

@interface YPPassengerDistributionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIControl *control;

@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业
// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray<YPGetAllOccupationList *> *lastMarr;

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSMutableArray<YPGetJSJTableList *> *listMarr;

@end

@implementation YPPassengerDistributionController{
    UIView *_navView;
    NSInteger _pageIndex;
    
    FSCustomButton *_moreBtn;//全部需求
    UIView *_moreBackView;
    CGFloat _allHeight;
    UIButton *_allBtn;
    
    NSString *_startTime;
    NSString *_endTime;
    UILabel *_timeLabel;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetJSJTableListWithIdentityID:@"" AndStartTime:@"" EndTime:@""];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    _pageIndex = 1;
    
    self.profession = @"";
    _startTime = @"";
    _endTime = @"";
    
    [self setupUI];
    [self setupNav];
    
    [self GetAllOccupationList];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-62) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(250, 80, 120)];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitBtn];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.clipsToBounds = YES;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"客源分配";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.listMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YPPassengerDistributionBannerCell *cell = [YPPassengerDistributionBannerCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.urlArr = self.imgArr;
        return cell;
    }else{
        YPGetJSJTableList *listModel = self.listMarr[indexPath.row];
        
        YPPassengerDistributionListCell *cell = [YPPassengerDistributionListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (listModel.Name.length > 0) {
            cell.titleLabel.text = listModel.Name;
        }else{
            cell.titleLabel.text = @"无姓名";
        }
        if (listModel.Identity.length > 0) {
            cell.profession.text = [NSString stringWithFormat:@"[%@]",listModel.Identity];
        }else{
            cell.profession.text = @"[无职业]";
        }
        if (listModel.Phone.length > 0) {
            cell.phoneLabel.text = listModel.Phone;
        }else{
            cell.phoneLabel.text = @"无手机号";
        }
        if (listModel.WeddingTime.length > 0) {
            cell.timeLabel.text = listModel.WeddingTime;
        }else{
            cell.timeLabel.text = @"无时间";
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ScreenWidth;
    }else{
        return 72;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 45;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        
        if (!_moreBtn) {
            _moreBtn = [[FSCustomButton alloc]init];
        }
        _moreBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
        if (self.professionName.length > 0) {
            [_moreBtn setTitle:[NSString stringWithFormat:@"%@",self.professionName] forState:UIControlStateNormal];
        }else{
            [_moreBtn setTitle:@"全部需求" forState:UIControlStateNormal];
        }
        [_moreBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
        
        [_moreBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = kFont(14);
        [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(view);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = RGBA(0, 0, 0, 0.12);
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(view);
            make.height.mas_equalTo(1);
        }];
        
        UIButton *timeBtn = [[UIButton alloc]init];
        [timeBtn setImage:[UIImage imageNamed:@"timePicker"] forState:UIControlStateNormal];
        [timeBtn addTarget:self action:@selector(timeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:timeBtn];
        [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.centerY.mas_equalTo(view);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        if (_startTime.length > 0 && _endTime.length > 0) {
            _timeLabel.hidden = NO;
        }else{
            _timeLabel.hidden = YES;
        }
        _timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@",_startTime,_endTime];
        _timeLabel.textColor = RGBA(153, 153, 153, 1);
        _timeLabel.font = kFont(12);
        [view addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(timeBtn.mas_left).mas_offset(-6);
            make.centerY.mas_equalTo(timeBtn);
        }];
        
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [self.view addSubview:self.control];
}

- (void)timeBtnClick{
    NSLog(@"timeBtnClick");
    
    [LeeDatePickerView showLeeDatePickerViewWithBlock:^(NSDate *startDate, NSDate *endDate) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSLog(@"%@",[formatter stringFromDate:startDate]);
        _startTime = [formatter stringFromDate:startDate];
        NSLog(@"%@",[formatter stringFromDate:endDate]);
        _endTime = [formatter stringFromDate:endDate];
        
        [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
    }];
}

- (void)setupRadioBtnView{
    
    CGFloat marginX = 15;
    CGFloat top = 115;
    CGFloat btnH = 40;
    CGFloat width = (ScreenWidth-18*2-2*marginX)/3.0;
    NSInteger maxCol = 3;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (YPGetAllOccupationList *model in self.lastMarr) {
        [arr addObject:model.OccupationName];
    }
    NSInteger maxRow = arr.count / maxCol; //行
    _allHeight = top + maxRow * (btnH + marginX) + marginX + btnH;
    
    if (!_moreBackView) {
        _moreBackView = [[UIView alloc]init];
    }
    _moreBackView.backgroundColor = WhiteColor;
    
    _moreBackView.frame = CGRectMake(0, -(_allHeight), ScreenWidth, _allHeight);
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreBackView.frame = CGRectMake(0, 0, ScreenWidth, _allHeight);
        [_control addSubview:_moreBackView];
    } completion:nil];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择客户需求";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_moreBackView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.centerX.mas_equalTo(_moreBackView);
    }];
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_moreBackView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label);
        make.right.mas_equalTo(-8);
    }];
    
    //全部需求
    _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.backgroundColor = UnselectedColor;
    _allBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
    _allBtn.clipsToBounds = YES;
    _allBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_allBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [_allBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
    [_allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_allBtn setTitle:@"全部需求" forState:UIControlStateNormal];
    if ([_allBtn.titleLabel.text isEqualToString:self.selectedBtn.titleLabel.text] || !self.selectedBtn) {
        _allBtn.selected = YES;
        _allBtn.enabled = NO;
        [_allBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _allBtn.backgroundColor = SelectedColor;
    }
    [_moreBackView addSubview:_allBtn];
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(width, btnH));
    }];
    
    // 循环创建按钮
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proBtn.backgroundColor = UnselectedColor;
        proBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        proBtn.clipsToBounds = YES;
        proBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [proBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
        [proBtn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger col = i % maxCol; //列
        proBtn.x = 18 + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        proBtn.y = top + row * (btnH + marginX);
        proBtn.width = width;
        proBtn.height = btnH;
        [proBtn setTitle:arr[i] forState:UIControlStateNormal];
        
        if ([proBtn.titleLabel.text isEqualToString:self.selectedBtn.titleLabel.text]) {
            proBtn.selected = YES;
            proBtn.enabled = NO;
            [proBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
            proBtn.backgroundColor = SelectedColor;
        }else{
            proBtn.selected = NO;
            proBtn.enabled = YES;
            [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
            proBtn.backgroundColor = UnselectedColor;
        }
        
        [_moreBackView addSubview:proBtn];
        proBtn.tag = i;
        [self.btnArray addObject:proBtn];
    }
}

- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);
    
    self.profession = [self.lastMarr[sender.tag] OccupationID];
    self.professionName = [self.lastMarr[sender.tag] OccupationName];
    
    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
            _allBtn.selected = NO;
            [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
            [_allBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        } else {
            btn.selected = NO;
            [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        }
        btn.backgroundColor = UnselectedColor;
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        btn.backgroundColor = SelectedColor;
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _allBtn.backgroundColor = UnselectedColor;
        [_allBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = UnselectedColor;
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    
    [self controlClick];
    
    [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
}

- (void)allBtnClick:(UIButton *)sender{
    
    self.profession = @"";
    self.professionName = @"全部需求";
    
    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        btn.selected = NO;
        btn.backgroundColor = UnselectedColor;
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    if (sender.selected) {
        sender.backgroundColor = SelectedColor;
        [sender setTitleColor:WhiteColor forState:UIControlStateNormal];
    } else {
        sender.backgroundColor = UnselectedColor;
        [sender setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    [self controlClick];
    
    [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
}

- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreBackView.frame = CGRectMake(0, -_allHeight, ScreenWidth, _allHeight);
    } completion:^(BOOL finished) {
        [self.btnArray removeAllObjects];
        [_moreBackView removeFromSuperview];
        _moreBackView = nil;
        [_control removeFromSuperview];
    }];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    [self CreateAgentApplyTable];
}

#pragma mark - 网络请求
#pragma mark 获取所有职业列表
- (void)GetAllOccupationList{

    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"2";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.lastMarr = [YPGetAllOccupationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.btnArray removeAllObjects];
            
            [self setupUI];
            
            if (self.lastMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showSuccessText:@"当前没有数据!"];
                
            }
            
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

#pragma mark 申请成为代理商
- (void)CreateAgentApplyTable{

    NSString *url = @"/api/HQOAApi/CreateAgentApplyTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = UserId_New;//传用户ID 18-10-30 窦
    params[@"Meno"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"申请成功!" inView:self.tableView];
            
            [self GetJSJTableListWithIdentityID:self.profession AndStartTime:_startTime EndTime:_endTime];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 获取客源数据
- (void)GetJSJTableListWithIdentityID:(NSString *)identity AndStartTime:(NSString *)start EndTime:(NSString *)end{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetJSJTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"IdentityId"] = identity;
    params[@"StartTime"] = start;
    params[@"EndTimeTime"] = end;
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    params[@"DistributionType"] = @"0";//0所有,1未分配,2已分配

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *str = [object valueForKey:@"Img"];
            self.imgArr = [str componentsSeparatedByString:@","];
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            [self endRefresh];
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
//        [self setupRadioBtnView];
    }
    
    [self setupRadioBtnView];
    
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        NSMutableArray *array = [NSMutableArray array];
        _btnArray = array;
        
    }
    return _btnArray;
}

- (NSMutableArray<YPGetAllOccupationList *> *)lastMarr{
    if (!_lastMarr) {
        _lastMarr = [NSMutableArray array];
    }
    return _lastMarr;
}

- (NSMutableArray<YPGetJSJTableList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
