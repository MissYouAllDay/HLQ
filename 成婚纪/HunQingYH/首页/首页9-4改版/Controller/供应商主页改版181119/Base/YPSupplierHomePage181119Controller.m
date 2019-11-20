//
//  YPSupplierHomePage181119Controller.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierHomePage181119Controller.h"
#import "GestureTableView.h"
#import "PageControllerFooterMore.h"
#import "YPSupplierHomePageHeader.h"
#import "GKPhotoBrowser.h"
#import "XMActionSheet.h"
#import "YPEDuBaseController.h"
#import "CXReceiveVC.h"     // 领取伴手礼

#pragma mark - Cell
#import "YPSupplierHomePageCycleHeadCell.h"
#import "YPSupplierHomePageTagCell.h"
#import "YPSupplierHomePageNumberCell.h"
#import "YPSupplierHomePageAddressCell.h"
#import "YPSupplierHomePageActivityCell.h"
#import "YPSupplierHomePageBaseYouHuiListCell.h"
#import "CXPassageSysCell.h"        // 免费特权

#pragma mark - Model
#import "YPGetFacilitatorInfo.h"
#import "YPGetFacilitatorBasicPreferences.h"

#define kPageTabHeight  40

@interface YPSupplierHomePage181119Controller ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,GKPhotoBrowserDelegate>
@property (nonatomic, strong) PageControllerFooterMore *pageVC;
@property (nonatomic, strong) GestureTableView *tableView;

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) UIGestureRecognizer *pan;

@property (nonatomic, strong) YPGetFacilitatorInfo *infoModel;
@property (nonatomic, strong) NSMutableArray *imgMarr;
@property (nonatomic, strong) __block NSMutableArray<YPGetFacilitatorBasicPreferences *> *dataSource;

@end

@implementation YPSupplierHomePage181119Controller{
    UIView *_navView;
    
    UIView *view;
    UIButton *phoneBtn;
    UIButton *appointBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetFacilitatorInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
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
    
}

- (void)setupUI{
    [self.view addSubview:self.tableView];
    _canScroll = YES;
    
    if (!view) {
        view = [[UIView alloc]init];
    }
    view.backgroundColor = WhiteColor;
    
    if (!phoneBtn) {
        phoneBtn = [[UIButton alloc]init];
    }
    [phoneBtn setImage:[UIImage imageNamed:@"Homepage_phone"] forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"Homepage_phone"] forState:UIControlStateHighlighted];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(6);
        make.bottom.mas_equalTo(view);
//        make.width.mas_equalTo((ScreenWidth-36)*0.5);
    }];
    if (!appointBtn) {
        appointBtn = [[UIButton alloc]init];
    }
    [appointBtn setImage:[UIImage imageNamed:@"HomePage_appoint"] forState:UIControlStateNormal];
    [appointBtn setImage:[UIImage imageNamed:@"HomePage_appoint"] forState:UIControlStateHighlighted];
    [appointBtn addTarget:self action:@selector(appointBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:appointBtn];
    [appointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneBtn.mas_right);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(6);
        make.bottom.mas_equalTo(view);
        make.width.mas_equalTo(phoneBtn.mas_width);
    }];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(56);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
}

- (void)acceptMsg:(NSNotification *)notification {
    NSLog(@"%@",notification);
    if ([notification.name isEqualToString:kLeaveTopNotificationName]) {
        _canScroll = YES;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取pageTab的偏移量
    CGFloat pageTabOffsetY = 0;
    if (JiuDian(self.profession)) {
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                pageTabOffsetY = [_tableView rectForSection:4].origin.y;
            }else{
                pageTabOffsetY = [_tableView rectForSection:3].origin.y;
            }
        }else{
            if (self.dataSource.count > 0) {
                pageTabOffsetY = [_tableView rectForSection:3].origin.y;
            }else{
                pageTabOffsetY = [_tableView rectForSection:2].origin.y;
            }
        }
    }else{
        pageTabOffsetY = [_tableView rectForSection:2].origin.y;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f---%f", offsetY, pageTabOffsetY);
    // 先保留状态
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY >= pageTabOffsetY) {
        // 置顶
        [scrollView setContentOffset:CGPointMake(0, pageTabOffsetY) animated:NO];
        // 不允许滚动 标记
        _isTopIsCanNotMoveTabView = YES;
    } else {
        // 允许滚动
        _isTopIsCanNotMoveTabView = NO;
    }
    // 状态有改变
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        // 之前能滚动，现在不能滚动，表示进入置顶状态
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:nil];
            _canScroll = NO;
        }
        // 之前不能滚动，现在能滚动，表示进入取消置顶
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            if (_canScroll == NO) {
                scrollView.contentOffset = CGPointMake(0, pageTabOffsetY);
                _isTopIsCanNotMoveTabView = YES;
            } else {
                NSLog(@"%s", __func__);
            }
        }
    }
    if (_isTopIsCanNotMoveTabView && _isTopIsCanNotMoveTabViewPre) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:nil];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                return 5;
            }else{
                return 4;
            }
        }else{
            if (self.dataSource.count > 0) {
                return 4;
            }else{
                return 3;
            }
        }
    }else{
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.infoModel.Hldb.integerValue == 0 && self.infoModel.Xfyl.integerValue == 0) {
            if (JiuDian(self.profession)){
                return 3;//只有酒店有餐标/服务费
            }else{
                return 2;
            }
        }else{
            if (JiuDian(self.profession)){
                return 4;//只有酒店有餐标/服务费
            }else{
                return 3;
            }
        }
    }
  
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                if (section == 3) {
                    return self.dataSource.count;
                }
            }
        }else{
            if (self.dataSource.count > 0) {
                if (section == 2) {
                    return self.dataSource.count;
                }
            }
        }
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                if (section == 3 || section == 4) {
                    return kPageTabHeight;
                }
            }else{
                if (section == 3) {
                    return kPageTabHeight;
                }
            }
        }else{
            if (self.dataSource.count > 0) {
                if (section == 2 || section == 3) {
                    return kPageTabHeight;
                }
            }else{
                if (section == 2) {
                    return kPageTabHeight;
                }
            }
        }
    }else{
        if (section == 2) {
            return kPageTabHeight;
        }
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                if (section == 3) {
                    return 20;
                }
                if (section == 4) {
                    return 0.01f;
                }
            }else{
                if (section == 3) {
                    return 0.01f;
                }
            }
        }else{
            if (self.dataSource.count > 0) {
                if (self.dataSource.count > 0) {
                    if (section == 2) {
                        return 20;
                    }
                    if (section == 3) {
                        return 0.01f;
                    }
                }else{
                    if (section == 2) {
                        return 0.01f;
                    }
                }
            }
        }
    }else{
        if (section == 2) {
            return 0.01f;
        }
    }
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                if (section == 3 || section == 4) {
                    if (section == 3) {
                        UIView *view = [UIView new];
                        view.backgroundColor = WhiteColor;
                        
                        UILabel *label = [[UILabel alloc]init];
                        label.text = @"免费特权";
                        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
                        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                        [view addSubview:label];
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.mas_equalTo(view);
                            make.left.mas_equalTo(18);
                        }];
                        return view;
                    }else if (section == 4) {
                        return self.pageVC.slideBar;
                    }
                }
            }else{
                if (section == 3) {
                    return self.pageVC.slideBar;
                }
            }
        }else{
            if (self.dataSource.count > 0) {
                if (section == 2) {
                    UIView *view = [UIView new];
                    view.backgroundColor = WhiteColor;
                    
                    UILabel *label = [[UILabel alloc]init];
                    label.text = @"基础优惠礼包";
                    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
                    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    [view addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view);
                        make.left.mas_equalTo(18);
                    }];
                    return view;
                }else if (section == 3) {
                    return self.pageVC.slideBar;
                }
            }else{
                if (section == 2) {
                    return self.pageVC.slideBar;
                }
            }
        }
    }else{
        if (section == 2) {
            return self.pageVC.slideBar;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = WhiteColor;
    
    if (JiuDian(self.profession)){
        //酒店
        if (self.infoModel.Tag.length > 0) {
            if (self.dataSource.count > 0) {
                if (section == 3) {
                    [view addSubview:line];
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.right.mas_equalTo(view);
                        make.height.mas_equalTo(12);
                    }];
                }
            }
        }else{
            if (self.dataSource.count > 0) {
                if (self.dataSource.count > 0) {
                    if (section == 2) {
                        [view addSubview:line];
                        [line mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.left.right.mas_equalTo(view);
                            make.height.mas_equalTo(12);
                        }];
                    }
                }
            }
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return (ScreenWidth-36)*0.55+50;
        }else if (indexPath.row == 1){
            if (self.infoModel.Hldb.integerValue == 0 && self.infoModel.Xfyl.integerValue == 0) {
                if (JiuDian(self.profession)) {
                    return 32+12+10+[self getHeighWithTitle:self.infoModel.MealMark.length > 0 ? self.infoModel.MealMark : @"0" font:[UIFont fontWithName:@"PingFangSC-Semibold" size:15] width:150];//餐标/服务费
                }else{
                    if (self.infoModel.Abstract.length > 0) {
                        return [self getHeighWithTitle:self.infoModel.Abstract font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-36]+20;
                    }else{
                        return [self getHeighWithTitle:@"无简介" font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
                    }
                }
            }else{
                return 35;
            }
        }else if (indexPath.row == 2){
            if (self.infoModel.Hldb.integerValue == 0 && self.infoModel.Xfyl.integerValue == 0) {
                if (JiuDian(self.profession)) {
                    if (self.infoModel.Abstract.length > 0) {
                        return [self getHeighWithTitle:self.infoModel.Abstract font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-36]+20;
                    }else{
                        return [self getHeighWithTitle:@"无简介" font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
                    }
                }//非酒店 第一组只有两行
            }else{
                if (JiuDian(self.profession)) {
                    return 32+12+10+[self getHeighWithTitle:self.infoModel.MealMark.length > 0 ? self.infoModel.MealMark : @"0" font:[UIFont fontWithName:@"PingFangSC-Semibold" size:15] width:150];//餐标/服务费
                }else{
                    if (self.infoModel.Abstract.length > 0) {
                        return [self getHeighWithTitle:self.infoModel.Abstract font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-36]+20;
                    }else{
                        return [self getHeighWithTitle:@"无简介" font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
                    }
                }
            }
        }else{//酒店 且 担保/有礼 都有时,才有第四(3)行
            if (self.infoModel.Abstract.length > 0) {
                return [self getHeighWithTitle:self.infoModel.Abstract font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-36]+20;
            }else{
                return [self getHeighWithTitle:@"无简介" font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
            }
        }
    }else if (indexPath.section == 1){
        if (self.infoModel.Address.length > 0) {
            return [self getHeighWithTitle:self.infoModel.Address font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
        }else{
            return [self getHeighWithTitle:@"无详细地址" font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-60-18]+20;
        }
    }else if (indexPath.section == 2){
        if (JiuDian(self.profession)){
            //酒店
            if (self.infoModel.Tag.length > 0) {
                return 44;
            }else{
                if (self.dataSource.count > 0) {
                    return 33;
                    //基础优惠
//                    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
//                    return [self getHeighWithTitle:base.Discount font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-23-18*3]+22;
                }else{
                    return (ScreenHeight - kPageTabHeight - NAVIGATION_BAR_HEIGHT);
                }
            }
        }else{
            return (ScreenHeight - kPageTabHeight - NAVIGATION_BAR_HEIGHT);
        }
    }else if (indexPath.section == 3){//只有酒店有
        if (JiuDian(self.profession)){
            //酒店
            if (self.infoModel.Tag.length > 0) {
                if (self.dataSource.count > 0) {
                    return 33;
                    //基础优惠
//                    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
//                    return [self getHeighWithTitle:base.Discount font:[UIFont fontWithName:@"PingFangSC-Regular" size:14] width:ScreenWidth-23-18*3]+14;
                }else{
                    return (ScreenHeight - kPageTabHeight - NAVIGATION_BAR_HEIGHT);
                }
            }else{
                return (ScreenHeight - kPageTabHeight - NAVIGATION_BAR_HEIGHT);
            }
        }
    }else if (indexPath.section == 4) {//只有酒店有
        return (ScreenHeight - kPageTabHeight - NAVIGATION_BAR_HEIGHT);
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPSupplierHomePageCycleHeadCell *cell = [YPSupplierHomePageCycleHeadCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.imgMarr.count > 0) {
                cell.urlArr = self.imgMarr.copy;
            }else{
                if (self.infoModel.Logo.length > 0) {
                    cell.urlArr = @[self.infoModel.Logo];
                }else{
                    cell.imgArr = @[@"图片占位"];
                }
            }
            cell.cycleView.delegate = self;
            cell.cycleView.firstIndex = 1;//从第一张开始传1
            cell.cycleView.autoScroll = NO;
            cell.cycleView.showPageControl = NO;
            if (self.profession.length > 0) {
                cell.profession.text = [CXDataManager checkUserProfession:self.profession];
            }else{
                cell.profession.text = @"  无职业  ";
            }
            cell.imgCount.text = [NSString stringWithFormat:@"  %zd张图  ",self.imgMarr.count>0 ? self.imgMarr.count : 1];
            [cell.cycleView bringSubviewToFront:cell.profession];
            [cell.cycleView bringSubviewToFront:cell.imgCount];
            if (self.infoModel.Name.length > 0) {
                cell.titleLabel.text = self.infoModel.Name;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            return cell;
        }else if (indexPath.row == 1){
            if (self.infoModel.Hldb.integerValue == 0 && self.infoModel.Xfyl.integerValue == 0) {
                if (JiuDian(self.profession)) {
                    //餐标/服务费
                    YPSupplierHomePageNumberCell *cell = [YPSupplierHomePageNumberCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.canbiao.text = [self.infoModel.MealMark stringByReplacingOccurrencesOfString:@"," withString:@"/"];
                    cell.serveLabel.text = [NSString stringWithFormat:@"%zd%%",self.infoModel.ServiceCharge.integerValue];
                    return cell;
                }else{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (self.infoModel.Abstract.length > 0) {
                        cell.textLabel.text = self.infoModel.Abstract;
                    }else{
                        cell.textLabel.text = @"无简介";
                    }
                    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
                    cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    return cell;
                }
                
            }else{
                YPSupplierHomePageTagCell *cell = [YPSupplierHomePageTagCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.infoModel.Hldb.integerValue == 1) {
                    cell.danbao.hidden = NO;
                }else{
                    cell.danbao.hidden = YES;
                    [cell.danbao removeFromSuperview];
                }
                if (self.infoModel.Xfyl.integerValue == 1) {
                    cell.youli.hidden = NO;
                }else{
                    cell.youli.hidden = YES;
                }
                return cell;
            }
        }else if (indexPath.row == 2){
            if (self.infoModel.Hldb.integerValue == 0 && self.infoModel.Xfyl.integerValue == 0) {
                if (JiuDian(self.profession)) {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (self.infoModel.Abstract.length > 0) {
                        cell.textLabel.text = self.infoModel.Abstract;
                    }else{
                        cell.textLabel.text = @"无简介";
                    }
                    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
                    cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    return cell;
                }//非酒店 第一组只有两行
            }else{
                if (JiuDian(self.profession)) {
                    //餐标/服务费
                    YPSupplierHomePageNumberCell *cell = [YPSupplierHomePageNumberCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.canbiao.text = self.infoModel.MealMark;
                    cell.serveLabel.text = [NSString stringWithFormat:@"%zd%%",self.infoModel.ServiceCharge.integerValue];
                    return cell;
                }else{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (self.infoModel.Abstract.length > 0) {
                        cell.textLabel.text = self.infoModel.Abstract;
                    }else{
                        cell.textLabel.text = @"无简介";
                    }
                    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
                    cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    return cell;
                }
            }
        }else if (indexPath.row == 3){//酒店 且 担保/有礼 都有时,才有第四(3)行
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoModel.Abstract.length > 0) {
                cell.textLabel.text = self.infoModel.Abstract;
            }else{
                cell.textLabel.text = @"无简介";
            }
            cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            return cell;
        }
            
    }else if (indexPath.section == 1){
        YPSupplierHomePageAddressCell *cell = [YPSupplierHomePageAddressCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.infoModel.Address.length > 0) {
            cell.address.text = self.infoModel.Address;
        }else{
            cell.address.text = @"无详细地址";
        }
        return cell;
    }else if (indexPath.section == 2){
        if (JiuDian(self.profession)) {//酒店
            if (self.infoModel.Tag.length > 0) {
                YPSupplierHomePageActivityCell *cell = [YPSupplierHomePageActivityCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.activityLabel.text = self.infoModel.Tag;
                return cell;
            }else{
                if (self.dataSource.count > 0) {
//                    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
//                    //基础优惠
//                    YPSupplierHomePageBaseYouHuiListCell *cell = [YPSupplierHomePageBaseYouHuiListCell cellWithTableView:tableView];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    cell.descLabel.text = base.Discount;
                    return [self sysCell:tableView cellForRowAtIndexPath:indexPath];
                }else{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"page"];
                        cell.exclusiveTouch = YES;
                        PageControllerFooterMore *vc = self.pageVC;
                        vc.FacilitatorID = self.FacilitatorID;
                        vc.UserID = self.infoModel.UserId;
                        vc.profession = self.profession;
                        [cell.contentView addSubview:vc.view];
                        
                        [self addChildViewController:vc];
                        [vc didMoveToParentViewController:self];
                        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(cell.contentView);
                        }];
                    }
                    return cell;
                }
            }
        }else{//其他
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"page"];
                cell.exclusiveTouch = YES;
                PageControllerFooterMore *vc = self.pageVC;
                vc.FacilitatorID = self.FacilitatorID;
                vc.UserID = self.infoModel.UserId;
                vc.profession = self.profession;
                [cell.contentView addSubview:vc.view];
                
                [self addChildViewController:vc];
                [vc didMoveToParentViewController:self];
                [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView);
                }];
            }
            return cell;
        }
        
    }else if (indexPath.section == 3){
        if (JiuDian(self.profession)) {//酒店
            if (self.infoModel.Tag.length > 0) {
                if (self.dataSource.count > 0) {
//                    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
//                    //基础优惠
//                    YPSupplierHomePageBaseYouHuiListCell *cell = [YPSupplierHomePageBaseYouHuiListCell cellWithTableView:tableView];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    cell.descLabel.text = base.Discount;
//                    return cell;
                    return [self sysCell:tableView cellForRowAtIndexPath:indexPath];
                }else{
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"page"];
                        cell.exclusiveTouch = YES;
                        PageControllerFooterMore *vc = self.pageVC;
                        vc.FacilitatorID = self.FacilitatorID;
                        vc.UserID = self.infoModel.UserId;
                        vc.profession = self.profession;
                        [cell.contentView addSubview:vc.view];
                        
                        [self addChildViewController:vc];
                        [vc didMoveToParentViewController:self];
                        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(cell.contentView);
                        }];
                    }
                    return cell;
                }
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"page"];
                    cell.exclusiveTouch = YES;
                    PageControllerFooterMore *vc = self.pageVC;
                    vc.FacilitatorID = self.FacilitatorID;
                    vc.UserID = self.infoModel.UserId;
                    vc.profession = self.profession;
                    [cell.contentView addSubview:vc.view];
                    
                    [self addChildViewController:vc];
                    [vc didMoveToParentViewController:self];
                    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(cell.contentView);
                    }];
                }
                return cell;
            }
        }
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"page"];
            cell.exclusiveTouch = YES;
            PageControllerFooterMore *vc = self.pageVC;
            vc.FacilitatorID = self.FacilitatorID;
            vc.UserID = self.infoModel.UserId;
            vc.profession = self.profession;
            [cell.contentView addSubview:vc.view];
            
            [self addChildViewController:vc];
            [vc didMoveToParentViewController:self];
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        return cell;
    }
    return nil;
}

#pragma mark - - - - - - - - - - - - - - - 免费特权 - - - - - - - - - - - - - - - - -
- (UITableViewCell *)sysCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXPassageSysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXPassageSysCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXPassageSysCell" owner:nil options:nil] lastObject];
    }
    switch (indexPath.row) {
        case 0: {[cell setSysCellDefaValueIsJoin:YES withName:@"订婚宴送伴手礼"];   break;}
        case 1: {[cell setSysCellDefaValueIsJoin:YES withName:@"花多少返多少"];    break;}
        case 2: {[cell setSysCellDoubleValueIsJoin:YES];  break;}
        default: break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    // 如果是免费特权。则进行如下操作
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[CXPassageSysCell class]]) {
        
        switch (indexPath.row) {
            case 0: [self supericeVC]; break;
            case 1: [self payReturnVC]; break;
            default: break;
        }
    }
}


#pragma mark - --------- SDCycleScrollViewdelegate --------
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSMutableArray *photos = [NSMutableArray new];
    NSArray *coverArr = [[NSArray alloc]init];
    if (self.imgMarr.count > 0) {
        coverArr = self.imgMarr.copy;
        
    }else{
        coverArr = @[self.infoModel.Logo];
    }
    
    [coverArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.delegate =self;
    [browser showFromVC:self];
    
}

#pragma mark - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index {
    
    
    [XMActionSheet xm_actionSheetWithActionTitles:@[@"保存图片"] actionHander:^(NSUInteger index) {
        
        if (index ==0) {
            
            NSArray *coverArr = self.imgMarr.copy;
            [self toSaveImage:coverArr[index]];
        }
    }];
    
}

- (void)toSaveImage:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    //    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //从网络下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img= [UIImage imageWithData:data];
    
    // 保存图片到相册中
    UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        [EasyShowTextView showErrorText:@"图片保存失败"];
    }
    else  // No errors
    {
        [EasyShowTextView showSuccessText:@"图片保存成功"];
        
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)phoneBtnClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.infoModel.Phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)appointBtnClick{
    //5-29 预约
    [self CreateUserAppointment];
}

#pragma mark - 动态计算label高度
- (CGFloat)getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

#pragma mark - 网络请求
#pragma mark 供应商信息
- (void)GetFacilitatorInfo{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFacilitatorInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.FacilitatorID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            NSLog(@"详情%@",object);
            self.infoModel.Id = [object objectForKey:@"Id"];
            self.infoModel.UserId = [object objectForKey:@"UserId"];
            self.infoModel.Name = [object objectForKey:@"Name"];
            self.infoModel.Logo = [object objectForKey:@"Logo"];
            self.infoModel.Phone = [object objectForKey:@"Phone"];
            self.infoModel.Address = [object objectForKey:@"Address"];
            self.infoModel.Abstract = [object objectForKey:@"Abstract"];
            
            self.infoModel.Identity = [object objectForKey:@"Identity"];
            self.infoModel.region = [object objectForKey:@"region"];
            self.infoModel.regionname = [object objectForKey:@"regionname"];
            self.infoModel.Tag = [object valueForKey:@"Tag"];

            //18-11-19 图片
            self.infoModel.Data = [YPGetFacilitatorInfoImgData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetFacilitatorInfoImgData *data in self.infoModel.Data) {
                [self.imgMarr addObject:data.ImgUrl];
            }
            
            //18-09-03
            if (self.infoModel.Address.length == 0) {
                self.infoModel.Address = @"无地址";
            }
            if (self.infoModel.Abstract.length == 0) {
                self.infoModel.Abstract = @"无简介";
            }
            
            //18-10-26
            self.infoModel.Hldb = [object valueForKey:@"Hldb"];
            self.infoModel.Xfyl = [object valueForKey:@"Xfyl"];
            
            //18-11-21
            NSString *meal = [object valueForKey:@"MealMark"];
            self.infoModel.MealMark = meal.length > 0 ? meal : @"0";
            self.infoModel.ServiceCharge = [object valueForKey:@"ServiceCharge"];
            self.infoModel.BasicPreferencesCount = [object valueForKey:@"BasicPreferencesCount"];

            self.pageVC.FacilitatorID = self.FacilitatorID;
            self.pageVC.UserID = self.infoModel.UserId;
            self.pageVC.profession = self.profession;
            
//            [self GetFacilitatorBasicPreferences];
             [self setupUI];
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

#pragma mark 获取服务商基础优惠
- (void)GetFacilitatorBasicPreferences{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorBasicPreferences";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = self.FacilitatorID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.dataSource removeAllObjects];
            self.dataSource = [YPGetFacilitatorBasicPreferences mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self setupUI];
            
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

#pragma mark 新增用户预约
-(void)CreateUserAppointment{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateUserAppointment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"Phone"] = @"";
    params[@"SupplierId"] = self.FacilitatorID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showSuccessText:@"您的预约已送达，客服会尽快与您联系"];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
}

#pragma mark - Getter
- (PageControllerFooterMore *)pageVC {
    if (_pageVC == nil) {
        _pageVC = [PageControllerFooterMore new];
    }
    _pageVC.FacilitatorID = self.FacilitatorID;
    _pageVC.UserID = self.infoModel.UserId;
    _pageVC.profession = self.profession;
    return _pageVC;
}

- (GestureTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[GestureTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-56-HOME_INDICATOR_HEIGHT)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (YPGetFacilitatorInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetFacilitatorInfo alloc]init];
    }
    return _infoModel;
}

- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        _imgMarr = [NSMutableArray array];
    }
    return _imgMarr;
}

- (NSMutableArray<YPGetFacilitatorBasicPreferences *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObject:[YPGetFacilitatorBasicPreferences new]];
        [_dataSource addObject:[YPGetFacilitatorBasicPreferences new]];
    }
    return _dataSource;
}

#pragma mark - - - - - - - - - - - - - - - 界面跳转 - - - - - - - - - - - - - - - - -
/** 伴手礼 */
- (void)supericeVC{
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        CXReceiveVC *edu = [[CXReceiveVC alloc]init];
        [self.navigationController pushViewController:edu animated:YES];
        
    }
}
/** 花多少 返多少。 */
- (void)payReturnVC{
    NSLog(@"bigBtnClick");
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
        edu.typeStr = @"1";//婚礼返还
        [self.navigationController pushViewController:edu animated:YES];
        
    }
}

@end
