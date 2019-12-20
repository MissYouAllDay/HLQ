//
//  YPActivityController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPActivityController.h"
#import "YPGetWeChatActivityList.h"
#import "YPActivityListCell.h"
//#import "HRYQJHController.h"//邀请结婚
#import "YPFreeWeddingController.h"//免费办婚礼
#import "HRShareAppViewController.h"//分享APP
#import "HRBaoMIViewController.h"//爆米花
#import "YPBHAssureController.h"//婚礼担保
//#import "YPBHProjectController.h"//我要出方案
#import "YPKeYuan190514PublishRingController.h"//19-05-19 免费领对戒
#import "YPNewlywedsController.h"//新婚档案
#import "HRFAStoreViewController.h"//方案商城(共享方案)
#import "YPEDuBaseController.h"//婚礼返还
//5-23 邀请结婚
#import "YPReYQJHController.h"
//6-1
#import "YPBannerHotelActivityController.h"
//7-4 婚嫁节
#import "YPHunJiaJieController.h"

@interface YPActivityController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**福利活动数组*/
@property (nonatomic, strong) NSMutableArray<YPGetWeChatActivityList *> *fuliMarr;

@end

@implementation YPActivityController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetWeChatActivityList];
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
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
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
    
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"活动";
    titleLab.text = @"折扣";//18-08-31 改为折扣
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}
//- (void)testBtnClick{
//    YPHunJiaJieController *vc = [[YPHunJiaJieController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fuliMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetWeChatActivityList *listModel = self.fuliMarr[indexPath.row];
    
    YPActivityListCell *cell = [YPActivityListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.BigImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // Get visible cells on table view.
//    NSArray *visibleCells = [self.tableView visibleCells];
//    
//    for (YPActivityListCell *cell in visibleCells) {
//        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /**
     
     邀请好友办婚礼    —————YQBHL
     免费办婚礼       —————FreeBHL
     分享APP赚现金    —————ShareApp
     免费领爆米花     —————FreeBMH
     婚礼担保        ————HLDB
     我要出方案 ——————ChuFA
     共享方案 ———————GongxianFA
     婚礼返还———————-HunLiFH
     酒店活动  --------- JDHD
     婚嫁节  ----------  HJCGJ
     */
    YPGetWeChatActivityList *listModel = self.fuliMarr[indexPath.row];
    
    if ([listModel.ActivityCode isEqualToString:@"YQBHL"]) {//邀请好友办婚礼
        
//        HRYQJHController *yqjh = [[HRYQJHController alloc]init];
//        [self.navigationController pushViewController:yqjh animated:YES];
        
        //5-23
//        YPReYQJHController *yqjh = [[YPReYQJHController alloc]init];
//        [self.navigationController pushViewController:yqjh animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"FreeBHL"]){//免费办婚礼
        
        YPFreeWeddingController *wed = [[YPFreeWeddingController alloc]init];
        [self.navigationController pushViewController:wed animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"ShareApp"]){//分享APP赚现金
        
        //FIXME: 18-08-16 暂时本地分享
        [self showShareSDK];
        
//        HRShareAppViewController *share = [[HRShareAppViewController alloc]init];
//        [self.navigationController pushViewController:share animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"FreeBMH"]){//免费领爆米花
        
        //4-4 修改 登录判断
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            
            HRBaoMIViewController *baoMi = [[HRBaoMIViewController alloc]init];
            [self.navigationController pushViewController:baoMi animated:YES];
            
        }
        
    }else if ([listModel.ActivityCode isEqualToString:@"HLDB"]){//婚礼担保
        
        YPBHAssureController *assure = [[YPBHAssureController alloc]init];
        [self.navigationController pushViewController:assure animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"ChuFA"]){//我要出方案
        
        [self IsNewPeopleAddCustom];
        
    }else if ([listModel.ActivityCode isEqualToString:@"GongxianFA"]){//共享方案
        
        //方案商城
        HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
        [self.navigationController pushViewController:faanganVC animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"HunLiFH"]){//婚礼返还
        
        //婚礼返还
        //登录判断
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            
            YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
            [self.navigationController pushViewController:edu animated:YES];
            
        }
        
    }else if ([listModel.ActivityCode isEqualToString:@"JDHD"]){//酒店活动
        
        YPBannerHotelActivityController *hotelAct = [[YPBannerHotelActivityController alloc]init];
        [self.navigationController pushViewController:hotelAct animated:YES];
        
    }else if ([listModel.ActivityCode isEqualToString:@"HJCGJ"]){//婚嫁节 7-9
        
        YPHunJiaJieController *vc = [[YPHunJiaJieController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [EasyShowTextView showText:@"参与该活动,请更新版本!"];
    }
    
}

-(void)showShareSDK{
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"【邀好友】婚礼桥送现金福利！点开即得！",
                                                   @"text" :@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在婚礼桥！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Redbag/index"}
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

#pragma mark 获取活动列表(用户)
- (void)GetWeChatActivityList{
    
    NSString *url = @"/api/HQOAApi/GetWeChatActivityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.fuliMarr = [YPGetWeChatActivityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 判断新人是否添加了订制
- (void)IsNewPeopleAddCustom{
    
    NSString *url = @"/api/HQOAApi/IsNewPeopleAddCustom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *customID = [object valueForKey:@"NewPeopleCustomID"];//未添加返回0
            NSString *state = [object valueForKey:@"CustomState"];
            if ([customID integerValue] == 0) {
                //未添加
                //我要出方案 添加界面
                YPKeYuan190514PublishRingController *project = [[YPKeYuan190514PublishRingController alloc]init];
                [self.navigationController pushViewController:project animated:YES];
            }else{
                
                //我要出方案
                YPNewlywedsController *weds = [[YPNewlywedsController alloc]init];
                //                weds.typeNum = @"";
                weds.upState = [state integerValue];//提交状态
                [self.navigationController pushViewController:weds animated:YES];
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
- (NSMutableArray<YPGetWeChatActivityList *> *)fuliMarr{
    if (!_fuliMarr) {
        _fuliMarr = [NSMutableArray array];
    }
    return _fuliMarr;
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
