//
//  YPKeYuan190306AllController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/6.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190306AllController.h"
#import "YPPassengerDistributionBannerCell.h"
#import "YPPassegerDistribute1Cell.h"
#import "YPPassagerDistribute2Cell.h"
#import "YPGetAllOccupationList.h"
#import "YPGetJSJTableList.h"
#import "YPPassageDistributeListCell.h"
//#import "YPKeYuan190306AllListCell.h"
#import "YPKeYuan190320ReAllListCell.h"

#import "FSCustomButton.h"
#import "LeeDatePickerView.h"
#import "CJAreaPicker.h"//地址选择

#define UnselectedColor RGBS(248)
#define SelectedColor RGB(250, 80, 120)

@interface YPKeYuan190306AllController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *orderTableView;//排序

@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UIControl *orderControl;//排序
@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业
// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray<YPGetAllOccupationList *> *lastMarr;

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSMutableArray<YPGetJSJTableList *> *listMarr;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPKeYuan190306AllController{
    UIView *_navView;
    NSInteger _pageIndex;
    //数据库
    FMDatabase *dataBase;
    
    FSCustomButton *_moreBtn;//全部需求
    UIView *_moreBackView;
    CGFloat _allHeight;
    UIButton *_allBtn;
    
    //18-11-26
    FSCustomButton *_areaBtn;//区域选择
    
    FSCustomButton *_orderBtn;//综合排序
    NSInteger _orderStr;//选中综合排序
    /** 0上传时间,1婚期*/
    NSString *_SortField;
    /** 0倒序,1正序*/
    NSString *_Sort;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetJSJTableListWithIdentityID:@"" AndSortField:@"0" Sort:@"0"];
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
    _orderStr = 1;//首次进入 综合排序
    self.lastPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _SortField = @"0";//发布时间
    _Sort = @"0";//倒序 近到远
    
    [self setupUI];
    
    [self GetAllOccupationList];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return self.listMarr.count > 0 ? self.listMarr.count + 1 : 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == 0) {
            return 1;
        }else{
            return 1;
        }
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            YPPassengerDistributionBannerCell *cell = [YPPassengerDistributionBannerCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.urlArr = self.imgArr;
            [cell.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.mas_equalTo(cell.contentView);
                make.height.mas_equalTo(ScreenWidth*0.4);
            }];
            return cell;
        }else{
            if (self.listMarr.count > 0) {
                YPGetJSJTableList *listModel = self.listMarr[indexPath.section - 1];
                
                YPKeYuan190320ReAllListCell *cell = [YPKeYuan190320ReAllListCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (listModel.Source.integerValue == 0) {//0官方,1个人
                    cell.tagImgV.hidden = NO;
                }else{
                    cell.tagImgV.hidden = YES;
                }
                if (listModel.Name.length > 0) {
                    cell.titleLabel.text = listModel.Name;
                }else{
                    cell.titleLabel.text = @"无姓名";
                }
                if (listModel.Phone.length > 0) {
                    cell.phoneLabel.text = listModel.Phone;
                }else{
                    cell.phoneLabel.text = @"无手机号";
                }
                if (listModel.Identity.length > 0) {
                    cell.supplierLabel.text = listModel.Identity;
                }else{
                    cell.supplierLabel.text = @"无需求商家";
                }
                if (listModel.WeddingTime.length > 0) {
                    cell.hunqi.text = listModel.WeddingTime;
                }else{
                    cell.hunqi.text = @"无婚期";
                }
                cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",listModel.TablesNumber];
                cell.canbiao.text = [NSString stringWithFormat:@"%@元/桌",listModel.MealMark];
//                if (listModel.ApplyType.integerValue == 0) {//0未申请,1审核中,2审核通过,3审核驳回
//                    [cell.applyBtn setTitle:@"申请" forState:UIControlStateNormal];
//                    cell.applyBtn.enabled = YES;
//                }else if (listModel.ApplyType.integerValue == 1) {//0未申请,1审核中,2审核通过,3审核驳回
//                    [cell.applyBtn setTitle:@"审核中" forState:UIControlStateNormal];
//                    cell.applyBtn.enabled = NO;
//                }else if (listModel.ApplyType.integerValue == 2) {//0未申请,1审核中,2审核通过,3审核驳回
//                    [cell.applyBtn setTitle:@"审核通过" forState:UIControlStateNormal];
//                    cell.applyBtn.enabled = NO;
//                }else if (listModel.ApplyType.integerValue == 3) {//0未申请,1审核中,2审核通过,3审核驳回
//                    [cell.applyBtn setTitle:@"审核驳回" forState:UIControlStateNormal];
//                    cell.applyBtn.enabled = NO;
//                }
                cell.applyBtn.tag = indexPath.section + 1000;
                [cell.applyBtn addTarget:self action:@selector(lookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
                
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID1"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"当前无数据";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(cell.contentView);
                }];
                return cell;
            }
        }
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
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            return ScreenWidth*0.4;
        }else{
            if (self.listMarr.count > 0) {
                return 200;
            }else{
                return 44;
            }
        }
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 1) {
            return 45;
        }else if (section == 0) {
            return 0.1;
        }else {
            return 10;
        }
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 1) {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            
            //全部需求
            if (!_moreBtn) {
                _moreBtn = [[FSCustomButton alloc]init];
            }
            _moreBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
            if (self.professionName.length > 0) {
                [_moreBtn setTitle:[NSString stringWithFormat:@"%@",self.professionName] forState:UIControlStateNormal];
                [_moreBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            }else{
                [_moreBtn setTitle:@"全部需求" forState:UIControlStateNormal];
                [_moreBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
            }
            [_moreBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
            
            _moreBtn.titleLabel.font = kFont(14);
            [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_moreBtn];
            [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view);
                make.centerY.mas_equalTo(view);
                make.width.mas_equalTo(ScreenWidth/3.0);
            }];
            
            //区域选择
            if (!_areaBtn) {
                _areaBtn = [[FSCustomButton alloc]init];
            }
            _areaBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
            if (self.cityInfo.length > 0) {
                [_areaBtn setTitle:[NSString stringWithFormat:@"%@",self.cityInfo] forState:UIControlStateNormal];
                [_areaBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            }else{
                [_areaBtn setTitle:@"区域筛选" forState:UIControlStateNormal];
                [_areaBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
            }
            [_areaBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
            
            _areaBtn.titleLabel.font = kFont(14);
            [_areaBtn addTarget:self action:@selector(areaBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_areaBtn];
            [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_moreBtn.mas_right);
                make.centerY.mas_equalTo(view);
                make.width.mas_equalTo(ScreenWidth/3.0);
            }];
            
            //综合排序
            if (!_orderBtn) {
                _orderBtn = [[FSCustomButton alloc]init];
            }
            _orderBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
            if (_orderStr == 0 && _SortField.length > 0 && _Sort.length > 0) {
                if (_SortField.integerValue == 0) {//0上传时间,1婚期
                    if (_Sort.integerValue == 0) {//0倒序,1正序
                        [_orderBtn setTitle:@"发布时间 近→远" forState:UIControlStateNormal];
                    }else if (_Sort.integerValue == 1){
                        [_orderBtn setTitle:@"发布时间 远→近" forState:UIControlStateNormal];
                    }
                }else if (_SortField.integerValue == 1){
                    if (_Sort.integerValue == 0) {//0倒序,1正序
                        [_orderBtn setTitle:@"结婚日期 近→远" forState:UIControlStateNormal];
                    }else if (_Sort.integerValue == 1){
                        [_orderBtn setTitle:@"结婚日期 远→近" forState:UIControlStateNormal];
                    }
                }
                [_orderBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            }else{
                [_orderBtn setTitle:@"综合排序" forState:UIControlStateNormal];
                [_orderBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
            }
            [_orderBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
            
            _orderBtn.titleLabel.font = kFont(14);
            [_orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_orderBtn];
            [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view);
                make.centerY.mas_equalTo(view);
                make.width.mas_equalTo(ScreenWidth/3.0);
            }];
            
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = RGBA(0, 0, 0, 0.12);
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(view);
                make.height.mas_equalTo(1);
            }];
            return view;
        }
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = CHJ_bgColor;
        return line;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.orderTableView) {
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
            [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [self.view addSubview:self.control];
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
    
    [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
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
    
    [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
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

- (void)orderControlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.orderTableView.frame = CGRectMake(0, -44*5, ScreenWidth, 44*5);
    } completion:^(BOOL finished) {
        [self.orderTableView removeFromSuperview];
        self.orderTableView = nil;
        [_orderControl removeFromSuperview];
    }];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    [self CreateAgentApplyTable];
}

- (void)areaBtnClick{
    //地区
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)orderBtnClick{
    [self.view addSubview:self.orderControl];
}

- (void)lookBtnClick:(UIButton *)sender{
    YPGetJSJTableList *list = self.listMarr[sender.tag-1000];
    [self CreateJSJApplyRecordsWithID:list.Id];
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
     4、酒店，婚纱，婚庆
     */
    params[@"Type"] = @"4";
    
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

#pragma mark 申请成为代理商 -- 19-01-30 废
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
            
            [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
            
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
- (void)GetJSJTableListWithIdentityID:(NSString *)identity AndSortField:(NSString *)sortField Sort:(NSString *)sort{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetJSJTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"IdentityId"] = identity;
    params[@"SortField"] = sortField;//0上传时间,1婚期
    params[@"Sort"] = sort;//0倒序(近到远),1正序(远到近)
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
//    params[@"DistributionType"] = @"0";//0所有,1未分配,2已分配
    params[@"State"] = @"1";//0全部,1真,2假
    params[@"AreaId"] = self.areaid;
    if (YongHu(Profession_New)) {
        params[@"FacilitatorId"] = @"00000000-0000-0000-0000-000000000000";
    }else{
        params[@"FacilitatorId"] = FacilitatorId_New;
    }
    params[@"AdminIdentity"] = @"0";//0普通,1管理员

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *str = [object valueForKey:@"Img"];
            self.imgArr = [str componentsSeparatedByString:@","];
            
            [self endRefresh];
            
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

#pragma mark 申请客源
- (void)CreateJSJApplyRecordsWithID:(NSString *)recordID{
    
    NSString *url = @"/api/HQOAApi/CreateAgentApplyTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Id"] = recordID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"已申请, 等待工作人员确认!" inView:self.tableView];
            
            [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
            
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
        _control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        //        [self setupRadioBtnView];
    }
    
    [self setupRadioBtnView];
    
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (UIControl *)orderControl{
    if (!_orderControl) {
        _orderControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
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

-(NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
    [self GetJSJTableListWithIdentityID:self.profession AndSortField:_SortField Sort:_Sort];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
    
}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        
        //6-5
        //        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
        //        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
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
