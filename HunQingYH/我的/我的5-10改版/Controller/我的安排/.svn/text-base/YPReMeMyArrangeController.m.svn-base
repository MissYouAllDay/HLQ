//
//  YPReMeMyArrangeController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeMyArrangeController.h"
#import "YPArrangeDangQiController.h"
#import "YPArrangeNewAddController.h"
#import "ZJScrollPageView.h"
#import "YPAddArrangeController.h"//添加安排
#import "ZJScrollPageView.h"
#import "YPNewMarriedAnPaiController.h"
#import "YPNewMarriedLiuChengController.h"
///新人 -- 婚庆公司列表
#import "YPArrangeMarriedHunQingListCell.h"
#import "YPNewMarriedController.h"//新人 -- 人员安排/婚礼流程
#import "YPGetCustomerInfoList.h"

@interface YPReMeMyArrangeController ()<ZJScrollPageViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;//用户 -- 婚庆公司列表专用
@property (nonatomic, strong) NSMutableArray<YPGetCustomerInfoList *> *listMarr;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (nonatomic, strong) ZJContentView *content;
@property (nonatomic, strong) YPArrangeDangQiController *dangqiVC;
@property (nonatomic, strong) YPArrangeNewAddController *newaddVC;

//新人
@property (nonatomic, strong) YPNewMarriedAnPaiController *anpaiVC;
@property (nonatomic, strong) YPNewMarriedLiuChengController *liuchengVC;

@end

@implementation YPReMeMyArrangeController{
    UIView *_navView;
    ZJScrollSegmentView *segment;
    UIButton *addBtn;
    //    UILabel *tishiLab;
    
    //新人标题
    UILabel *titleLab;
    
    //婚庆提示页
    UIView *_hunqingView;
    UIImageView *_HunIconImgV;
    UIImageView *_HunImgV;
    UILabel *_HunLabel1;
    UILabel *_HunLabel2;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    [self setupNav];
//    [self setupUI];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"暂无数据!";
    label.textColor = GrayColor;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
}

-(void)refreshData{

    NSLog(@"刷新");
    if (JiuDian(Profession_New)){//只有档期
        [self.dangqiVC rereshData];
        
    }else if (HunQing(Profession_New)){//婚庆公司不需要
        
    }else if (YongHu(Profession_New)){//新人
        
        
    }else{
        
        [self.newaddVC rereshData];
        
        [self.dangqiVC rereshData];
        
    }
    
    [_navView removeFromSuperview];
    [self.content removeFromSuperview];
    //    [tishiLab removeFromSuperview];
    
    [_hunqingView removeFromSuperview];
    [_HunIconImgV removeFromSuperview];
    [_HunImgV removeFromSuperview];
    [_HunLabel1 removeFromSuperview];
    [_HunLabel2 removeFromSuperview];
    
    [self.dangqiVC.view removeFromSuperview];
    [self.tableView removeFromSuperview];
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;

    if (JiuDian(Profession_New)){//酒店只有档期
        self.dangqiVC.view.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT);
        [self.view addSubview:self.dangqiVC.view];
    }else if (HunQing(Profession_New)){//婚庆无内容，给提示页
        [self setTiShiView];
    }else if (YongHu(Profession_New)){//用户 -- 显示婚庆公司列表

        [self GetCustomerInfoList];//请求数据

    }else{
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT) segmentView:segment parentViewController:self delegate:self];
        self.content = content;
        [self.view addSubview:self.content];
    }
    
    
}

//提示页 -- 婚庆公司
-(void)setTiShiView{
    //    tishiLab = [[UILabel alloc]init];
    //    tishiLab.text =@"您的身份是婚庆公司，暂无法使用该功能，请您使用婚礼桥商家版。";
    //    tishiLab.textColor =TextNormalColor;
    //    tishiLab.numberOfLines =0;
    //    [self.view addSubview:tishiLab];
    //    [tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.mas_equalTo(self.view);
    //        make.left.mas_equalTo(self.view.mas_left).offset(10);
    //        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    //    }];
    
    if (!_hunqingView) {
        _hunqingView = [[UIView alloc]init];
    }
    _hunqingView.backgroundColor = WhiteColor;
    [self.view addSubview:_hunqingView];
    [_hunqingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenHeight-NAVIGATION_BAR_HEIGHT-1);
    }];
    
    //    if (!_HunIconImgV) {
    //        _HunIconImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"组2"]];
    //    }
    //    _HunIconImgV.layer.masksToBounds = YES;
    //    _HunIconImgV.layer.cornerRadius = 5;
    //    _HunIconImgV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    //    _HunIconImgV.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    //    _HunIconImgV.layer.shadowOpacity = 0.5;//不透明度
    //    _HunIconImgV.layer.shadowRadius = 1.0;//半径
    //    [_hunqingView addSubview:_HunIconImgV];
    //    [_HunIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(20);
    //        make.size.mas_equalTo(CGSizeMake(75, 75));
    //        make.centerX.mas_equalTo(self.view);
    //    }];
    
    if (!_HunImgV) {
        _HunImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"婚庆占位"]];
    }
    //    _HunImgV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    //    _HunImgV.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    //    _HunImgV.layer.shadowOpacity = 0.5;//不透明度
    //    _HunImgV.layer.shadowRadius = 5.0;//半径
    [_hunqingView addSubview:_HunImgV];
    [_HunImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(_HunIconImgV.mas_bottom).mas_offset(20);
        make.top.mas_equalTo(20+20);
        //        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(80);
        make.right.mas_equalTo(-80);
        make.height.mas_equalTo((ScreenWidth-80*2)*1.5);
    }];
    
    if (!_HunLabel1) {
        _HunLabel1 = [[UILabel alloc]init];
    }
    _HunLabel1.text = @"安排供应商、婚礼流程";
    _HunLabel1.textColor = LightGrayColor;
    _HunLabel1.font = [UIFont systemFontOfSize:19];
    _HunLabel1.textAlignment = NSTextAlignmentCenter;
    [_hunqingView addSubview:_HunLabel1];
    [_HunLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_HunImgV.mas_bottom).mas_offset(25);
        make.centerX.mas_equalTo(self.view);
    }];
    
    if (!_HunLabel2) {
        _HunLabel2 = [[UILabel alloc]init];
    }
    _HunLabel2.text = @"请下载婚庆公司专用版APP";
    _HunLabel2.textColor = LightGrayColor;
    _HunLabel2.font = [UIFont systemFontOfSize:19];
    _HunLabel2.textAlignment = NSTextAlignmentCenter;
    [_hunqingView addSubview:_HunLabel2];
    [_HunLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_HunLabel1.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
}

//用户 -- 婚庆公司
- (void)setHunQingList{
    
    if (self.listMarr.count > 0) {
        
        if (!self.tableView) {
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = CHJ_bgColor;
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.tableHeaderView = [[UIView alloc]init];
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 50;
        [self.view addSubview:self.tableView];
        
    }else{
        
        if (!_hunqingView) {
            _hunqingView = [[UIView alloc]init];
        }
        _hunqingView.backgroundColor = WhiteColor;
        [self.view addSubview:_hunqingView];
        [_hunqingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(ScreenHeight-NAVIGATION_BAR_HEIGHT-1);
        }];
        
        //        if (!_HunIconImgV) {
        //            _HunIconImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"组1"]];
        //        }
        //        _HunIconImgV.layer.masksToBounds = YES;
        //        _HunIconImgV.layer.cornerRadius = 5;
        //        _HunIconImgV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        //        _HunIconImgV.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        //        _HunIconImgV.layer.shadowOpacity = 0.5;//不透明度
        //        _HunIconImgV.layer.shadowRadius = 1.0;//半径
        //        [_hunqingView addSubview:_HunIconImgV];
        //        [_HunIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.mas_equalTo(20);
        //            make.size.mas_equalTo(CGSizeMake(75, 75));
        //            make.centerX.mas_equalTo(self.view);
        //        }];
        
        if (!_HunImgV) {
            _HunImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"catoon"]];
        }
        _HunImgV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        _HunImgV.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        _HunImgV.layer.shadowOpacity = 0.5;//不透明度
        _HunImgV.layer.shadowRadius = 5.0;//半径
        [_hunqingView addSubview:_HunImgV];
        [_HunImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.mas_equalTo(_HunIconImgV.mas_bottom).mas_offset(50);
            make.top.mas_equalTo(20+75+50);
            make.centerX.mas_equalTo(_hunqingView);
            //            make.left.mas_equalTo(40);
            //            make.right.mas_equalTo(-40);
            //            make.height.mas_equalTo((ScreenWidth-40*2)*0.67);
        }];
        
        if (!_HunLabel1) {
            _HunLabel1 = [[UILabel alloc]init];
        }
        _HunLabel1.text = @"暂时没有婚礼安排";
        _HunLabel1.textColor = LightGrayColor;
        _HunLabel1.font = [UIFont systemFontOfSize:19];
        _HunLabel1.textAlignment = NSTextAlignmentCenter;
        [_hunqingView addSubview:_HunLabel1];
        [_HunLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_HunImgV.mas_bottom).mas_offset(50);
            make.centerX.mas_equalTo(self.view);
        }];
        
        if (!_HunLabel2) {
            _HunLabel2 = [[UILabel alloc]init];
        }
        _HunLabel2.text = @"先去选择合适的婚庆公司吧";
        _HunLabel2.textColor = LightGrayColor;
        _HunLabel2.font = [UIFont systemFontOfSize:19];
        _HunLabel2.textAlignment = NSTextAlignmentCenter;
        [_hunqingView addSubview:_HunLabel2];
        [_HunLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_HunLabel1.mas_bottom).mas_offset(10);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    if (!_navView) {
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    if (JiuDian(Profession_New)){
//        //        [self.view addSubview:self.dangqiVC.view];
//    }else if (HunQing(Profession_New)){//婚庆公司不需要
//
//    }else if (YongHu(Profession_New)){//新人
//
//        if (self.listMarr.count > 0) {
//            if (!titleLab) {
//                titleLab  = [[UILabel alloc]init];
//            }
//            titleLab.text = @"婚庆公司列表";
//            titleLab.textColor = BlackColor;
//            [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//            [_navView addSubview:titleLab];
//            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
//                make.centerX.mas_equalTo(_navView.mas_centerX);
//            }];
//        }else{
//
//        }
//
//    }else{
//        //segment
//        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
//        //显示遮盖
//        style.showCover = NO;
//        style.segmentViewBounces = NO;
//        // 颜色渐变
//        style.gradualChangeTitleColor = YES;
//        style.showLine = YES;
//        style.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:17];
//        // 显示附加的按钮
//        // 设置附加按钮的背景图片
//
//
//
//        //        if (YongHu(UserProfession)) {//新人
//        //           self.titles = @[@"人员安排",@"婚礼流程"];
//        //        }else{//其他
//        self.titles = @[@"档期"];//18-08-17 ,@"任务" 任务(结算记录) 暂时隐藏
//        //        }
//
//        __weak typeof(self) weakSelf = self;
//        if (!segment) {//18-08-17 更改x位置 加了 (*0.5) 原来是ScreenWidth/3.0
//            segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(ScreenWidth/2.0-ScreenWidth/4.0*0.5, 20, ScreenWidth/4.0, NAVIGATION_BAR_HEIGHT-20) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
//                [weakSelf.content setContentOffSet:CGPointMake(weakSelf.content.bounds.size.width * index, 0.0) animated:YES];
//            }];
//        }
//        [_navView addSubview:segment];
//        [segment mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_navView).mas_offset(20);
//            make.bottom.mas_equalTo(_navView);
//            make.centerX.mas_equalTo(_navView);
//            make.width.mas_equalTo(ScreenWidth/3.0);
//        }];
//
//
//    }
//
//    if (HunQing(Profession_New)||YongHu(Profession_New)){
//        //婚庆和新人/车手 没有添加  -- 9.25 修改 车手可以添加档期
//    }else{
//        //设置导航栏右边通知
//        if (!addBtn) {
//            addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//        }
//        [addBtn setImage:[UIImage imageNamed:@"add-red"] forState:UIControlStateNormal];
//        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [_navView addSubview:addBtn];
//        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(25, 25));
//            make.right.mas_equalTo(self.view).mas_offset(-15);
//             make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
//        }];
//    }
    
    
    
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = self.childVcs[index];
    }
    return childVc;
}

-(CGRect)frameOfChildControllerForContainer:(UIView *)containerView {
    return  CGRectInset(containerView.bounds, 20, 20);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetCustomerInfoList *list = self.listMarr[indexPath.row];
    
    YPArrangeMarriedHunQingListCell *cell = [YPArrangeMarriedHunQingListCell cellWithTableView:tableView];
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.titleLabel.text = list.CorpName;
    cell.addressLabel.text = list.Address;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"以下婚庆公司已将您登记为客户";
        label1.textColor = GrayColor;
        label1.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
            make.right.mas_greaterThanOrEqualTo(-10);
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"点击查看相应的婚礼详细";
        label2.textColor = GrayColor;
        label2.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(label1);
            make.top.mas_equalTo(label1.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(-5);
        }];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPGetCustomerInfoList *list = self.listMarr[indexPath.row];
    YPNewMarriedController *married = [[YPNewMarriedController alloc]init];
    married.customerID = list.CustomerInfoID;
    [self.navigationController yp_pushViewController:married animated:YES];
}

#pragma mark - 按钮点击事件
- (void)addBtnClick{
    NSLog(@"addBtnClick");
    
    YPAddArrangeController *add = [[YPAddArrangeController alloc]init];
    add.leixingStr =@"1";
    add.wanchengBlock = ^(NSString *str) {
        [self refreshData];
    } ;
    [self.navigationController yp_pushViewController:add animated:YES];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (YPArrangeDangQiController *)dangqiVC{
    if (!_dangqiVC) {
        _dangqiVC = [[YPArrangeDangQiController alloc]init];
    }
    return _dangqiVC;
}

- (YPArrangeNewAddController *)newaddVC{
    if (!_newaddVC) {
        _newaddVC = [[YPArrangeNewAddController alloc]init];
    }
    return _newaddVC;
}

- (NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)childVcs{
    if (!_childVcs) {
        
        //        if (YongHu(UserProfession)) {
        //             _childVcs = [NSArray arrayWithObjects:self.anpaiVC,self.liuchengVC, nil];
        //        }else{
        _childVcs = [NSArray arrayWithObjects:self.dangqiVC,self.newaddVC, nil];
        //        }
        
    }
    return _childVcs;
}
- (YPNewMarriedAnPaiController *)anpaiVC{
    if (!_anpaiVC) {
        _anpaiVC = [[YPNewMarriedAnPaiController alloc]init];
    }
    return _anpaiVC;
}

- (YPNewMarriedLiuChengController *)liuchengVC{
    if (!_liuchengVC) {
        _liuchengVC = [[YPNewMarriedLiuChengController alloc]init];
    }
    return _liuchengVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 网络请求
#pragma mark 客户获取婚礼信息列表
- (void)GetCustomerInfoList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCustomerInfoList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetCustomerInfoList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self setupNav];
            [self setHunQingList];
            
            if (self.listMarr.count > 0) {
                self.tableView.tableHeaderView = nil;
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
                
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

#pragma mark - getter
- (NSMutableArray<YPGetCustomerInfoList *> *)listMarr{
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
