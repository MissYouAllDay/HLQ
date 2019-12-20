//
//  YPFreeWeddingController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPFreeWeddingController.h"
#import "YPFreeWeddingMainTopCell.h"
#import "YPActivityRulesCell.h"
#import "YPFreeWeddingMyInfoController.h"//填写我的资料
#import <ShareSDK/ShareSDK.h>
@interface YPFreeWeddingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPFreeWeddingController{
    UIView *_navView;
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
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"方案展示";
//    titleLab.textColor = BlackColor;
//    titleLab.font = [UIFont boldSystemFontOfSize:20];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YPFreeWeddingMainTopCell *cell = [YPFreeWeddingMainTopCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tagLabel.hidden = YES;
        [cell.applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.fenxiangBtn.clipsToBounds =YES;
        cell.fenxiangBtn.layer.cornerRadius =3;
        cell.fenxiangBtn.layer.borderWidth =1;
        cell.fenxiangBtn.layer.borderColor =MainColor.CGColor;
        [cell.fenxiangBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        YPActivityRulesCell *cell = [YPActivityRulesCell cellWithTableView:tableView];
        cell.codeImgV.hidden = YES;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        HRWebViewController *webVC = [HRWebViewController new];
      
        webVC.webUrl =@"http://www.chenghunji.com/Download/Rules/MyFreeWedding.html";
        webVC.isShareBtn =NO;
    
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applyBtnClick{
    NSLog(@"申请");
    
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
    
        YPFreeWeddingMyInfoController *myInfo = [[YPFreeWeddingMyInfoController alloc]init];
        [self.navigationController pushViewController:myInfo animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fenxiangClick{
   
 
    [HRShareView showShareViewWithPublishContent:@{@"title":@"【0元办婚礼】赶紧领取您的专属免单特权！",
                                                   @"text" :@"省钱小能手已上线！来婚礼桥办婚礼真“免”单，点开立享10%奖励金，就是这么任！性!",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Redbag/yqoqingjiehun"}
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


@end
