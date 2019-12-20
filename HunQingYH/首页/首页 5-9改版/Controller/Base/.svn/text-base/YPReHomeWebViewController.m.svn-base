//
//  YPReHomeWebViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeWebViewController.h"
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "ShareSDKMethod.h"
@interface YPReHomeWebViewController ()
{
    UIView *_navView;
}
@end

@implementation YPReHomeWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
       self.view.backgroundColor = WhiteColor;
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self setupNav];
    self.webView.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT);
}
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
    
        UILabel *titleLab  = [[UILabel alloc]init];
        titleLab.text = @"";
        titleLab.textColor = WhiteColor;
        titleLab.font = [UIFont boldSystemFontOfSize:20];
        [_navView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(backBtn.mas_centerY);
            make.centerX.mas_equalTo(_navView.mas_centerX);
        }];
    
   

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
    //5-28 修改 -------------------------
    
//    if ([self.fromType isEqualToString:@"0"]) {
//        //我的动态
//        if (!moreBtn) {
//            moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        }
//        [moreBtn setTitle:@"" forState:UIControlStateNormal];
//        [moreBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
//        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [_navView addSubview: moreBtn];
//
//        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.size.mas_equalTo(CGSizeMake(30, 40));
//            make.right.mas_equalTo(_navView).mas_offset(-15);
//            make.bottom.mas_equalTo(_navView.mas_bottom);
//        }];
//
//    }else{
//        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//        [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [_navView addSubview: shareBtn];
//        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            //            make.size.mas_equalTo(CGSizeMake(20, 40));
//            make.right.mas_equalTo(_navView).mas_offset(-15);
//            //            make.bottom.mas_equalTo(_navView.mas_bottom).offset(-5);
//            make.centerY.mas_equalTo(backBtn);
//        }];
//    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareBtnClick{
    [self showShareSDKWithUrl:self.url withtitle:@"“吼吼，我是一条神秘小消息~”火速去看》"withdes:@"备婚就用“成婚纪”帮你一站式搞定婚礼。更有首单立得¥2580新人礼"];
}
#pragma mark - shareSDK
- (void)showShareSDKWithUrl:(NSURL*)url withtitle:(NSString *)title withdes:(NSString*)des{
    
    
 
    [ShareSDKMethod ShareTextActionWithTitle:title ShareContent:des ShareUlr:[url absoluteString]shareImage:[UIImage imageNamed:@"分享图标"] IsCollect:NO IsReport:NO IsCollected:NO Report:nil Collect:nil Result:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        //分享之后的回调 在这里可以收集分享数据
        if (platformType ==22) {
            NSLog(@"微信好友");
            
            if (state ==SSDKResponseStateSuccess) {
                NSLog(@"微信好友成功");
                [EasyShowTextView showSuccessText:@"分享成功"];
                
            }else{
                NSLog(@"微信好友失败");
                [EasyShowTextView showErrorText:@"分享失败"];
                
            }
        }else if (platformType ==23){
            NSLog(@"朋友圈");
            if (state ==SSDKResponseStateSuccess) {
                [EasyShowTextView showSuccessText:@"分享成功"];
                
            }else{
                NSLog(@"朋友圈");
                [EasyShowTextView showErrorText:@"分享失败"];
            }
        }
        
        
        
        
    } withDes1:@"" withDes2:@""];
    
    
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
