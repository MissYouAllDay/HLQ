//
//  YPGoToHomePageWebController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPGoToHomePageWebController.h"
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>


@interface YPGoToHomePageWebController (){
    UIView *_navView;
    UIButton *closeBtn;
}

/**申请状态
 （0未申请,1审核中,2审核通过）*/
@property (nonatomic, copy) NSString *Status;

@end

@implementation YPGoToHomePageWebController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self AuditStatus];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    closeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeNative) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(backBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(backBtn);
    }];
    closeBtn.hidden =YES;
    //    UILabel *titleLab  = [[UILabel alloc]init];
    //    titleLab.text = @"共享方案";
    //    titleLab.textColor = BlackColor;
    //    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    //    [_navView addSubview:titleLab];
    //    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_equalTo(backBtn);
    //        make.centerX.mas_equalTo(_navView.mas_centerX);
    //    }];
    //
    //
    //
    if (_isShareBtn) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview: shareBtn];
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //            make.size.mas_equalTo(CGSizeMake(20, 40));
            make.right.mas_equalTo(_navView).mas_offset(-15);
            //            make.bottom.mas_equalTo(_navView.mas_bottom).offset(-5);
            make.centerY.mas_equalTo(backBtn);
        }];
    }
    
    
}
-(void)getTongZhi{
    
    if ([self.webViewManager.webView canGoBack]) {
        closeBtn.hidden =NO;
    }else{
        closeBtn.hidden =YES;
    }
}
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backVC{
    
    
    
    
    if ([self.webViewManager.webView canGoBack]) {//判断当前的H5页面是否可以返回
        //如果可以返回，则返回到上一个H5页面，并在左上角添加一个关闭按钮
        [self.webViewManager.webView goBack];
        
    } else {
        //如果不可以返回，则直接:
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareBtnClick{
    if ([self.shareTitle isEqualToString:@""]||!self.shareTitle) {
        //以标题为判断依据，标题为空都为默认
        [self showShareSDKWithUrl:self.shareURL withtitle:@"“吼吼，我是一条神秘小消息~”火速去看》"withdes:@"备婚就用“婚礼桥”帮你一站式搞定婚礼。更有首单立得¥2580新人礼"withIcon:@"http://121.42.156.151:96/2/1/100089/2/0/4f8967b9-800c-446d-b58f-c64f52e59bb5.png"];
    }else{
        [self showShareSDKWithUrl:self.shareURL withtitle:self.shareTitle withdes:self.shareDesText withIcon:self.shareIcon];
    }
    
}
#pragma mark - shareSDK
- (void)showShareSDKWithUrl:(NSString*)url withtitle:(NSString *)title withdes:(NSString*)des withIcon:(NSString *)icon{

    
    [HRShareView showShareViewWithPublishContent:@{@"title":title,
                                                   @"text" :des,
                                                   @"image":icon,
                                                   @"url"  :url}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 网络请求
#pragma mark 查询当前供应商申请状态
- (void)AuditStatus{
    
    NSString *url = @"/api/HQOAApi/AuditStatus";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"RelevantId"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.Status = [object valueForKey:@"Status"];
            self.webUrl = [object valueForKey:@"Website"];
            self.shareURL = [object valueForKey:@"ShareUrl"];
            self.shareTitle = [object valueForKey:@"ShareTitle"];
            self.shareDesText = [object valueForKey:@"ShareDescribe"];
            self.shareIcon = [object valueForKey:@"ShareImg"];
            
            if ([self.Status integerValue] == 2) {//（0未申请,1审核中,2审核通过）
                self.isShareBtn = YES;
            }else{
                self.isShareBtn = NO;
            }
            
            [self setupNav];
            [self initWebViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)withUrl:self.webUrl];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTongZhi) name:@"loadFinished" object:nil];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
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
