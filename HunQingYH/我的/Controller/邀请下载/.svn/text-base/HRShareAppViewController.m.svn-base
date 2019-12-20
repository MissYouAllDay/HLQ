//
//  HRYQDownLoadViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/1.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRShareAppViewController.h"

#import "WJAdsView.h"//广告弹出
@interface HRShareAppViewController ()<WJAdsViewDelegate>{
    UIView *_navView;
    CGFloat haoyouNum;
    CGFloat quanNum;
    CGFloat xianshiNum;
    NSInteger URLShareCount;
    NSString *fenxiangType; //2好友，1朋友圈
}

@end

@implementation HRShareAppViewController
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //暂时
  
    [self setupNav];
    
    
    [self huoqujineRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"分享APP";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}
-(void)createUI{
    UIImageView *bgImagView = [[UIImageView alloc]init];
    bgImagView.image =[UIImage imageNamed:@"分享APP"];
    [self.view addSubview:bgImagView];
    [bgImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom);
        make.height.mas_equalTo(ScreenHeight -NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    if (iPhoneX) {
        UIButton *sharBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharBtn setImage:[UIImage imageNamed:@"分享APP_button"] forState:UIControlStateNormal];
       [ sharBtn addTarget:self action:@selector(showShareSDK) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sharBtn];
        [sharBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top).offset(ScreenWidth*1.4);
            make.size.mas_equalTo(CGSizeMake(250, 80));
            
        }];
        
        UILabel *des1Lab = [[UILabel alloc]init];
        des1Lab.textColor =TextNormalColor;
        des1Lab.text =[NSString stringWithFormat:@"分享给微信好友可获得%.1lf元现金奖励",haoyouNum];
        des1Lab.font =kFont(12);
        [self.view addSubview:des1Lab];
        [des1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(sharBtn.mas_bottom).offset(80);
            
        }];
        UILabel *des2Lab = [[UILabel alloc]init];
        des2Lab.textColor =TextNormalColor;
        des2Lab.text =[NSString stringWithFormat:@"分享到朋友圈可获得%.1lf元现金奖励",quanNum];
        des2Lab.font =kFont(12);
        [self.view addSubview:des2Lab];
        [des2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(des1Lab.mas_bottom).offset(15);
            
        }];
        UILabel *des3Lab = [[UILabel alloc]init];
        des3Lab.textColor =TextNormalColor;
        des3Lab.text =@"每天分享的前两次有现金奖励";
        des3Lab.font =kFont(12);
        [self.view addSubview:des3Lab];
        [des3Lab mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(des2Lab.mas_bottom).offset(15);
            
        }];
    }else{
        UIButton *sharBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharBtn setImage:[UIImage imageNamed:@"分享APP_button"] forState:UIControlStateNormal];
        [ sharBtn addTarget:self action:@selector(showShareSDK) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sharBtn];
        [sharBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top).offset(ScreenWidth*1.1);
            make.size.mas_equalTo(CGSizeMake(250, 80));
            
        }];
        UILabel *des1Lab = [[UILabel alloc]init];
        des1Lab.textColor =TextNormalColor;
        des1Lab.text =[NSString stringWithFormat:@"分享给微信好友可获得%.1lf元现金奖励",haoyouNum];
        des1Lab.font =kFont(12);
        [self.view addSubview:des1Lab];
        [des1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(sharBtn.mas_bottom).offset(80);
            
        }];
        UILabel *des2Lab = [[UILabel alloc]init];
        des2Lab.textColor =TextNormalColor;
        des2Lab.text =[NSString stringWithFormat:@"分享到朋友圈可获得%.1lf元现金奖励",quanNum];
        des2Lab.font =kFont(12);
        [self.view addSubview:des2Lab];
        [des2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(des1Lab.mas_bottom).offset(15);
            
        }];
        UILabel *des3Lab = [[UILabel alloc]init];
        des3Lab.textColor =TextNormalColor;
        des3Lab.text =@"每天分享的前两次有现金奖励";
        des3Lab.font =kFont(12);
        [self.view addSubview:des3Lab];
        [des3Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(60);
            make.centerY.mas_equalTo(des2Lab.mas_bottom).offset(15);
            
        }];
    }
    
 
}

-(void)addADView{
    //    [_infoCard show];
    
    
    WJAdsView *adsView = [[WJAdsView alloc] initWithView:self.view];
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i ++) {

        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame =adsView.mainContainView.frame;
        ima.image = [UIImage imageNamed:@"下载红包"];
        [array addObject:ima];
    }
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.text =[NSString stringWithFormat:@"%.1lf",xianshiNum];
    lab2.textColor =RGB(251, 207, 12);
    [lab2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:100]];
    [adsView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(adsView);
        make.centerY.mas_equalTo(adsView.mas_centerY).offset(40);
    }];
    
    
    UILabel *lab3 = [[UILabel alloc]init];
    lab3.text =@"元";
    lab3.textColor =RGB(251, 207, 12);
    lab3.font =kFont(30);
    [adsView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lab2.mas_bottom).offset(-20);
        make.left.mas_equalTo(lab2.mas_right).offset(10);
    }];
    [self.view addSubview:adsView];
    adsView.containerSubviews = array;
    [adsView showAnimated:YES];
    
    
}

#pragma mark -------红包代理 ----------
- (void)hide{
    WJAdsView *adsView = (WJAdsView *)[self.view viewWithTag:10];
    [adsView hideAnimated:YES];
}
- (void)wjAdsViewDidAppear:(WJAdsView *)view{
    NSLog(@"视图出现");
    
    
}
- (void)wjAdsViewDidDisAppear:(WJAdsView *)view{
    NSLog(@"视图消失----%zd",view.tag);
    
}

- (void)wjAdsViewTapMainContainView:(WJAdsView *)view currentSelectIndex:(long)selectIndex{
    NSLog(@"点击主内容视图:--%ld",selectIndex);
    
    if (!UserId_New) {
        YPReLoginController *loginVC = [YPReLoginController new];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }else{
        
        if (view.tag ==10) {
            [self hide];
            [self showShareSDK];
        }else{
            WJAdsView *adsView = (WJAdsView *)[self.view viewWithTag:20];
            [adsView hideAnimated:YES];
            [self showShareSDK];
        }
     
        
        
    }
    
    
    
    
    //    [self showShareSDK];
}
-(void)showyongwanView{
    [self hide];
    
    WJAdsView *adsView = [[WJAdsView alloc] initWithView:self.view];
    adsView.tag = 20;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i ++) {
        
        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame =adsView.mainContainView.frame;
        ima.image = [UIImage imageNamed:@"下载用完"];
        [array addObject:ima];
    }
  
    [self.view addSubview:adsView];
    adsView.containerSubviews = array;
    [adsView showAnimated:YES];
    
}

#pragma mark -------target--------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - shareSDK

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
                                                          fenxiangType =@"1";
                                                          [self lqWechathongbaoRequest];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                          [EasyShowTextView showSuccessText:@"分享成功"];
                                                          fenxiangType =@"2";
                                                          [self lqWechathongbaoRequest];
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


-(void)huoqujineRequest{
    //获取微信分享活动金额
    NSString *url = @"/api/HQOAApi/GetWeChatActivityMoney";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            haoyouNum =[[object objectForKey:@"FriendMoney"]floatValue];
            quanNum =[[object objectForKey:@"CircleMoney"]floatValue];
            
            [self createUI];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

-(void)lqWechathongbaoRequest{
    //获取微信分享活动金额
    NSString *url = @"/api/HQOAApi/WeChatShareGrant";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *shareURL =@"index";
    params[@"UserId"]   = UserId_New;
    params[@"ShareURL"] =shareURL;
    params[@"ShareContent"] =@"1";
    params[@"ShareTarget"] =fenxiangType;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            URLShareCount =[[object objectForKey:@"URLShareCount"]floatValue];
            xianshiNum =[[object objectForKey:@"Money"]floatValue];
            if (URLShareCount>2) {
                 [self showyongwanView];
               
            }else{
                [self addADView];
            }
            
    
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
@end
