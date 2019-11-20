//
//  YPMeKeYuanFenPeiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/1.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeKeYuanFenPeiController.h"
#import "YPPassengerDistributionController.h"//18-11-06 客源分配
#import "YPMeKeYuanFenPeiListCell.h"
#import "YPMeKeYuanFenPeiRemarkCell.h"
#import "YPGetFacilitatorIdJSJTableList.h"
#import "LeeDatePickerView.h"
#import "WSTableviewTree.h"

@interface YPMeKeYuanFenPeiController ()<WSTableViewDelegate>

@property (nonatomic, strong) WSTableView *tableView;
@property (nonatomic, strong) UITableView *orderTableView;//排序

@property (nonatomic, strong) UIControl *orderControl;//排序
@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, strong) NSMutableArray *dataSourceArrM;
@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorIdJSJTableList *> *listMarr;

@end

@implementation YPMeKeYuanFenPeiController{
    UIView *_navView;
//    NSString *_startTime;
//    NSString *_endTime;
    
    UIImageView *_placeHoldImgV;
    UIButton *_applyBtn;
    
    NSInteger _orderStr;//选中综合排序 1:首次进入
    /** 0上传时间,1婚期*/
    NSString *_SortField;
    /** 0倒序,1正序*/
    NSString *_Sort;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    _orderStr = 1;//首次进入 综合排序
    self.lastPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _SortField = @"0";//发布时间
    _Sort = @"0";//倒序 近到远
    
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[WSTableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.WSTableViewDelegate = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNoDataView{
    
    if (!_placeHoldImgV) {
        _placeHoldImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"一键申请"]];
    }
    [self.view addSubview:_placeHoldImgV];
    [_placeHoldImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+100);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(240, 240));
    }];
    
    if (!_applyBtn) {
        _applyBtn = [[UIButton alloc]init];
    }
    [_applyBtn setTitle:@"前往申请" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = kFont(18);
    _applyBtn.layer.cornerRadius = 5;
    _applyBtn.clipsToBounds = YES;
    _applyBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
    _applyBtn.layer.borderWidth = 1;
    [_applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyBtn];
    [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36);
        make.right.mas_equalTo(-36);
        make.top.mas_equalTo(_placeHoldImgV.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(48);
    }];
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"timePicker"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(-15);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return [self.listMarr count];
    }else{
        return 5;
    }
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        YPGetFacilitatorIdJSJTableList *record = self.listMarr[indexPath.row];
        return record.Meno.length > 0 ? 1 : 0;
    }
    return 0;
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        WSTableviewDataModel *dataModel = self.dataSourceArrM[indexPath.row];
        return dataModel.shouldExpandSubRows;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
    
        WSTableviewDataModel *dataModel = self.dataSourceArrM[indexPath.row];
        YPGetFacilitatorIdJSJTableList *record = self.listMarr[indexPath.row];
        
        YPMeKeYuanFenPeiListCell *cell = [YPMeKeYuanFenPeiListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (record.Name.length > 0) {
            cell.titleLabel.text = record.Name;
        }else{
            cell.titleLabel.text = @"无姓名";
        }
        if (record.Identity.length > 0) {
            cell.profession.text = [NSString stringWithFormat:@"[%@]",record.Identity];
        }else{
            cell.profession.text = @"[无职业]";
        }
        if (record.Phone.length > 0) {
            cell.phoneLabel.text = record.Phone;
        }else{
            cell.phoneLabel.text = @"无手机号";
        }
        if (record.WeddingTime.length > 0) {
            cell.timeLabel.text = record.WeddingTime;
        }else{
            cell.timeLabel.text = @"无时间";
        }
        
        if (record.Meno.length > 0) {
            cell.remark.hidden = NO;
        }else{
            cell.remark.hidden = YES;
        }
        
        cell.expandable = dataModel.expandable;
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
        if (row == oldRow && self.lastPath!=nil) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"综合排序";
            cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"发布时间 近→远";
            cell.textLabel.font = kFont(14);
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"发布时间 远→近";
            cell.textLabel.font = kFont(14);
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"结婚日期 近→远";
            cell.textLabel.font = kFont(14);
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"结婚日期 远→近";
            cell.textLabel.font = kFont(14);
        }
        return cell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        YPGetFacilitatorIdJSJTableList *record = self.listMarr[indexPath.row];
        
        YPMeKeYuanFenPeiRemarkCell *cell = [YPMeKeYuanFenPeiRemarkCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentLabel.text = record.Meno;
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        YPGetFacilitatorIdJSJTableList *record = self.listMarr[indexPath.row];
        return record.Meno.length > 0 ? 110 : 80;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        YPGetFacilitatorIdJSJTableList *record = self.listMarr[indexPath.row];
        return [self getHeighWithTitle:record.Meno font:kFont(12) width:ScreenWidth-36-24];
        
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
        dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
        
        WSTableViewCell *cell = (WSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(isExpandable)]){
            if (cell.isExpandable){
                [cell accessoryViewAnimation];
            }
        }
    }else{
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath !=nil)?[self.lastPath row]:-1;
        if (newRow != oldRow) {
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            self.lastPath = indexPath;
            
            [self orderControlClick];
            if (indexPath.row == 0) {//综合排序 按发布时间-倒序(近到远) - 郝
                _SortField = @"0";
                _Sort = @"0";
                _orderStr = 1;
            }else if (indexPath.row == 1){
                _SortField = @"0";
                _Sort = @"0";
                _orderStr = 0;
            }else if (indexPath.row == 2){
                _SortField = @"0";
                _Sort = @"1";
                _orderStr = 0;
            }else if (indexPath.row == 3){
                _SortField = @"1";
                _Sort = @"0";
                _orderStr = 0;
            }else if (indexPath.row == 4){
                _SortField = @"1";
                _Sort = @"1";
                _orderStr = 0;
            }
            [self GetFacilitatorIdJSJTableListWithSortField:_SortField Sort:_Sort];
        }
    }
    
}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick{
    NSLog(@"rightBtnClick");
    
    [self.view addSubview:self.orderControl];
    
//    [LeeDatePickerView showLeeDatePickerViewWithBlock:^(NSDate *startDate, NSDate *endDate) {
//        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        NSLog(@"%@",[formatter stringFromDate:startDate]);
//        _startTime = [formatter stringFromDate:startDate];
//        NSLog(@"%@",[formatter stringFromDate:endDate]);
//        _endTime = [formatter stringFromDate:endDate];
//
//        [self GetFacilitatorIdJSJTableListWithStartTime:_startTime EndTime:_endTime];
//    }];
}

- (void)applyBtnClick{
    YPPassengerDistributionController *test = [[YPPassengerDistributionController alloc]init];
    test.typeStr = @"Me";
    [self.navigationController pushViewController:test animated:YES];
}

- (void)orderControlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.orderTableView.frame = CGRectMake(0, -44*5, ScreenWidth, 44*5);
    } completion:^(BOOL finished) {
        [self.orderTableView removeFromSuperview];
        self.orderTableView = nil;
        [_orderControl removeFromSuperview];
    }];
}

#pragma mark - 网络请求
#pragma mark 供应商获取客源数据
- (void)GetFacilitatorIdJSJTableListWithSortField:(NSString *)SortField Sort:(NSString *)Sort{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorIdJSJTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"SortField"] = SortField;
    params[@"Sort"] = Sort;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"100";
    params[@"AreaId"] = areaID_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            [self.dataSourceArrM removeAllObjects];
            
            self.listMarr = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetFacilitatorIdJSJTableList *record in self.listMarr) {
                WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                dataModel.firstLevelStr = record.Name;
                dataModel.shouldExpandSubRows = NO;
                
                [dataModel object_add_toSecondLevelArrM:record.Meno];
                [self.dataSourceArrM addObject:dataModel];
            }
            
            if (self.listMarr.count > 0) {
                if (_orderStr == 0) {
                    [self.tableView reloadData];
                }else{
                    [self setupUI];
                }
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setupNoDataView];
                });
            }
            
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

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorIdJSJTableList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray *)dataSourceArrM{
    if (!_dataSourceArrM) {
        _dataSourceArrM = [NSMutableArray array];
    }
    return _dataSourceArrM;
}

- (UIControl *)orderControl{
    if (!_orderControl) {
        _orderControl = [[UIControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        _orderControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }
    if (!self.orderTableView) {
        self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44*5, ScreenWidth, 44*5) style:UITableViewStylePlain];
    }
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    self.orderTableView.backgroundColor = WhiteColor;
    self.orderTableView.estimatedRowHeight = 0;
    self.orderTableView.estimatedSectionFooterHeight = 0;
    self.orderTableView.estimatedSectionHeaderHeight = 0;
    self.orderTableView.tableFooterView = [[UIView alloc]init];
    [_orderControl addSubview:self.orderTableView];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.orderTableView.frame = CGRectMake(0, 0, ScreenWidth, 44*5);
        [_orderControl addSubview:self.orderTableView];
    } completion:nil];
    
    [_orderControl addTarget:self action:@selector(orderControlClick) forControlEvents:UIControlEventTouchUpInside];
    return _orderControl;
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
