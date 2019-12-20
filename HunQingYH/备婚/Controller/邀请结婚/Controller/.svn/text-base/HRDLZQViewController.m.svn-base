//
//  HRDLZQViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDLZQViewController.h"
#import "HMScannerController.h"
#import "HRDLZQRuleViewController.h"
#import "YPContractController.h"
#import<AssetsLibrary/AssetsLibrary.h>

#import "HRDLYQJLViewController.h"
@interface HRDLZQViewController ()
{
      UIView *_navView;
    NSInteger NowCount;
    NSInteger AllCount;
    UIButton *allBtn;
    UIButton *todyBtn;
    UIImageView *codeImageView ;
}
@end

@implementation HRDLZQViewController
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setMainUI];
    [self getPeopleNumRequest];
  
    
  
    
  
  
}
#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    
    //提交  设置导航栏右边
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:refreshBtn];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        //        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];

    self.view.backgroundColor = MainColor;
}
-(void)setMainUI{
 
    UIView *bigbgView = [[UIView alloc]init];
    bigbgView.backgroundColor =WhiteColor;
    bigbgView.clipsToBounds =YES;
    bigbgView.layer.cornerRadius =10;
    [self.view addSubview:bigbgView];
    [bigbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth-30);
        make.height.mas_equalTo(ScreenWidth);
    }];
    
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text =@"扫码办婚礼 返现10%";
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:30]];
    titleLab.textColor =WhiteColor;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bigbgView.mas_top).offset(-20);
    }];
    
    //二维码
    codeImageView = [[UIImageView alloc]init];
    [bigbgView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.center.mas_equalTo(bigbgView);
        make.width.mas_equalTo(ScreenWidth-30-70);
        make.height.mas_equalTo(ScreenWidth-30-70);
    }];
    
    NSString *cardName = [NSString stringWithFormat:@"http://www.chenghunji.com/REDBAG/SHURUXINXI?id=1&TerminalTypes=1&UserID=%@",UserId_New];
    UIImage *avatar = [UIImage imageNamed:@"分享图标"];
    
    [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
        codeImageView.image = image;
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal ];
    [saveBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bigbgView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(codeImageView);
        make.bottom.mas_equalTo(bigbgView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    UIView *smallbgView = [[UIView alloc]init];
    smallbgView.backgroundColor =WhiteColor;
    smallbgView.clipsToBounds =YES;
    smallbgView.layer.cornerRadius =10;
    [self.view addSubview:smallbgView];
    [smallbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(bigbgView.mas_bottom).offset(10);
        make.width.mas_equalTo(ScreenWidth-30);
        make.height.mas_equalTo(60);
    }];
    
    todyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [todyBtn setTitle:[NSString stringWithFormat:@"今日邀请  %zd人",NowCount] forState:UIControlStateNormal ];
    [todyBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [todyBtn addTarget:self action:@selector(yaoJLClick) forControlEvents:UIControlEventTouchUpInside];
    [smallbgView addSubview:todyBtn];
    [todyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(smallbgView);
        make.left.mas_equalTo(smallbgView.mas_left);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-30)/2, 40));
    }];
    
    allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:[NSString stringWithFormat:@"累计邀请  %zd人",AllCount] forState:UIControlStateNormal ];
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [allBtn addTarget:self action:@selector(yaoJLClick) forControlEvents:UIControlEventTouchUpInside];
    [smallbgView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(smallbgView);
        make.right.mas_equalTo(smallbgView.mas_right);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-30)/2, 40));
    }];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(smallbgView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    
    UIButton *ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ruleBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [ruleBtn setTitle:@"赚钱规则" forState:UIControlStateNormal];
    [ruleBtn addTarget:self action:@selector(ruleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruleBtn];
    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.mas_equalTo(lineView);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [connectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [connectBtn setTitle:@"联系我们" forState:UIControlStateNormal];
    [connectBtn addTarget:self action:@selector(connectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(lineView);
        make.left.mas_equalTo(lineView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)refreshBtnClick{
    NSLog(@"刷新");
    [self getPeopleNumRequest];
}
-(void)saveBtnClick{
       UIImageWriteToSavedPhotosAlbum(codeImageView.image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
    
}

//保存完成后调用的方法
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        [EasyShowTextView  showErrorText:@"保存失败"];
    }
    else {
        [EasyShowTextView showSuccessText:@"图片保存成功"];
    }
}


-(void)yaoJLClick{
    
    HRDLYQJLViewController *jlVC = [HRDLYQJLViewController new];
    jlVC.typeFlag =2;
    [self.navigationController presentViewController:jlVC animated:YES completion:nil];
}

-(void)ruleClick{
    HRDLZQRuleViewController *ruleVC = [HRDLZQRuleViewController  new];
    [self.navigationController presentViewController:ruleVC animated:YES completion:nil];
}
-(void)connectClick{
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------网络请求---------------

//获取我邀请的人数
- (void)getPeopleNumRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetNewInformationCount";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"TerminalTypes"] =@"1";//0网页分享、1扫码、2手机APP
    params[@"SubmittingID"] =UserId_New;
    params[@"ObjectTypes"] =@1;//0获取自己(我要结婚),1获取朋友(朋友结婚)
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"邀请人数%@",object);

            NowCount =[[object objectForKey:@"NowCount"]integerValue];
            AllCount =[[object objectForKey:@"AllCount"]integerValue];
            [todyBtn setTitle:[NSString stringWithFormat:@"今日邀请  %zd人",NowCount] forState:UIControlStateNormal ];
            [allBtn setTitle:[NSString stringWithFormat:@"累计邀请  %zd人",AllCount] forState:UIControlStateNormal ];
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

@end
