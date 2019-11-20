//
//  YPMe180831Controller.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/31.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMe180831Controller.h"
#pragma mark - VC
#import "YPSettingController.h"//设置
#import "YPReMeGuanzhuFensiController.h"//5-29 添加 关注粉丝
#import "YPGoToHomePageWebController.h"//6-27 添加 前往主页
#import "YPPersonInfoController.h"//个人资料 -- 用户/车手
#import "YPSupplierPersonInfoController.h"//供应商个人资料
#import "YPReMeMyArrangeController.h"//我的安排
#import "HRMyFaXianViewController.h"//我的动态
//#import "YPMyWalletBaseController.h"
#import "YPReMyWalletBaseController.h"//18-09-27 我的钱包重做
#import "YPMyEDuOrderController.h"//额度订单
#import "YPMeXinRenPhotoController.h"//新人照片
#import "YPMePhotoManListController.h"//供应商照片
#import "HRMeViedoViewController.h"//视频
#import "YPReYQJHController.h"//邀请结婚
#import "HRWeChatDuiHuanController.h"//领取礼品
//#import "YPYanHuiTingListController.h"//宴会厅管理
#import "YPMeYanHuiTingList181115Controller.h"//18-11-15 宴会厅管理
#import "YPMyCarTeamController.h"//我的车队-婚车
#import "YPMyCarNoMemberController.h"//我的车队-车手
#import "YPMemberCarTeamInviteController.h"//我的车队-车手
#import "YPMemberCarTeamController.h"//我的车队-车手
#import "YPMyCarController.h"//车辆管理
#import "YPMyAnliListController.h"//我的案例
#import "YPBalanceRecordController.h"//结算记录
#import "YPHotelPayController.h"//18-09-10 酒店支付
#import "YPMyOrderListController.h"//我的订单
#import "YPWeddingOrderBaseController.h"//18-10-08 婚礼订单
#import "YPInviteFriendsWedNormalController.h"//18-10-15 邀请结婚-普通
#import "YPInviteFriendsWedVIPController.h"//18-10-15 邀请结婚-VIP
//#import "YPMeKeYuanFenPeiController.h"//18-11-01 客源分配
#import "YPChangeAccountController.h"//18-11-13 切换账号
#import "YPHYTHOrderBaseController.h"//19-01-15 婚宴特惠订单
#import "YPMeTeHuiOrderBaseController.h"//19-02-23 婚宴订单
#import "YPMyKeYuan190311BaseController.h"//19-03-11 客源分配
#import "YPMe190519MyReserveController.h"//19-05-19 我的预订
#import "HRNavigationController.h"
#pragma mark - Model
#import "YPGetUserInfo.h"
#import "YPGetInvitationProfit.h"//18-10-18 邀请结婚

#pragma mark - View
#import "YPMe180831HeadCell.h"
#import "YPMe180831MutiBtnCell.h"
#import "YPMe180831MutiServeCell.h"
#import "ManageViewController.h"
#import "CXManagerHomeVC.h" // 管理

#pragma mark - ThirdPart
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface YPMe180831Controller ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetUserInfo *userInfo;

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *iconImgUrl;
@property (nonatomic, copy) NSString *professionID;

///18-10-18 邀请结婚模型
@property (nonatomic, strong) YPGetInvitationProfit *profitModel;

@end

@implementation YPMe180831Controller{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (UserId_New) {
        [self GetUserFacilitatorInfo];
    }else{
        [self.tableView reloadData];
    }
    if (!UserId_New) {
        [self.navigationController.tabBarController setSelectedIndex:0];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{

    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"181108_bg"]];
    imgV.frame = CGRectMake(0, 0, ScreenWidth, 230+STATUS_BAR_HEIGHT);
//    [self.view addSubview:imgV];
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 230+STATUS_BAR_HEIGHT)];
    img.backgroundColor = [UIColor redColor];
    img.image = [UIImage imageNamed:@"181108_bg"];
    [self.view addSubview:img];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-TAB_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClearColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"我";
//    titleLab.textColor = BlackColor;
//    titleLab.font = [UIFont boldSystemFontOfSize:20];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    [changeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    changeBtn.titleLabel.font = kFont(15);
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_navView).mas_offset(-10);
        make.left.mas_equalTo(_navView).mas_offset(15);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"180831_set"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(changeBtn);
        make.right.mas_equalTo(_navView).mas_offset(-15);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //MARK: section 0
    if (indexPath.section == 0) {
        YPMe180831HeadCell *cell = [YPMe180831HeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //19-03-06 商家主页隐藏
        cell.goHomePageBtn.hidden = YES;
        
        //2-11 修改
        if (!UserId_New) {
            cell.titleLabel.text = @"点击登录";
            [cell.iconImgV setImage:[UIImage imageNamed:@"1024"] forState:UIControlStateNormal];
            [cell.iconImgV setImage:[UIImage imageNamed:@"1024"] forState:UIControlStateDisabled];
            
            cell.iconImgV.enabled = NO;
//            [cell.professionBtn setTitle:@" 新人 " forState:UIControlStateNormal];
//            [cell.professionBtn setImage:[UIImage imageNamed:@"180831_NewProfession"] forState:UIControlStateNormal];
            cell.guanzhu.text = @"0";
            cell.fensi.text = @"0";
//            cell.professionBtn.hidden = YES;
//            cell.guanzhuLabel.hidden = YES;
//            cell.guanzhu.hidden = YES;
//            cell.fensiLabel.hidden = YES;
//            cell.fensi.hidden = YES;
//            cell.guanzhuFensiBtn.hidden = YES;
//            cell.goHomePageBtn.hidden = YES;
            
        }else{
            [cell.iconImgV setImageWithURL:[NSURL URLWithString:self.userInfo.Headportrait] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"1024"]];
            if (self.userInfo.Name.length > 0) {
                cell.titleLabel.text = self.userInfo.Name;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            
            cell.iconImgV.enabled = YES;
//            cell.professionBtn.hidden = NO;
//            cell.guanzhuLabel.hidden = NO;
//            cell.guanzhu.hidden = NO;
//            cell.fensiLabel.hidden = NO;
//            cell.fensi.hidden = NO;
//            cell.guanzhuFensiBtn.hidden = NO;
//            cell.goHomePageBtn.hidden = NO;
            
            cell.guanzhu.text = [NSString stringWithFormat:@"%zd",self.userInfo.FollowNumber];
            cell.fensi.text = [NSString stringWithFormat:@"%zd",self.userInfo.FansNumber];
            [cell.guanzhuFensiBtn addTarget:self action:@selector(guanzhuFensiBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.goHomePageBtn addTarget:self action:@selector(goToHomePageBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.professionBtn setTitle:[CXDataManager checkUserProfession:self.professionID] forState:UIControlStateNormal];
        }
        
        [cell.iconImgV addTarget:self action:@selector(infoEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else if (indexPath.section == 1){
        //MARK: section 1
        YPMe180831MutiBtnCell *cell = [YPMe180831MutiBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameArr = @[@{@"name":@"安排",@"img":@"Me_安排"},@{@"name":@"动态",@"img":@"Me_动态"},@{@"name":@"订单",@"img":@"Me_订单"},@{@"name":@"钱包",@"img":@"Me_钱包"}];//,@{@"name":@"钱包",@"img":@"reMe_钱包"} FIXME: 18-08-16 钱包暂时隐藏 18-08-18 @{@"name":@"安排",@"img":@"reMe_安排"}, 安排暂时隐藏
        //MARK: section 0 item点击
        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
            if (!UserId_New) {
                
                //2-11 修改 登录判断
                YPReLoginController *first = [[YPReLoginController alloc]init];
                UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                [self presentViewController:firstNav animated:YES completion:nil];
                
            }else{
                if ([sectionName isEqualToString:@"安排"]) {
                    //18-09-21 暂时跳占位页
                    YPReMeMyArrangeController *arrange = [[YPReMeMyArrangeController alloc]init];
                    [self.navigationController pushViewController:arrange animated:YES];
                    
//                    //18-08-31
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"功能开发中,敬请期待!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
                    
                }else if ([sectionName isEqualToString:@"动态"]) {
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                }else if ([sectionName isEqualToString:@"订单"]){
//                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
//                    [self.navigationController pushViewController:orderVC animated:YES];
                    //19-01-15 放到下边 郝 把婚宴特惠的订单放到上边
                    YPHYTHOrderBaseController *order = [YPHYTHOrderBaseController new];
                    [self.navigationController pushViewController:order animated:YES];
                    
                }else if ([sectionName isEqualToString:@"钱包"]){
                    //18-09-21 暂时跳占位页
//                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    YPReMyWalletBaseController *base = [[YPReMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                    
//                    //18-08-31
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"功能开发中,敬请期待!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
                }
            }
        };
        return cell;
    }else if (indexPath.section == 2){
        //MARK: section 2
        
        YPMe180831MutiServeCell *cell = [YPMe180831MutiServeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //MARK: 婚车 -- FIXME: 18-08-18 婚车等同用户
        //        if (HunChe(self.professionID)) {
        //            return 3;//案例/结算/车队/车辆 //FIXME: 18-08-17 结算暂时隐藏
        //
        //        }
        //MARK: 车手 -- FIXME: 18-08-18 车手等同用户
        //        else if (CheShou(self.professionID)){
        //            return 2;//车队/车辆
        //        }
        if (self.professionID.length > 0) {
            if (JiuDian(self.professionID)){//FIXME: 18-08-14 去掉酒店资料
                //MARK: 酒店
                //案例/宴会厅/   (酒店资料(管理))
                cell.nameArr = @[@{@"name":@"婚宴订单",@"img":@"ico_me_hunyan"},@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"客源分配",@"img":@"ico_me_keyuanfenpei"},@{@"name":@"宴会厅管理",@"img":@"ico_me_Ting"},@{@"name":@"我的案例",@"img":@"ico_me_MyAnLi"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];
            }else if (HunChe(self.professionID) || CheShou(self.professionID)){
                //MARK: 婚车/车手 FIXME: 18-08-18 婚车/车手等同用户
                //照片/视频 FIXME: 18-08-18 照片视频暂时隐藏 直接显示两组
                cell.nameArr = @[@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"客源分配",@"img":@"ico_me_keyuanfenpei"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];

            }else if (YongHu(self.professionID)) {
                //MARK: 用户 18-09-10 用户 添加 酒店支付
                cell.nameArr = @[@{@"name":@"我的预订",@"img":@"ico_me_hunyan"},@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];
            }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
                //MARK: 摄影/摄像
                //照片/视频/案例/结算 //FIXME: 18-08-17 结算暂时隐藏 18-08-18 照片视频暂时隐藏
                cell.nameArr = @[@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"客源分配",@"img":@"ico_me_keyuanfenpei"},@{@"name":@"我的案例",@"img":@"ico_me_MyAnLi"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];
            }else if (HunQing(self.professionID)){
                //MARK: 婚庆 - 5-24添加
                //案例/结算/下载链接 //FIXME: 18-08-17 结算暂时隐藏
                cell.nameArr = @[@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"客源分配",@"img":@"ico_me_keyuanfenpei"},@{@"name":@"我的案例",@"img":@"ico_me_MyAnLi"},@{@"name":@"下载婚庆版",@"img":@"ico_me_download"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];
            }else{
                //MARK: 其他
                //案例/结算 //FIXME: 18-08-17 结算暂时隐藏
                cell.nameArr = @[@{@"name":@"婚礼支付",@"img":@"ico_me_hunliPay"},@{@"name":@"客源分配",@"img":@"ico_me_keyuanfenpei"},@{@"name":@"我的案例",@"img":@"ico_me_MyAnLi"},@{@"name":@"我的礼品",@"img":@"icon_me_mygift"},@{@"name":@"邀请结婚",@"img":@"ico_me_invite"},@{@"name":@"分享APP",@"img":@"ico_me_share"}];
            }
        }else{
            cell.nameArr = @[@{},@{},@{},@{},@{},@{},@{},@{},@{}];
        }
        
        //MARK: section 2 点击block
        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
            if (!UserId_New) {
                
                //2-11 修改 登录判断
                YPReLoginController *first = [[YPReLoginController alloc]init];
                UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                [self presentViewController:firstNav animated:YES completion:nil];
                
            }else{
                if ([sectionName isEqualToString:@"婚礼照片"]) {
                    if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)){
                        //4-10 修改 直接进入照片详情
                        YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
                        xinren.corpName = @"婚礼照片";
                        [self.navigationController pushViewController:xinren animated:YES];
                    }else if (SheYing(self.professionID) || SheXiang(self.professionID)){
                        //MARK: 摄影/摄像4
                        YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
                        manList.professionStr = @"0";
                        manList.fromType = @"1";
                        [self.navigationController pushViewController:manList animated:YES];
                    }
                    
                }else if ([sectionName isEqualToString:@"婚礼视频"]) {
                    if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)){
                        //4-10 修改 直接进入视频详情
                        HRMeViedoViewController *video = [[HRMeViedoViewController alloc]init];
                        video.fromType = @"1";//1新人自己查看视频
                        video.professionStr = @"1";//4-10 修改 1:新人
                        [self.navigationController pushViewController:video animated:YES];
                    }else if (SheYing(self.professionID) || SheXiang(self.professionID)){
                        //MARK: 摄影/摄像4
                        YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
                        manList.professionStr = @"0";
                        manList.fromType =@"2";
                        [self.navigationController pushViewController:manList animated:YES];
                    }
                }else if ([sectionName isEqualToString:@"邀请结婚"]){
//                    YPReYQJHController *yqjh = [[YPReYQJHController alloc]init];
//                    [self.navigationController pushViewController:yqjh animated:YES];
                    
                    if (!UserId_New) {
                        
                        //2-11 修改 登录判断
                        YPReLoginController *first = [[YPReLoginController alloc]init];
                        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                        [self presentViewController:firstNav animated:YES completion:nil];
                        
                    }else{
                        //18-10-15 邀请结婚
//                        [self GetInvitationProfit];
                        [self.navigationController.tabBarController setSelectedIndex:3];
                    }
                    
                }else if ([sectionName isEqualToString:@"领取礼品"]){
                    HRWeChatDuiHuanController *duiHuan = [[HRWeChatDuiHuanController alloc]init];
                    [self.navigationController pushViewController:duiHuan animated:YES];
                }else if ([sectionName isEqualToString:@"分享APP"]){
                    //邀请下载
                    [self showShareSDK];
                }else if ([sectionName isEqualToString:@"下载婚庆版"]){
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1291642770?mt=8"]];//1291642770
                    [[UIApplication sharedApplication] openURL:url];
                }else if ([sectionName isEqualToString:@"宴会厅管理"]){
                    YPMeYanHuiTingList181115Controller *yanhuiting = [[YPMeYanHuiTingList181115Controller alloc]init];
                    [self.navigationController yp_pushViewController:yanhuiting animated:YES];
                }else if ([sectionName isEqualToString:@"我的车队"]){
                    if (HunChe(self.professionID)) {
                        //MARK: 婚车4
                        YPMyCarTeamController *mem = [[YPMyCarTeamController alloc]init];
                        [self.navigationController yp_pushViewController:mem animated:YES];
                    }else if (CheShou(self.professionID)){
                        //MARK: 车手2
                        //9.21 判断当前账号是否审核通过 -- 不通过不能点击 不能创建车队
                        if ([self.userInfo.StatusType integerValue] == 1) {//0未审核、1审核通过、2审核驳回
                            
                            if ([self.userInfo.IsMotorcade integerValue] == 0) {//未加入车队
                                
                                if ([self.userInfo.IsNews integerValue] == 0) {//是否有邀请消息 0没有、1有
                                    
                                    //没有邀请信息
                                    YPMyCarNoMemberController *noMem = [[YPMyCarNoMemberController alloc]init];
                                    [self.navigationController yp_pushViewController:noMem animated:YES];
                                    
                                }else if ([self.userInfo.IsNews integerValue] == 1){
                                    
                                    //有邀请信息
                                    YPMemberCarTeamInviteController *invite = [[YPMemberCarTeamInviteController alloc]init];
                                    [self.navigationController yp_pushViewController:invite animated:YES];
                                }
                            }else if ([self.userInfo.IsMotorcade integerValue] == 1){//已加入车队
                                YPMemberCarTeamController *mem = [[YPMemberCarTeamController alloc]init];
                                mem.captainID = self.userInfo.CaptainID;
                                [self.navigationController yp_pushViewController:mem animated:YES];
                            }
                        }
                    }
                }else if ([sectionName isEqualToString:@"车辆管理"]){
                    YPMyCarController *car = [[YPMyCarController alloc]init];
                    car.carModelID = self.userInfo.ModelID;
                    [self.navigationController yp_pushViewController:car animated:YES];
                }else if ([sectionName isEqualToString:@"我的案例"]){
                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                    [self.navigationController yp_pushViewController:anli animated:YES];
                }else if ([sectionName isEqualToString:@"结算记录"]){
                    YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
                    [self.navigationController yp_pushViewController:balance animated:YES];
                }else if ([sectionName isEqualToString:@"婚礼支付"]){
                    
                    if (YongHu(self.professionID)) {
                        //用户 婚礼支付
                        YPHotelPayController *pay = [[YPHotelPayController alloc]init];
                        [self.navigationController yp_pushViewController:pay animated:YES];
                    }else{
                        //商家 婚礼订单
                        YPWeddingOrderBaseController *wed = [[YPWeddingOrderBaseController alloc]init];
                        [self.navigationController yp_pushViewController:wed animated:YES];
                    }
                    
                }else if ([sectionName isEqualToString:@"客源分配"]){//18-11-01 客源分配
                    YPMyKeYuan190311BaseController *wed = [[YPMyKeYuan190311BaseController alloc]init];
                    [self.navigationController yp_pushViewController:wed animated:YES];
                }else if ([sectionName isEqualToString:@"我的礼品"]){//19-01-15 原订单放到下边 郝
                    YPMyOrderListController *orderVC = [YPMyOrderListController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }else if ([sectionName isEqualToString:@"婚宴订单"]){//19-02-23 婚宴订单
                    YPMeTeHuiOrderBaseController *tehuiVC = [[YPMeTeHuiOrderBaseController alloc]init];
                    [self.navigationController pushViewController:tehuiVC animated:YES];
                }else if ([sectionName isEqualToString:@"我的预订"]){//19-05-19 我的预订
                    YPMe190519MyReserveController *yudingVC = [[YPMe190519MyReserveController alloc]init];
                    [self.navigationController pushViewController:yudingVC animated:YES];
                }
            }
        };
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 60;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = ClearColor;

        UILabel *label = [[UILabel alloc]init];
        label.text = @"婚礼服务";
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = RGBA(232, 178, 99, 1);
        [view addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(label.mas_left).mas_offset(-15);
            make.centerY.mas_equalTo(label);
            make.size.mas_equalTo(CGSizeMake(24, 2));
        }];
        
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = RGBA(232, 178, 99, 1);
        [view addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(label);
            make.size.mas_equalTo(CGSizeMake(24, 2));
        }];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }
    }
    
}

-(void)showShareSDK{
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"送您一份新婚礼，快去婚礼桥APP领取！",
                                                   @"text" :@"婚庆、婚纱，全部花多少返多少！婚礼对戒等更多豪礼速来领！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   //                                                   @"url"  :@"http://www.chenghunji.com/Redbag/index"}
                                                   @"url"  :@"https://itunes.apple.com/cn/app/id1289565288?mt=8"}//FIXME: 18-08-18 修改成跳App Store
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                          [EasyShowTextView showSuccessText:@"分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
    
    
    
}

#pragma mark - target
- (void)setBtnClick{
    NSLog(@"setBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        YPSettingController *set = [[YPSettingController alloc]init];
        [self.navigationController yp_pushViewController:set animated:YES];
    }
}

- (void)guanzhuFensiBtnClick{
    NSLog(@"guanzhuFensiBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        YPReMeGuanzhuFensiController *list = [[YPReMeGuanzhuFensiController alloc]init];
        list.guanzhu = self.userInfo.FollowNumber;
        list.fensi = self.userInfo.FansNumber;
        [self.navigationController pushViewController:list animated:YES];
    }
    
}

- (void)goToHomePageBtnClick{
    NSLog(@"goToHomePageBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
    
        YPGoToHomePageWebController *goVC = [[YPGoToHomePageWebController alloc]init];
        goVC.professionID = self.professionID;
        [self.navigationController pushViewController:goVC animated:YES];
    }
}

- (void)infoEditBtnClick{
    NSLog(@"infoEditBtnClick");
    
    //18-08-11 修改 用户直接进个人资料
    if (CheShou(self.professionID) || YongHu(self.professionID)){//车手 新人-用户
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else{//供应商选择进入个人资料/供应商资料(两种资料都有)
        
        //18-11-30 供应商只有供应商资料
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
//        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑个人资料",@"编辑商家资料", nil];
//        [sheet showInView:self.view];
        
    }
}

- (void)changeBtnClick{
    NSLog(@"changeBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        YPChangeAccountController *change = [[YPChangeAccountController alloc]init];
        [self.navigationController pushViewController:change animated:YES];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSLog(@"个人资料");
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
    }else if (buttonIndex == 1){
        NSLog(@"供应商资料");
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
    }
    
}

#pragma mark - 网络请求
#pragma mark 获取个人/供应商信息
- (void)GetUserFacilitatorInfo{
    
    NSString *url = @"/api/HQOAApi/GetUserFacilitatorInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = UserId_New;//18-08-11 用户ID-徐
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        NSLog(@"我的返回：%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.userInfo.UserId = [object valueForKey:@"UserId"];
            self.userInfo.Phone = [object valueForKey:@"Phone"];
            self.userInfo.Name = [object valueForKey:@"Name"];
            self.userInfo.Profession = [object valueForKey:@"Profession"];
            self.userInfo.Headportrait = [object valueForKey:@"Headportrait"];
            self.userInfo.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            self.userInfo.ModelID = [object valueForKey:@"ModelID"];
            self.userInfo.Address = [object valueForKey:@"Address"];
            
            self.userInfo.IsMotorcade = [object valueForKey:@"IsMotorcade"];
            self.userInfo.CaptainID = [object valueForKey:@"CaptainID"];
            self.userInfo.IsNews = [object valueForKey:@"IsNews"];
            
            self.userInfo.Abstract = [object valueForKey:@"Abstract"];
            
            //5-29
            self.userInfo.FollowNumber = [[object valueForKey:@"FollowNumber"] integerValue];
            self.userInfo.FansNumber = [[object valueForKey:@"FansNumber"] integerValue];
            
            self.userInfo.region = [object valueForKey:@"region"];
            self.userInfo.regionname = [object valueForKey:@"regionname"];
            self.userInfo.StatusType = [object valueForKey:@"StatusType"];
            
            self.iconImgUrl = self.userInfo.Headportrait;
            self.titleName = self.userInfo.Name;
            self.professionID = self.userInfo.Profession;
            
            //18-08-16
            self.userInfo.WeChatName = [object valueForKey:@"WeChatName"];
            self.userInfo.WeChatType = [object valueForKey:@"WeChatType"];
            
            //18-11-02 婚期
            self.userInfo.Wedding = [object valueForKey:@"Wedding"];
            
            //保存信息
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.UserId forKey:@"UserId_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Name forKey:@"Name_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Headportrait forKey:@"Headportrait_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Profession forKey:@"Profession_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Phone forKey:@"Phone_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.FacilitatorId forKey:@"FacilitatorId_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.WeChatName forKey:@"WeChatName_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.WeChatType forKey:@"WeChatType_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Wedding forKey:@"Wedding_New"];
            
            [self.tableView reloadData];
            
            if (JiuDian(self.professionID)) {
                //酒店切换页面
                
                NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray: self.tabBarController.viewControllers];
                [vcs removeLastObject];
                
                CXManagerHomeVC *f1 =[[CXManagerHomeVC alloc]init];
                f1.tabBarItem.title =@"管理";
                f1.tabBarItem.image = [[UIImage imageNamed:@"guanli"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                f1.tabBarItem.selectedImage = [[UIImage imageNamed:@"guanli-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                HRNavigationController *navC = [[HRNavigationController alloc] initWithRootViewController:f1];
                [vcs addObject:navC];
                
                self.tabBarController.viewControllers =vcs;
            }
         
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 获取邀请收益 18-10-18 邀请结婚
- (void)GetInvitationProfit{
    
    NSString *url = @"/api/HQOAApi/GetInvitationProfit";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.profitModel.RefereeStatus = [object objectForKey:@"RefereeStatus"];
            self.profitModel.TopBanner = [object objectForKey:@"TopBanner"];
            self.profitModel.EndBanner = [object objectForKey:@"EndBanner"];
            self.profitModel.Money = [object objectForKey:@"Money"];
            
            if (self.profitModel.RefereeStatus.integerValue == 0) {//0普通用户,1VIP
                //普通
                YPInviteFriendsWedNormalController *yqjh = [[YPInviteFriendsWedNormalController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
                
            }else if (self.profitModel.RefereeStatus.integerValue == 1){
                //VIP
                YPInviteFriendsWedVIPController *yqjh = [[YPInviteFriendsWedVIPController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (YPGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPGetUserInfo alloc]init];
    }
    return _userInfo;
}

- (YPGetInvitationProfit *)profitModel{
    if (!_profitModel) {
        _profitModel = [[YPGetInvitationProfit alloc]init];
    }
    return _profitModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
