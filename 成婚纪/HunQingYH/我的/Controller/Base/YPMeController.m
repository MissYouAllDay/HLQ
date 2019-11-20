//
//  YPMeController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMeController.h"
#import "YPMeHeaderView.h"
#import "YPMeTwoBtnCell.h"
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

//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "HRShareAppViewController.h"
#import "HRGZFSController.h"
@interface YPMeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetUserInfo *userInfo;

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *iconImgUrl;
@property (nonatomic, copy) NSString *professionID;

@end

@implementation YPMeController{
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
    
    NSArray *vcsArray = [self.navigationController viewControllers];
    NSLog(@"vcs -- %@",vcsArray);
//    NSInteger vcCount = vcsArray.count;
//    if (vcCount > 1) {
//        UIViewController *lastVC = vcsArray[vcCount-2];//最后一个vc是自己，倒数第二个是上一个控制器
//        if ([lastVC isKindOfClass:[YPSettingController class]]) {
//            [self showTabBar];
//        }
//    }
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

//#pragma mark - 通知
//- (void)jumpToLoginVC{
//
//    YPFirstViewController *first = [[YPFirstViewController alloc]init];
//    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
//    [self presentViewController:firstNav animated:YES completion:nil];
//}
//
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoginOutThenLoginIn" object:nil];
//}

#pragma mark - UI
- (void)setupUI{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-49-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.right.mas_equalTo(_navView).mas_offset(-15);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (HunChe(self.professionID) || CheShou(self.professionID) || JiuDian(self.professionID)) {
//        return 3;
//    }else if (YongHu(self.professionID)){
//        return 1;
//    }
//    return 0;
    
    if (YongHu(self.professionID)){
        return 1;
    }else if (CheShou(self.professionID)){
        return 2;
    }else{
        return 3;
    }
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (HunChe(self.professionID)) {//队长-婚车
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 3;//1-25 隐藏 我的收藏
//            return 4;//1-15 添加 我的动态
        }else{
//            return 3;
            //2-24 添加 领取礼品
//            return 4;
//            //3-23 添加婚礼照片/婚礼视频 - 只有新人/摄影/摄像有
//            return 7;
//            //2- 28 添加 我的钱包
//            return 5;
            //4-24 我的订单
            return 6;
        }
    }else if (CheShou(self.professionID)){//队员-车手
        if (section == 0) {
            return 3;//1-25 隐藏 我的收藏
//            return 4;//1-15 添加 我的动态
        }else{
//            return 3;
            //2-24 添加 领取礼品
//            return 4;
//            //3-23 添加婚礼照片/婚礼视频 - 只有新人/摄影/摄像有
//            return 7;
//            //2- 28 添加 我的钱包
//            return 5;
            //4-24 我的订单
            return 6;
        }
    }else if (JiuDian(self.professionID)){
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 2;//1-25 隐藏 我的收藏
//            return 3 ;//1-15 添加 我的动态
        }else{
//            return 4;
            //2-24 添加 领取礼品
//            return 5;
//            //3-23 添加婚礼照片/婚礼视频 - 只有新人/摄影/摄像有
//            return 8;
//            //2- 28 添加 我的钱包
//            return 6;
            //4-24 我的订单
            return 7;
        }
    }else if (YongHu(self.professionID)){//新人-用户
//        return 4;//1-25 隐藏 我的收藏
//        return 5;//1-15 添加 我的动态
        //2- 28 添加 我的钱包
//        return 6;
//        //3-23 添加婚礼照片/婚礼视频
//        return 8;
        //4-24 我的订单
        return 9;
        
    }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
        
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 1;//1-25 隐藏 我的收藏
            //            return 2;//1-15 添加 我的动态
        }else if (section == 2){

//            //3-23 添加婚礼照片/婚礼视频
//            return 7;
            //4-24 我的订单
            return 8;
        }
        
    }else{
        
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 1;//1-25 隐藏 我的收藏
//            return 2;//1-15 添加 我的动态
        }else if (section == 2){
//            return 3;
            //2-24 添加 领取礼品
//            return 4;
            //3-23 添加婚礼照片/婚礼视频 - 只有新人/摄影/摄像有
//            return 7;
//            //2- 28 添加 我的钱包
//            return 5;
            //4-24 我的订单
            return 6;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //MARK: 婚车
    if (HunChe(self.professionID)) {
        if (indexPath.section == 0) {
            
            YPMeTwoBtnCell *cell = [YPMeTwoBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.anliBtn addTarget:self action:@selector(anliBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.section == 1) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"我的车辆";
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"我的车队";
            }else if (indexPath.row == 2) {
//                cell.textLabel.text = @"我的收藏";
//            }else if (indexPath.row == 3) {//1-15 添加
                cell.textLabel.text = @"我的动态";
            }
            
            return cell;
            
        }else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
//            //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//            if (indexPath.row == 0) {
//                cell.textLabel.text = @"婚礼照片";
//
//            }
//            else if (indexPath.row == 1) {
//                cell.textLabel.text = @"婚礼视频";
//
//            }
            
            //2-28 添加 我的钱包
            if (indexPath.row == 1) {
                cell.textLabel.text = @"我的钱包";
                
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"个人资料";
                
            }
            //2-24 打开
            else if (indexPath.row == 3) {
                cell.textLabel.text = @"领取礼品";
            }
            else if (indexPath.row == 4) {
                cell.textLabel.text = @"分享APP";
                
                UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = @"分享给好友赚现金";
                label.textColor = MainColor;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
            }else if (indexPath.row == 5) {
                cell.textLabel.text = @"意见反馈";
            }
        
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
            }
            
            return cell;
        }
    //MARK: 车手
    }else if (CheShou(self.professionID)){
        if (indexPath.section == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"我的车辆";
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"我的车队";
            }else if (indexPath.row == 2) {
//                cell.textLabel.text = @"我的收藏";
//            }else if (indexPath.row == 3) {//1-15 添加
                cell.textLabel.text = @"我的动态";
            }
            
            return cell;
            
        }else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
//            //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//            if (indexPath.row == 0) {
//                cell.textLabel.text = @"婚礼照片";
//
//            }
//            else if (indexPath.row == 1) {
//                cell.textLabel.text = @"婚礼视频";
//
//            }
            
            //2-28 添加 我的钱包
            if (indexPath.row == 1) {
                cell.textLabel.text = @"我的钱包";
                
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"个人资料";

            }
            //2-24 打开
            else if (indexPath.row == 3) {
                cell.textLabel.text = @"领取礼品";
            }
            else if (indexPath.row == 4) {
                cell.textLabel.text = @"分享APP";
                
                UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = @"分享给好友赚现金";
                label.textColor = MainColor;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
            }else if (indexPath.row == 5) {
                cell.textLabel.text = @"意见反馈";
            }
            
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
            }
        
            return cell;
        }
    //MARK: 酒店
    }else if (JiuDian(self.professionID)){
        if (indexPath.section == 0) {
            
//            YPMeTwoBtnCell *cell = [YPMeTwoBtnCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell.jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [cell.anliBtn addTarget:self action:@selector(anliBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            return cell;
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"我的案例";
           
            
            return cell;
        }else if (indexPath.section == 1) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"宴会厅管理";
            }else if (indexPath.row == 1) {
//                cell.textLabel.text = @"我的收藏";
//            }else if (indexPath.row == 2) {//1-15 添加
                cell.textLabel.text = @"我的动态";
            }
            
            return cell;
            
        }else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
//            //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//            if (indexPath.row == 0) {
//                cell.textLabel.text = @"婚礼照片";
//
//            }
//            else if (indexPath.row == 1) {
//                cell.textLabel.text = @"婚礼视频";
//
//            }
            
            //2-28 添加 我的钱包
            if (indexPath.row == 1) {
                cell.textLabel.text = @"我的钱包";
                
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"酒店资料";
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"个人资料";
            
            }
            //2-24 打开
            else if (indexPath.row == 4) {
                cell.textLabel.text = @"领取礼品";
            }
            else if (indexPath.row == 5) {
                cell.textLabel.text = @"分享APP";
                
                UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = @"分享给好友赚现金";
                label.textColor = MainColor;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
            }else if (indexPath.row == 6) {
                cell.textLabel.text = @"意见反馈";
            }
            
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
            }
            
            return cell;
        }
    //MARK: 用户
    }else if (YongHu(self.professionID)){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //3-23 添加 照片 视频
        if (indexPath.row == 1) {
            cell.textLabel.text = @"婚礼照片";
            
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"婚礼视频";
            
        }
        
        //2-28 添加 我的钱包
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"我的钱包";
            
        }
        else if (indexPath.row == 4) {
//            cell.textLabel.text = @"我的收藏";
//        }else if (indexPath.row == 1) {//1-15 添加
            cell.textLabel.text = @"我的动态";
//        }else if (indexPath.row == 2) {
        }else if (indexPath.row == 5) {
            cell.textLabel.text = @"个人资料";
        
//        }else if (indexPath.row == 3) {
        }
        //2-24 打开
        else if (indexPath.row == 6) {
            cell.textLabel.text = @"领取礼品";
        }
        else if (indexPath.row == 7) {
            
            cell.textLabel.text = @"分享APP";
            
            UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
            [cell.contentView addSubview:imgV];
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-5);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            UILabel *label = [[UILabel alloc]init];
            label.text = @"分享给好友赚现金";
            label.textColor = MainColor;
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
//        }else if (indexPath.row == 4) {
        }else if (indexPath.row == 8) {
            
            cell.textLabel.text = @"意见反馈";
        }

        //MARK: 4-24 我的订单
        else if (indexPath.row == 0) {
            cell.textLabel.text = @"我的订单";
        }
        
        return cell;
    //MARK: 摄影/摄像
    }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
        
        if (indexPath.section == 0) {
            
            YPMeTwoBtnCell *cell = [YPMeTwoBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.anliBtn addTarget:self action:@selector(anliBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.section == 1) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                //                cell.textLabel.text = @"我的收藏";
                //            }else if (indexPath.row == 1) {//1-15 添加
                cell.textLabel.text = @"我的动态";
            }
            return cell;
            
        }else if (indexPath.section == 2) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            //3-23 添加 照片 视频
            if (indexPath.row == 1) {
                cell.textLabel.text = @"婚礼照片";
                
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"婚礼视频";
                
            }
            
            //2-28 添加 我的钱包
            else if (indexPath.row == 3) {
                cell.textLabel.text = @"我的钱包";
                
            }
            else if (indexPath.row == 4) {
                cell.textLabel.text = @"个人资料";
                
            }
            //2-24 打开
            else if (indexPath.row == 5) {
                cell.textLabel.text = @"领取礼品";
            }
            else if (indexPath.row == 6) {
                cell.textLabel.text = @"分享APP";
                
                UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = @"分享给好友赚现金";
                label.textColor = MainColor;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                
            }else if (indexPath.row == 7) {
                cell.textLabel.text = @"意见反馈";
            }
            
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
            }
            
            return cell;
            
        }
    //MARK: 其他
    }else{
        
        if (indexPath.section == 0) {
            
            YPMeTwoBtnCell *cell = [YPMeTwoBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.anliBtn addTarget:self action:@selector(anliBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.section == 1) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
//                cell.textLabel.text = @"我的收藏";
//            }else if (indexPath.row == 1) {//1-15 添加
                cell.textLabel.text = @"我的动态";
            }
            return cell;
            
        }else if (indexPath.section == 2) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
//            //3-23 添加 照片 视频 - 3-28 只有新人/摄像/摄影有
//            if (indexPath.row == 0) {
//                cell.textLabel.text = @"婚礼照片";
//
//            }
//            else if (indexPath.row == 1) {
//                cell.textLabel.text = @"婚礼视频";
//
//            }
            
            //2-28 添加 我的钱包
            if (indexPath.row == 1) {
                cell.textLabel.text = @"我的钱包";
                
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"个人资料";
            
            }
            //2-24 打开
            else if (indexPath.row == 3) {
                cell.textLabel.text = @"领取礼品";
            }
            else if (indexPath.row == 4) {
                cell.textLabel.text = @"分享APP";
                
                UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_Share_gift"]];
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.text = @"分享给好友赚现金";
                label.textColor = MainColor;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(imgV.mas_left).mas_offset(-5);
                    make.centerY.mas_equalTo(cell.contentView);
                }];
                
            }else if (indexPath.row == 5) {
                cell.textLabel.text = @"意见反馈";
            }
            
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
            }
            
            return cell;
            
        }
        
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (YongHu(self.professionID) || CheShou(self.professionID) || JiuDian(self.professionID)){
      
        return 50;
    }else{//其他和婚车都有结算记录
        if (indexPath.section == 0) {
            return 72;
        }else{
            return 50;
        }
    }
//    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    
        return 140;
//            return 200;
        
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        //1-15  修改
//        YPMeHeaderView *head = [YPMeHeaderView headerView];
//
//        if (JiuDian(self.professionID)) {
//            head.professionLabel.text = @"酒店";
//        }else if (HunChe(self.professionID)) {
//            head.professionLabel.text = @"婚车";
//        }else if (ZhuChi(self.professionID)) {
//            head.professionLabel.text = @"主持人";
//        }else if (SheXiang(self.professionID)) {
//            head.professionLabel.text = @"摄像师";
//        }else if (SheYing(self.professionID)) {
//            head.professionLabel.text = @"摄影师";
//        }else if (HuaZhuang(self.professionID)) {
//            head.professionLabel.text = @"化妆师";
//        }else if (YanYi(self.professionID)) {
//            head.professionLabel.text = @"演艺";
//        }else if (HunSha(self.professionID)) {
//            head.professionLabel.text = @"婚纱";
//        }else if (DuDao(self.professionID)) {
//            head.professionLabel.text = @"督导师";
//        }else if (HuaYi(self.professionID)) {
//            head.professionLabel.text = @"花艺师";
//        }else if (DongGuang(self.professionID)) {
//            head.professionLabel.text = @"灯光师";
//        }else if (YongHu(self.professionID)) {
//            head.professionLabel.text = @"用户";
//        }else if (CheShou(self.professionID)) {
//            head.professionLabel.text = @"车手";
//        }else if (HunQing(self.professionID)) {
//            head.professionLabel.text = @"婚庆";
//        }
//
//        [head.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.iconImgUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
//
//        head.nameLabel.text = self.titleName;
//
//        [head.setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        return head;
        
        
        YPReMeHeaderView *head = [YPReMeHeaderView yp_ReMeHeaderView];
        head.profession.text = [CXDataManager checkUserProfession:self.professionID];
   
        //2-11 修改
        if (!UserId_New) {
            head.nameLabel.text = @"点击登录";
//            head.profession.hidden = YES;
//            head.point.hidden = YES;
            [head.iconImgV setImage:[UIImage imageNamed:@"占位图"]];
        }else{
            head.nameLabel.text = self.titleName;
//            head.profession.hidden = NO;
//            head.point.hidden = NO;
            [head.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.iconImgUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        }

        //2-11 隐藏身份
        head.profession.hidden = YES;
        head.point.hidden = YES;
        
//        [head.iconBtn addTarget:self action:@selector(headIconBtnClick) forControlEvents:UIControlEventTouchUpInside]; //2-5 修改 不能点击头像
//        [head.infoBtn addTarget:self action:@selector(headInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [head.maskBtn addTarget:self action:@selector(maskBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return head;
        
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@",self.professionID);
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        //MARK: 婚车
        if (HunChe(self.professionID)) {//婚车-队长
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    
                    YPMyCarController *car = [[YPMyCarController alloc]init];
                    car.carModelID = self.userInfo.ModelID;
                    [self.navigationController yp_pushViewController:car animated:YES];
                    
                }else if (indexPath.row == 1) {
                    
                    YPMyCarTeamController *mem = [[YPMyCarTeamController alloc]init];
                    [self.navigationController yp_pushViewController:mem animated:YES];
                    
                }else if (indexPath.row == 2) {
                    
                    //我的收藏
    //                YPReMyCollectionController *collect = [[YPReMyCollectionController alloc]init];
                    
    //                HRMyCollectionViewController *collect = [[HRMyCollectionViewController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
                    
                    
    //                //1.16 重做
    //                YPReReMyCollectionController *collect = [[YPReReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];

    //            }else if (indexPath.row == 3){
                    
                    NSLog(@"我的动态");
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                    
                }
            }else if (indexPath.section == 2) {
                
//                //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//                if (indexPath.row == 0) {
//                    NSLog(@"婚礼照片");
//
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                     manList.fromType =@"1";
//                    [self.navigationController pushViewController:manList animated:YES];
//
//                }
//                else if (indexPath.row == 1) {
//                    NSLog(@"婚礼视频");
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                    manList.fromType =@"2";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }
                
                //2-28 我的钱包
                if (indexPath.row == 1) {
                    
                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                }
                else if (indexPath.row == 2) {
                    
                    //供应商个人资料
                    YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
                    [self.navigationController yp_pushViewController:person animated:YES];
                    
                }
                else if (indexPath.row == 3) {
                    //                    //11-15 添加
                    //                    //领取礼品
                    //                    HRYaoQingViewController *receive = [HRYaoQingViewController new];
                    //                    [self.navigationController pushViewController:receive animated:YES];
                    
                    //2-24 添加
                    //领取礼品
                    HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                    [self.navigationController pushViewController:receive animated:YES];
                    
                }
                else if (indexPath.row == 4) {
                    //10-31 添加
                    //邀请下载
                    
                    [self goDownLoadVC];
                    
                }else if (indexPath.row == 5) {
                    //10-30 添加
                    //意见反馈
                    HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                }
                
                //MARK: 4-24 我的订单
                else if (indexPath.row == 0) {
                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                
            }
        //MARK: 车手
        }else if (CheShou(self.professionID)){//车手
            
            if (indexPath.section == 0) {
                
                if (indexPath.row == 0) {
                    
                    YPMyCarController *myCar = [[YPMyCarController alloc]init];
                    myCar.carModelID = self.userInfo.ModelID;
                    [self.navigationController yp_pushViewController:myCar animated:YES];
                    
                }else if (indexPath.row == 1) {

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
                        
                    }else{
                        
                        [EasyShowTextView showText:@"当前未审核通过,请耐心等待!"];
                        
                    }
                    
                }else if (indexPath.row == 2) {
                    
                    //我的收藏
    //                YPReMyCollectionController *collect = [[YPReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];

    //                HRMyCollectionViewController *collect = [[HRMyCollectionViewController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];

    //                //1.16 重做
    //                YPReReMyCollectionController *collect = [[YPReReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
    //
    //            }else if (indexPath.row == 3){
                    
                    NSLog(@"我的动态");
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                    
                }
                
            }else if (indexPath.section == 1) {
                
//                //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//                if (indexPath.row == 0) {
//                    NSLog(@"婚礼照片");
//
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                      manList.fromType =@"1";
//                    [self.navigationController pushViewController:manList animated:YES];
//
//                }
//                else if (indexPath.row == 1) {
//                    NSLog(@"婚礼视频");
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                    manList.fromType =@"2";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }
                
                //2-28 我的钱包
                if (indexPath.row == 1) {
                    
                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                }
                else if (indexPath.row == 2) {
                    
                    //个人资料
                    YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
                    [self.navigationController yp_pushViewController:person animated:YES];
                    
                }
                else if (indexPath.row == 3) {
                    //                    //11-15 添加
                    //                    //领取礼品
                    //                    HRYaoQingViewController *receive = [HRYaoQingViewController new];
                    //                    [self.navigationController pushViewController:receive animated:YES];
                    
                    //2-24 添加
                    //领取礼品
                    HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                    [self.navigationController pushViewController:receive animated:YES];
                }
                else if (indexPath.row == 4) {
                    //10-31 添加
                    //邀请下载
                    
                    [self goDownLoadVC];
                    
                }else if (indexPath.row == 5) {
                    
                    //10-30 添加
                    //意见反馈
                    HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                    
                }
                
                //MARK: 4-24 我的订单
                else if (indexPath.row == 0) {
                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                
            }
        //MARK: 酒店
        }else if (JiuDian(self.professionID)){//酒店
        
            if (indexPath.section ==0) {
                YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
                [self.navigationController yp_pushViewController:anli animated:YES];
            }
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    //宴会厅管理
                    YPYanHuiTingListController *yanhuiting = [[YPYanHuiTingListController alloc]init];
                    [self.navigationController yp_pushViewController:yanhuiting animated:YES];
                    
                }else if (indexPath.row == 1) {
                   
                    //我的收藏
    //       YPReMyCollectionController *collect = [[YPReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];

    //                HRMyCollectionViewController *collect = [[HRMyCollectionViewController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
                    
    //                //1.16 重做
    //                YPReReMyCollectionController *collect = [[YPReReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
    //
    //            }else if (indexPath.row == 2){
                    
                    NSLog(@"我的动态");
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                    
                }
                
            }else if (indexPath.section == 2) {

//                //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//                if (indexPath.row == 0) {
//                    NSLog(@"婚礼照片");
//
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                     manList.fromType =@"1";
//                    [self.navigationController pushViewController:manList animated:YES];
//
//                }
//                else if (indexPath.row == 1) {
//                    NSLog(@"婚礼视频");
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                    manList.fromType =@"2";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }
                
                //2-28 我的钱包
                if (indexPath.row == 1) {
                    
                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                }
                else if (indexPath.row == 2) {
                    
                    //酒店资料
                    YPHotelInfoController *hotel = [[YPHotelInfoController alloc]init];
                    [self.navigationController yp_pushViewController:hotel animated:YES];
                    
                }else if (indexPath.row == 3) {
    //                @"个人资料";
                    //供应商个人资料
                    YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
                    [self.navigationController yp_pushViewController:person animated:YES];
                    
                }
                else if (indexPath.row == 4) {
                    //                    //11-15 添加
                    //                    //领取礼品
                    //                    HRYaoQingViewController *receive = [HRYaoQingViewController new];
                    //                    [self.navigationController pushViewController:receive animated:YES];
                    
                    //2-24 添加
                    //领取礼品
                    HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                    [self.navigationController pushViewController:receive animated:YES];
                }
                else if (indexPath.row == 5) {
                    //10-31 添加
                    //邀请下载
                    
                    [self goDownLoadVC];
                    
                }else if (indexPath.row == 6) {

                    //10-30 添加
                    //意见反馈
                    HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                }
                
                //MARK: 4-24 我的订单
                else if (indexPath.row == 0) {
                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                
            }
        //MARK: 新人
        }else if (YongHu(self.professionID)){//新人-用户
            
    //        @"我的收藏";
    //        1) {
    //            @"个人资料";
    //            2) {
    //                @"邀请下载";
    //                @"意见反馈";
            
            //3-23 添加 照片 视频
            if (indexPath.row == 1) {
                NSLog(@"婚礼照片");
                
                //4-10 修改 直接进入照片详情
                YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
                xinren.corpName = @"婚礼照片";
                [self.navigationController pushViewController:xinren animated:YES];
                
            }
            else if (indexPath.row == 2) {
                NSLog(@"婚礼视频");
                
                //4-10 修改 直接进入视频详情
                HRMeViedoViewController *video = [[HRMeViedoViewController alloc]init];
                video.fromType = @"1";//1新人自己查看视频
                video.professionStr = @"1";//4-10 修改 1:新人
                [self.navigationController pushViewController:video animated:YES];
                
            }
            
            //2-28 我的钱包
            else if (indexPath.row == 3) {
                
                YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                [self.navigationController pushViewController:base animated:YES];
            }
            else if (indexPath.row == 4) {
                //我的收藏
    //            YPReMyCollectionController *collect = [[YPReMyCollectionController alloc]init];
    //            [self.navigationController yp_pushViewController:collect animated:YES];
                
    //            HRMyCollectionViewController *collect = [[HRMyCollectionViewController alloc]init];
    //            [self.navigationController yp_pushViewController:collect animated:YES];
            
    //            //1.16 重做
    //            YPReReMyCollectionController *collect = [[YPReReMyCollectionController alloc]init];
    //            [self.navigationController yp_pushViewController:collect animated:YES];
    //
    //        }else if (indexPath.row == 1){
                
                NSLog(@"我的动态");
                HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                [self.navigationController yp_pushViewController:dongtai animated:YES];
                
            }else if (indexPath.row == 5) {
                
                //个人资料
                YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
                [self.navigationController yp_pushViewController:person animated:YES];
                
            }
            else if (indexPath.row == 6) {
                //                //11-15 添加
                //                //领取礼品
                //                HRYaoQingViewController *receive = [HRYaoQingViewController new];
                //                [self.navigationController pushViewController:receive animated:YES];
                
                //2-24 添加
                //领取礼品
                HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                [self.navigationController pushViewController:receive animated:YES];
            }
            else if (indexPath.row == 7) {
//            }else if (indexPath.row == 2) {
                //10-31 添加
                //邀请下载
                
                [self goDownLoadVC];
                
            }else if (indexPath.row == 8) {
//            }else if (indexPath.row == 3) {
                
                //10-30 添加
                //意见反馈
                HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                [self.navigationController pushViewController:feedBackVC animated:YES];
            }
            
            //MARK: 4-24 我的订单
            else if (indexPath.row == 0) {
                YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                [self.navigationController pushViewController:orderVC animated:YES];
            }
            
        //MARK: 摄影/摄像
        }else if (SheYing(self.professionID) || SheXiang(self.professionID)){//摄影 / 摄像
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    NSLog(@"我的动态");
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                    
                }
                
            }else if (indexPath.section == 2) {
                
                //3-23 添加 照片 视频
                if (indexPath.row == 1) {
                    NSLog(@"婚礼照片");
                    
                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
                    manList.professionStr = @"0";
                    manList.fromType =@"1";
                    [self.navigationController pushViewController:manList animated:YES];
                    
                }
                else if (indexPath.row == 2) {
                    NSLog(@"婚礼视频");
                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
                    manList.professionStr = @"0";
                    manList.fromType =@"2";
                    [self.navigationController pushViewController:manList animated:YES];
                }
                
                //2-28 我的钱包
                else if (indexPath.row == 3) {
                    
                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                }
                else if (indexPath.row == 4) {
                    
                    //供应商个人资料
                    YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
                    [self.navigationController yp_pushViewController:person animated:YES];
                    
                }
                else if (indexPath.row == 5) {

                    //2-24 添加
                    //领取礼品
                    HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                    [self.navigationController pushViewController:receive animated:YES];
                }
                else if (indexPath.row == 6) {
                    //10-31 添加
                    //邀请下载
                    
                    [self goDownLoadVC];
                    
                }else if (indexPath.row == 7) {
                    //10-30 添加
                    //意见反馈
                    HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                }
                
                //MARK: 4-24 我的订单
                else if (indexPath.row == 0) {
                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                
            }
            
        //MARK: 其他
        }else{//其他
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    //我的收藏
    //                YPReMyCollectionController *collect = [[YPReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
                    
    //                HRMyCollectionViewController *collect = [[HRMyCollectionViewController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
                
    //                //1.16 重做
    //                YPReReMyCollectionController *collect = [[YPReReMyCollectionController alloc]init];
    //                [self.navigationController yp_pushViewController:collect animated:YES];
    //
    //            }else if (indexPath.row == 1){
                    
                    NSLog(@"我的动态");
                    HRMyFaXianViewController *dongtai = [[HRMyFaXianViewController alloc]init];
                    [self.navigationController yp_pushViewController:dongtai animated:YES];
                    
                }
                
            }else if (indexPath.section == 2) {
                
//                //3-23 添加 照片 视频 - 3-28 只有新人/摄影/摄像有
//                if (indexPath.row == 0) {
//                    NSLog(@"婚礼照片");
//
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                     manList.fromType =@"1";
//                    [self.navigationController pushViewController:manList animated:YES];
//
//                }
//                else if (indexPath.row == 1) {
//                    NSLog(@"婚礼视频");
//                    YPMePhotoManListController *manList = [[YPMePhotoManListController alloc]init];
//                    if (YongHu(self.professionID)) {//新人
//                        manList.professionStr = @"1";
//                    }else{//其他
//                        manList.professionStr = @"0";
//                    }
//                    manList.fromType =@"2";
//                    [self.navigationController pushViewController:manList animated:YES];
//                }
                
                //2-28 我的钱包
                if (indexPath.row == 1) {
                    
                    YPMyWalletBaseController *base = [[YPMyWalletBaseController alloc]init];
                    [self.navigationController pushViewController:base animated:YES];
                }
                else if (indexPath.row == 2) {
                    
                    //供应商个人资料
                    YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
                    [self.navigationController yp_pushViewController:person animated:YES];
                    
                }
                else if (indexPath.row == 3) {
//                    //11-15 添加
//                    //领取礼品
//                    HRYaoQingViewController *receive = [HRYaoQingViewController new];
//                    [self.navigationController pushViewController:receive animated:YES];
                    
                    //2-24 添加
                    //领取礼品
                    HRWeChatDuiHuanController *receive = [HRWeChatDuiHuanController new];
                    [self.navigationController pushViewController:receive animated:YES];
                }
                else if (indexPath.row == 4) {
                    //10-31 添加
                    //邀请下载
                    
                    [self goDownLoadVC];
                    
                }else if (indexPath.row == 5) {
                    //10-30 添加
                    //意见反馈
                    HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                }
                
                //MARK: 4-24 我的订单
                else if (indexPath.row == 0) {
                    YPMyEDuOrderController *orderVC = [YPMyEDuOrderController new];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                
            }
            
        }
    }

}

#pragma mark - shareSDK

-(void)showShareSDK{
    
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"婚礼桥--婚礼原来如此简单",
                                                   @"text" :@"一站式婚礼筹备, 尽在婚礼桥",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Download/Index"}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
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

/*

- (void)showShareSDK{
    
    //10-30 -- shareSDK
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"分享图标"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString *str = @"http://www.chenghunji.com/Download/Index";
//        @"https://itunes.apple.com/cn/app/%E6%88%90%E5%A9%9A%E7%BA%AA-%E5%A9%9A%E7%A4%BC%E5%8A%A9%E6%89%8B/id1289565288?mt=8";
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"一站式婚礼筹备, 尽在婚礼桥"
                                         images:imageArray
                                            url:[NSURL URLWithString:str]
                                          title:@"婚礼桥--婚礼原来如此简单"
                                           type:SSDKContentTypeAuto];
        //            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //            [shareParams SSDKSetupShareParamsByText:@""
        //                                             images:nil
        //                                                url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/婚礼桥-婚庆版/id1291642770?mt=8"]
        //                                              title:@"快来下载婚礼桥-婚庆版吧"
        //                                               type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                         
                                         @(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformSubTypeQQFriend),
                                         
                                         
                                         
                                         ]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               //                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                               //                                                                                   message:nil
                               //                                                                                  delegate:nil
                               //                                                                         cancelButtonTitle:@"确定"
                               //                                                                         otherButtonTitles:nil];
                               //                               [alertView show];
                               
                               [EasyShowTextView showSuccessText:@"分享成功"];
                               
                               break;
                           }
                           case SSDKResponseStateCancel:
                               
                           {
                               //                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                               //                                                                               message:@"取消分享"
                               //                                                                              delegate:nil
                               //                                                                     cancelButtonTitle:@"确定"
                               //                                                                     otherButtonTitles:nil, nil];
                               //                               [alert show] ;
                               
                               [EasyShowTextView showText:@"取消分享"];
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               //                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                               //                                                                               message:[NSString stringWithFormat:@"%@",error]
                               //                                                                              delegate:nil
                               //                                                                     cancelButtonTitle:@"确定"
                               //                                                                     otherButtonTitles:nil, nil];
                               //                               [alert show] ;
                               
                               [EasyShowTextView showErrorText:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}
*/
#pragma mark - target
- (void)jiesuanBtnClick{
    NSLog(@"jiesuanBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        YPBalanceRecordController *balance = [[YPBalanceRecordController alloc]init];
        [self.navigationController yp_pushViewController:balance animated:YES];
    }
    
}
-(void)goDownLoadVC {
    HRShareAppViewController *downVC = [HRShareAppViewController new];
    [self.navigationController pushViewController:downVC animated:YES];
}

- (void)anliBtnClick{
    NSLog(@"anliBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }else{
        YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
        [self.navigationController yp_pushViewController:anli animated:YES];
    }
    
}

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

- (void)headIconBtnClick{
    NSLog(@"headIconBtnClick");
    
    if (HunChe(self.professionID)) {//婚车-队长
        
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else if (CheShou(self.professionID)){//车手
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else if (JiuDian(self.professionID)){//酒店
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else if (YongHu(self.professionID)){//新人-用户
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
        
    }else{
        
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        [self.navigationController yp_pushViewController:person animated:YES];
    }
    
//    YPReMeInfoController *info = [[YPReMeInfoController alloc]init];
//    info.imageURL = self.userInfo.Headportrait;
//    info.nameStr = self.userInfo.TrueName;
//    info.id =[NSString stringWithFormat:@"%zd",UserId_New];
//    if (JiuDian(self.professionID)) {
//        info.professionStr = @"酒店";
//    }else if (HunChe(self.professionID)) {
//        info.professionStr = @"婚车";
//    }else if (ZhuChi(self.professionID)) {
//        info.professionStr = @"主持人";
//    }else if (SheXiang(self.professionID)) {
//        info.professionStr = @"摄像师";
//    }else if (SheYing(self.professionID)) {
//        info.professionStr = @"摄影师";
//    }else if (HuaZhuang(self.professionID)) {
//        info.professionStr = @"化妆师";
//    }else if (YanYi(self.professionID)) {
//        info.professionStr = @"演艺";
//    }else if (HunSha(self.professionID)) {
//        info.professionStr = @"婚纱";
//    }else if (DuDao(self.professionID)) {
//        info.professionStr = @"督导师";
//    }else if (HuaYi(self.professionID)) {
//        info.professionStr = @"花艺师";
//    }else if (DongGuang(self.professionID)) {
//        info.professionStr = @"灯光师";
//    }else if (YongHu(self.professionID)) {
//        info.professionStr = @"用户";
//    }else if (CheShou(self.professionID)) {
//        info.professionStr = @"车手";
//    }else if (HunQing(self.professionID)) {
//        info.professionStr = @"婚庆";
//    }
//    [self.navigationController pushViewController:info animated:YES];
}

- (void)headInfoBtnClick{
    NSLog(@"headInfoBtnClick");
    
    //关注粉丝点击
    HRGZFSController *gzVC = [HRGZFSController new];
    [self.navigationController pushViewController:gzVC animated:YES];
}

- (void)maskBtnClick{
    NSLog(@"maskBtnClick");
    
    if (!UserId_New) {
        
        //2-11 修改 登录判断
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
        
    }
}

#pragma mark - 网络请求
#pragma mark 用户获取自己详细信息
- (void)GetUserFacilitatorInfo{
    
    NSString *url = @"/api/HQOAApi/GetUserFacilitatorInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            self.userInfo.UserID = [object valueForKey:@"UserID"];
//            self.userInfo.PhoneNo = [object valueForKey:@"PhoneNo"];
//            self.userInfo.TrueName = [object valueForKey:@"TrueName"];
//            self.userInfo.Profession = [object valueForKey:@"Profession"];
//            self.userInfo.StatusType = [object valueForKey:@"StatusType"];
//            self.userInfo.Headportrait = [object valueForKey:@"Headportrait"];
//            self.userInfo.Age = [object valueForKey:@"Age"];
//            self.userInfo.ModelID = [object valueForKey:@"ModelID"];
//            self.userInfo.CreateTime = [object valueForKey:@"CreateTime"];
//
//            self.userInfo.IsMotorcade = [object valueForKey:@"IsMotorcade"];
//            self.userInfo.CaptainID = [object valueForKey:@"CaptainID"];
//            self.userInfo.IsNews = [object valueForKey:@"IsNews"];
//
//            self.userInfo.SupplierID = [object valueForKey:@"SupplierID"];
//
//            self.iconImgUrl = self.userInfo.Headportrait;
//            self.titleName = self.userInfo.TrueName;
//            self.professionID = self.userInfo.Profession;
            
            //保存信息
//            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Profession forKey:@"Profession"];
//            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.SupplierID forKey:@"SupplierID"];

        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
        [self.tableView reloadData];
        
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
