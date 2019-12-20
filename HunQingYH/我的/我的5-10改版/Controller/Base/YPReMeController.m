//
//  YPReMeController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeController.h"
#pragma mark - View
#import "YPReMeHeaderCell.h"
#import "YPReMeFourBtnCell.h"
#import "YPReMeTwoBtnCell.h"
#import "YPReMeSelectCell.h"

#pragma mark - 新 Controller
#import "YPReMeMyArrangeController.h"//我的安排
//#import "HRYQJHController.h"//邀请结婚
//5-23 邀请结婚
#import "YPReYQJHController.h"

#pragma mark - 旧 Controller
#import "YPSettingController.h"//设置
#import "YPMyCarController.h"//我的车辆
#import "YPMyCarTeamController.h"//我的车队 队长界面
#import "YPMyCarNoMemberController.h"//我的车队 成员界面 没有加入车队 没有邀请
#import "YPMemberCarTeamController.h"//我的车队 成员界面 已加入车队
#import "YPMemberCarTeamInviteController.h"//我的车队 成员界面 没有加入车队 有邀请
#import "YPBalanceRecordController.h"//结算记录
#import "YPMyAnliListController.h"//我的案例
//#import "YPMyCollectionController.h"//我的收藏
#import "YPReMyCollectionController.h"//我的收藏 9.8重做
//#import "YPMyCollectionSupplierController.h"//我的收藏 - 只有供应商 - 9.14
#import "YPReReMyCollectionController.h"//我的收藏 -- 1.16重做
#import "YPYanHuiTingListController.h"//宴会厅管理
#import "YPHotelInfoController.h"//酒店资料
#import "YPPersonInfoController.h"//个人资料 -- 用户/车手
#import "YPSupplierPersonInfoController.h"//供应商个人资料
#import "YPGetUserInfo.h"
#import "HRMyCollectionViewController.h"
//#import "YPFirstViewController.h"
//10-30 添加
#import "HRFeedBackViewController.h"//意见反馈
//11-15 添加
//#import "HRYaoQingViewController.h"//领取礼品
//1-15 修改
#import "YPReMeHeaderView.h"
#import "YPReMeInfoController.h"//个人信息
//1-25 添加
#import "HRMyFaXianViewController.h"//我的动态
//2-24 添加
#import "HRWeChatDuiHuanController.h"//输入微信兑换码
//2-28 - 我的钱包
#import "YPMyWalletBaseController.h"
////3-23 婚礼照片-新人
//#import "YPMeXinRenPhotoController.h"
////3-23 婚礼照片-供应商
//#import "YPMeSupplierPhotoController.h"
//3-26 婚礼照片
#import "YPMePhotoManListController.h"
//4- 10 修改 新人直接进照片/视频详情
#import "YPMeXinRenPhotoController.h"
#import "HRMeViedoViewController.h"
//4-24 添加 婚礼返还-我的订单
#import "YPMyEDuOrderController.h"
//5-29 添加 关注粉丝
#import "YPReMeGuanzhuFensiController.h"
//6-27 添加 前往主页
#import "YPGoToHomePageWebController.h"

//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "HRShareAppViewController.h"
#import "HRGZFSController.h"

@interface YPReMeController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetUserInfo *userInfo;

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *iconImgUrl;
@property (nonatomic, copy) NSString *professionID;

@end

@implementation YPReMeController{
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
    
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-49-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"reMe_setting"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.right.mas_equalTo(_navView).mas_offset(-15);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
    //18-08-18 照片视频暂时隐藏 FIXME: 18-08-18 婚车/车手等同用户
    if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)) {
        return 2;
    }else{
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        //MARK: 婚车 -- FIXME: 18-08-18 婚车等同用户
//        if (HunChe(self.professionID)) {
//            return 3;//案例/结算/车队/车辆 //FIXME: 18-08-17 结算暂时隐藏
//
//        }
        //MARK: 车手 -- FIXME: 18-08-18 车手等同用户
//        else if (CheShou(self.professionID)){
//            return 2;//车队/车辆
//        }
        //MARK: 酒店
        if (JiuDian(self.professionID)){//FIXME: 18-08-14 去掉酒店资料
            return 2;//案例/宴会厅/   (酒店资料(管理))
        //MARK: 用户 FIXME: 18-08-18 婚车/车手等同用户
        }else if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)){
            return 2; //照片/视频 FIXME: 18-08-18 照片视频暂时隐藏 直接显示两组
        //MARK: 摄影/摄像
        }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
            return 1;//照片/视频/案例/结算 //FIXME: 18-08-17 结算暂时隐藏 18-08-18 照片视频暂时隐藏
        //MARK: 婚庆 - 5-24添加
        }else if (HunQing(self.professionID)){
            return 2;//案例/结算/下载链接 //FIXME: 18-08-17 结算暂时隐藏
        //MARK: 其他
        }else{
            return 1;//案例/结算 //FIXME: 18-08-17 结算暂时隐藏
        }
    }else{
//        return 3;//FIXME: 18-08-16 领取礼品隐藏
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //MARK: section 0
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPReMeHeaderCell *cell = [YPReMeHeaderCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //2-11 修改
            if (!UserId_New) {
                cell.titleLabel.text = @"点击登录";
                [cell.iconImgV setImage:[UIImage imageNamed:@"1024"]];
                cell.editBtn.hidden = YES;
                
                //5-29 添加
                cell.shenfenLabel.hidden = YES;
                cell.guanzhu.hidden = YES;
                cell.guanzhuCount.hidden = YES;
                cell.fensi.hidden = YES;
                cell.fensiCount.hidden = YES;
                cell.guanzhuFensiBtn.hidden = YES;
                cell.goToHomePageBtn.hidden = YES;
                
            }else{
                [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.userInfo.Headportrait] placeholderImage:[UIImage imageNamed:@"1024"]];
                if (self.userInfo.Name.length > 0) {
                    cell.titleLabel.text = self.userInfo.Name;
                }else{
                    cell.titleLabel.text = @"无名称";
                }
                cell.editBtn.hidden = NO;
                
                //5-29 添加
                cell.shenfenLabel.hidden = NO;
                cell.guanzhu.hidden = NO;
                cell.guanzhuCount.hidden = NO;
                cell.fensi.hidden = NO;
                cell.fensiCount.hidden = NO;
                cell.guanzhuFensiBtn.hidden = NO;
                cell.goToHomePageBtn.hidden = NO;
                
                cell.guanzhuCount.text = [NSString stringWithFormat:@"%zd",self.userInfo.FollowNumber];
                cell.fensiCount.text = [NSString stringWithFormat:@"%zd",self.userInfo.FansNumber];
                [cell.guanzhuFensiBtn addTarget:self action:@selector(guanzhuFensiBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [cell.goToHomePageBtn addTarget:self action:@selector(goToHomePageBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                if (YongHu(self.professionID)) {
                    //6-27 新人无商家主页
                    cell.goToHomePageBtn.hidden = YES;
                }
                cell.shenfenLabel.text = [CXDataManager checkUserProfession:self.professionID];
            }
            
            [cell.editBtn addTarget:self action:@selector(infoEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row == 1){
            
            YPReMeFourBtnCell *cell = [YPReMeFourBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameArr = @[@{@"name":@"动态",@"img":@"reMe_动态"},@{@"name":@"订单",@"img":@"reMe_订单"}];//,@{@"name":@"钱包",@"img":@"reMe_钱包"} FIXME: 18-08-16 钱包暂时隐藏 18-08-18 @{@"name":@"安排",@"img":@"reMe_安排"}, 安排暂时隐藏
            //MARK: section 0 item点击
            cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
                if (!UserId_New) {
                    
                    //2-11 修改 登录判断
                    YPReLoginController *first = [[YPReLoginController alloc]init];
                    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                    [self presentViewController:firstNav animated:YES completion:nil];
                    
                }else{
                    if ([sectionName isEqualToString:@"安排"]) {
                        YPReMeMyArrangeController *arrange = [[YPReMeMyArrangeController alloc]init];
                        [self.navigationController pushViewController:arrange animated:YES];
                    }else if ([sectionName isEqualToString:@"动态"]) {
                        HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                        [self.navigationController yp_pushViewController:dongtai animated:YES];
                    }else if ([sectionName isEqualToString:@"订单"]){
                        YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                        [self.navigationController pushViewController:orderVC animated:YES];
                    }else if ([sectionName isEqualToString:@"钱包"]){
                        YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                        [self.navigationController pushViewController:base animated:YES];
                    }
                }
            };
            return cell;
        }
    }else {

        YPReMeSelectCell *cell = [YPReMeSelectCell cellWithTableView:tableView];
        
        //MARK: section 1
        if (indexPath.section == 1){
            
//            //MARK: 婚车4
//            if (HunChe(self.professionID)) {//FIXME: 18-08-17 结算暂时隐藏
//                if (indexPath.row == 0) {
////                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_安排"]];
////                    cell.titleLabel.text = @"结算记录";
////                }else if (indexPath.row == 1){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_案例"]];
//                    cell.titleLabel.text = @"我的案例";
//                }else if (indexPath.row == 1){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_车队"]];
//                    cell.titleLabel.text = @"我的车队";
//                }else if (indexPath.row == 2){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_车辆"]];
//                    cell.titleLabel.text = @"我的车辆";
//                }
//            //MARK: 车手2
//            }else if (CheShou(self.professionID)){
//                if (indexPath.row == 0){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_车队"]];
//                    cell.titleLabel.text = @"我的车队";
//                }else if (indexPath.row == 1){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_车辆"]];
//                    cell.titleLabel.text = @"我的车辆";
//                }
//
//            }else
            
            //MARK: 酒店2 FIXME: 18-08-14 去掉酒店资料
            if (JiuDian(self.professionID)){
                if (indexPath.row == 0) {
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_酒店"]];
//                    cell.titleLabel.text = @"酒店资料";
//                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_厅"]];
                    cell.titleLabel.text = @"宴会厅管理";
                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_案例"]];
                    cell.titleLabel.text = @"我的案例";
                }
            //MARK: 用户2 FIXME: 18-08-18 婚车/车手等同用户
            }else if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)){//FIXME: 18-08-18 照片视频暂时隐藏 直接显示原第三组
//                if (indexPath.row == 0) {
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_Picture"]];
//                    cell.titleLabel.text = @"婚礼照片";
//                }else if (indexPath.row == 1){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_Video"]];
//                    cell.titleLabel.text = @"婚礼视频";
//                }
                
                if (indexPath.row == 0) {
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_邀请结婚"]];
                    cell.titleLabel.text = @"邀请好友来结婚";
                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_分享"]];
                    cell.titleLabel.text = @"分享APP";
                }
                
            //MARK: 摄影/摄像4
            }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
                if (indexPath.row == 0) {//FIXME: 18-08-18 照片视频暂时隐藏
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_Picture"]];
//                    cell.titleLabel.text = @"婚礼照片";
//                }else if (indexPath.row == 1){
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_Video"]];
//                    cell.titleLabel.text = @"婚礼视频";
//                }else if (indexPath.row == 2){//FIXME: 18-08-17 结算暂时隐藏
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_安排"]];
//                    cell.titleLabel.text = @"结算记录";
//                }else if (indexPath.row == 3){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_案例"]];
                    cell.titleLabel.text = @"我的案例";
                }
                
            //MARK: 婚庆3 - 5-24添加
            }else if (HunQing(self.professionID)){
                //案例/结算/下载链接
                
                if (indexPath.row == 0) {//FIXME: 18-08-17 结算暂时隐藏
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_安排"]];
//                    cell.titleLabel.text = @"结算记录";
//                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_案例"]];
                    cell.titleLabel.text = @"我的案例";
                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_婚庆版下载"]];
                    cell.titleLabel.text = @"下载婚礼桥婚庆版";
                }
                
            //MARK: 其他2
            }else{
                if (indexPath.row == 0) {//18-08-17 结算暂时隐藏
//                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_安排"]];
//                    cell.titleLabel.text = @"结算记录";
//                }else if (indexPath.row == 1){
                    [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_案例"]];
                    cell.titleLabel.text = @"我的案例";
                }
            }
            
            return cell;
        //MARK: section 2
        }else{
            
            if (indexPath.row == 0) {
                [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_邀请结婚"]];
                cell.titleLabel.text = @"邀请好友来结婚";
            }
//            else if (indexPath.row == 1){// -- 18-08-16 隐藏
//                [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_礼品"]];
//                cell.titleLabel.text = @"领取礼品";
//            }
            else if (indexPath.row == 1){
                [cell.iconImgV setImage:[UIImage imageNamed:@"reMe_分享"]];
                cell.titleLabel.text = @"分享APP";
            }
        }

        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 150;
        }else if (indexPath.row == 1){
            return 80;
        }
    }else{
        return 55;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
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
    
    if (indexPath.section == 1) {
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            
//            //MARK: 婚车4
//            if (HunChe(self.professionID)) {
//                if (indexPath.row == 0) {//结算记录 //18-08-17 结算暂时隐藏
////                    YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
////                    [self.navigationController yp_pushViewController:balance animated:YES];
////                }else if (indexPath.row == 1){//我的案例
//                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
//                    [self.navigationController yp_pushViewController:anli animated:YES];
//                }else if (indexPath.row == 1){//我的车队
//                    YPMyCarTeamController *mem = [[YPMyCarTeamController alloc]init];
//                    [self.navigationController yp_pushViewController:mem animated:YES];
//                }else if (indexPath.row == 2){//我的车辆
//                    YPMyCarController *car = [[YPMyCarController alloc]init];
//                    car.carModelID = self.userInfo.ModelID;
//                    [self.navigationController yp_pushViewController:car animated:YES];
//                }
//            //MARK: 车手2
//            }else if (CheShou(self.professionID)){
//                if (indexPath.row == 0){//我的车队
//                    //9.21 判断当前账号是否审核通过 -- 不通过不能点击 不能创建车队
//                    if ([self.userInfo.StatusType integerValue] == 1) {//0未审核、1审核通过、2审核驳回
//
//                        if ([self.userInfo.IsMotorcade integerValue] == 0) {//未加入车队
//
//                            if ([self.userInfo.IsNews integerValue] == 0) {//是否有邀请消息 0没有、1有
//
//                                //没有邀请信息
//                                YPMyCarNoMemberController *noMem = [[YPMyCarNoMemberController alloc]init];
//                                [self.navigationController yp_pushViewController:noMem animated:YES];
//
//                            }else if ([self.userInfo.IsNews integerValue] == 1){
//
//                                //有邀请信息
//                                YPMemberCarTeamInviteController *invite = [[YPMemberCarTeamInviteController alloc]init];
//                                [self.navigationController yp_pushViewController:invite animated:YES];
//                            }
//                        }else if ([self.userInfo.IsMotorcade integerValue] == 1){//已加入车队
//                            YPMemberCarTeamController *mem = [[YPMemberCarTeamController alloc]init];
//                            mem.captainID = self.userInfo.CaptainID;
//                            [self.navigationController yp_pushViewController:mem animated:YES];
//                        }
//                    }
//                }else if (indexPath.row == 1){//我的车辆
//                    YPMyCarController *myCar = [[YPMyCarController alloc]init];
//                    myCar.carModelID = self.userInfo.ModelID;
//                    [self.navigationController yp_pushViewController:myCar animated:YES];
//                }
//
//            }else
            
            //MARK: 酒店3 18-08-14 去掉酒店资料
            if (JiuDian(self.professionID)){
                if (indexPath.row == 0) {//宴会厅管理   //FIXME: 酒店资料--去掉
//                    YPHotelInfoController *hotel = [[YPHotelInfoController alloc]init];
//                    [self.navigationController yp_pushViewController:hotel animated:YES];
//                }else if (indexPath.row == 1){//宴会厅管理
                    YPYanHuiTingListController *yanhuiting = [[YPYanHuiTingListController alloc]init];
                    [self.navigationController yp_pushViewController:yanhuiting animated:YES];
                }else if (indexPath.row == 1){//我的案例
                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                    [self.navigationController yp_pushViewController:anli animated:YES];
                }
            //MARK: 用户2 FIXME: 18-08-18 婚车/车手等同用户
            }else if (YongHu(self.professionID) || HunChe(self.professionID) || CheShou(self.professionID)){
                //FIXME: 18-08-18 照片视频暂时隐藏
//                if (indexPath.row == 0) {//婚礼照片
//                    //4-10 修改 直接进入照片详情
//                    YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
//                    xinren.corpName = @"婚礼照片";
//                    [self.navigationController pushViewController:xinren animated:YES];
//                }else if (indexPath.row == 1){//婚礼视频
//                    //4-10 修改 直接进入视频详情
//                    HRMeViedoViewController *video = [[HRMeViedoViewController alloc]init];
//                    video.fromType = @"1";//1新人自己查看视频
//                    video.professionStr = @"1";//4-10 修改 1:新人
//                    [self.navigationController pushViewController:video animated:YES];
//                }
                
                if (!UserId_New) {
                    
                    //2-11 修改 登录判断
                    YPReLoginController *first = [[YPReLoginController alloc]init];
                    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                    [self presentViewController:firstNav animated:YES completion:nil];
                    
                }else{
                    if (indexPath.row == 0) {//邀请结婚
                        
                        //5-23
                        YPReYQJHController *yqjh = [[YPReYQJHController alloc]init];
                        [self.navigationController pushViewController:yqjh animated:YES];
                        
                    }
                    else if (indexPath.row == 1){//分享APP
                        //                //邀请下载
                        [self showShareSDK];
                    }
                }
                
            //MARK: 摄影/摄像4
            }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
                //FIXME: 18-08-18 照片视频暂时隐藏
                if (indexPath.row == 0) {//婚礼照片
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    manList.professionStr = @"0";
//                    manList.fromType = @"1";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }else if (indexPath.row == 1){//婚礼视频
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    manList.professionStr = @"0";
//                    manList.fromType =@"2";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }else if (indexPath.row == 2){//结算记录 //FIXME: 18-08-17 结算暂时隐藏
//                    YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
//                    [self.navigationController yp_pushViewController:balance animated:YES];
//                }else if (indexPath.row == 3){//我的案例
                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                    [self.navigationController yp_pushViewController:anli animated:YES];
                }
                
            //MARK: 婚庆3 - 5-24添加
            }else if (HunQing(self.professionID)){
                
                if (indexPath.row == 0) {//结算记录 //FIXME: 18-08-17 结算暂时隐藏
//                    YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
//                    [self.navigationController yp_pushViewController:balance animated:YES];
//                }else if (indexPath.row == 1){//我的案例
                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                    [self.navigationController yp_pushViewController:anli animated:YES];
                }else if (indexPath.row == 1){//下载婚庆版
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1291642770?mt=8"]];//1291642770
                    [[UIApplication sharedApplication] openURL:url];
                }
                
            //MARK: 其他2
            }else{
                if (indexPath.row == 0) {//结算记录 //FIXME: /18-08-17 结算暂时隐藏
//                    YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
//                    [self.navigationController yp_pushViewController:balance animated:YES];
//                }else if (indexPath.row == 1){//我的案例
                    YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                    [self.navigationController yp_pushViewController:anli animated:YES];
                }
            }
        }
    }
    
    //MARK: section 2
    if (indexPath.section == 2) {
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            if (indexPath.row == 0) {//邀请结婚
//                HRYQJHController *yqjh = [[HRYQJHController alloc]init];
//                [self.navigationController pushViewController:yqjh animated:YES];
                
                //5-23
                YPReYQJHController *yqjh = [[YPReYQJHController alloc]init];
                [self.navigationController pushViewController:yqjh animated:YES];
                
            }
//            else if (indexPath.row == 1){//领取礼品 -- 18-08-16 隐藏
//                HRWeChatDuiHuanController *duiHuan = [[HRWeChatDuiHuanController alloc]init];
//                [self.navigationController pushViewController:duiHuan animated:YES];
//            }
            else if (indexPath.row == 1){//分享APP
//                //邀请下载
//                HRShareAppViewController *downVC = [HRShareAppViewController new];
//                [self.navigationController pushViewController:downVC animated:YES];
                
                //18-08-16 修改 暂时本地分享 回调不调接口
                [self showShareSDK];
            }
        }
    }
}

-(void)showShareSDK{
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"【邀好友】婚礼桥送现金福利！点开即得！",
                                                   @"text" :@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在婚礼桥！",
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

- (void)infoEditBtnClick{
    NSLog(@"infoEditBtnClick");
    
    //18-08-11 修改 用户直接进个人资料
    if (CheShou(self.professionID) || YongHu(self.professionID)){//车手 新人-用户
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else{//供应商选择进入个人资料/供应商资料(两种资料都有)
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"个人资料",@"供应商资料", nil];
        [sheet showInView:self.view];

    }
}

- (void)guanzhuFensiBtnClick{
    NSLog(@"guanzhuFensiBtnClick");
    
    YPReMeGuanzhuFensiController *list = [[YPReMeGuanzhuFensiController alloc]init];
    list.guanzhu = self.userInfo.FollowNumber;
    list.fensi = self.userInfo.FansNumber;
    [self.navigationController pushViewController:list animated:YES];
    
}

- (void)goToHomePageBtnClick{
    NSLog(@"goToHomePageBtnClick");
    
    YPGoToHomePageWebController *goVC = [[YPGoToHomePageWebController alloc]init];
    goVC.professionID = self.professionID;
    [self.navigationController pushViewController:goVC animated:YES];
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
            
            [self.tableView reloadData];
            
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
