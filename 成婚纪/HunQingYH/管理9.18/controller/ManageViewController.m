//
//  ManageViewController.m
//  HunQingYH
//
//  Created by xl on 2019/6/15.
//  Copyright © 2019 xl. All rights reserved.
//

#import "ManageViewController.h"
#import "manageTopView.h"
#import "JXCategoryView.h"
#import "JXCategoryTitleImageView.h"
#import "danjianOrderVC.h"
#import "hotelOrderVC.h"
#import "YHTOrderVC.h"
#import "SliderMessageController.h"
#import "LCTabBarController.h"
#import "YPMe180831Controller.h"
#import "HRNavigationController.h"
#import "YPGetUserInfo.h"


@interface ManageViewController ()<JXCategoryViewDelegate>{
    UIButton *leftBtn;
}
/**<#注释#>*/
@property (nonatomic, strong) JXCategoryTitleImageView *myCategoryView;
/**单间*/
@property(nonatomic,strong)danjianOrderVC  *danjianVC;
/**酒店预订*/
@property(nonatomic,strong)hotelOrderVC  *hotelVC;
/**宴会厅预定*/
@property(nonatomic,strong)YHTOrderVC  *yhtVC;
@property (nonatomic, strong) YPGetUserInfo *userInfo;

@property (nonatomic, strong) UIView *navView;
@end

@implementation ManageViewController
- (YPGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPGetUserInfo alloc]init];
    }
    return _userInfo;
}

-(danjianOrderVC *)danjianVC{
    if (!_danjianVC) {
        _danjianVC =[danjianOrderVC new];
        _danjianVC.view.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+100, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-100-TAB_BAR_HEIGHT);
        
    }
    return _danjianVC;
}
-(hotelOrderVC *)hotelVC{
    if (!_hotelVC) {
        _hotelVC =[hotelOrderVC new];
        _hotelVC.view.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+100, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-100-TAB_BAR_HEIGHT);

    }
    return _hotelVC;
}
-(YHTOrderVC *)yhtVC{
    if (!_yhtVC) {
        _yhtVC =[YHTOrderVC new];
        _yhtVC.view.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+100, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-100-TAB_BAR_HEIGHT);

    }
    return _yhtVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=WhiteColor;
    if (!self.isSubViews) {
        [self initNavView];
    }
    [self initTopView];
    [self.view addSubview:self.yhtVC.view];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginClick)
                                                 name:@"loginNoti" object:nil];
  
    

}
-(void)loginClick{
    YPReLoginController *first = [[YPReLoginController alloc]init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
    [self presentViewController:firstNav animated:YES completion:nil];
    
}
-(void)initNavView{
   
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(navView.mas_left).offset(18);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    leftBtn.clipsToBounds =YES;
    leftBtn.layer.cornerRadius =12;
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"管理";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(navView.mas_right).offset(-18);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(19, 14));
    }];
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    // 第一个参数为是否开启边缘手势，开启则默认从边缘50距离内有效，第二个block为手势过程中我们希望做的操作
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        [weakSelf leftBtnClick];
        
    }];

   
}
-(void)initTopView{
    manageTopView *topview =[manageTopView initViewWithXib];
    topview.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, 99);
    [topview.yanhuitingbtn addTarget:self action:@selector(yanhuitingClick) forControlEvents:UIControlEventTouchUpInside];
    [topview.danjianbtn addTarget:self action:@selector(danjianClick) forControlEvents:UIControlEventTouchUpInside];
    [topview.jiudianBtn addTarget:self action:@selector(jiudianClick) forControlEvents:UIControlEventTouchUpInside];
    
    topview.layer.shadowColor = GrayColor.CGColor;
    topview.layer.shadowOffset = CGSizeMake(0,0);
    topview.layer.shadowOpacity = 0.5;
    topview.layer.shadowRadius = 5;
    // 单边阴影 顶边
    float shadowPathWidth = topview.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 100-shadowPathWidth/2.0, topview.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    topview.layer.shadowPath = path.CGPath;
    [self.view addSubview:topview];
    
}
//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
}
#pragma mark***********************target**********************
-(void)leftBtnClick{
    SliderMeViewController *mevc =[SliderMeViewController new];
    [self cw_showDefaultDrawerViewController:mevc];
}
-(void)rightBtnClick{
    SliderMessageController *messageVC = [SliderMessageController new];
    [self.navigationController pushViewController:messageVC animated:YES];


//    NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray: self.tabBarController.viewControllers];
//    [vcs removeLastObject];
//
//    YPMe180831Controller *f1 =[[YPMe180831Controller alloc]init];
//    f1.tabBarItem.title =@"我的";
//    f1.tabBarItem.image = [[UIImage imageNamed:@"tabbar_wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    f1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_wode_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    HRNavigationController *navC = [[HRNavigationController alloc] initWithRootViewController:f1];
//    [vcs addObject:navC];
//
//    self.tabBarController.viewControllers =vcs;
 
}

-(void)yanhuitingClick{
    NSLog(@"宴会厅");
    [self.danjianVC.view removeFromSuperview];
    [self.hotelVC.view removeFromSuperview];
    [self.view addSubview:self.yhtVC.view];
    
}
-(void)danjianClick{
    NSLog(@"单间");
    [self.yhtVC.view removeFromSuperview];
    [self.hotelVC.view removeFromSuperview];
    [self.view addSubview:self.danjianVC.view];
}
-(void)jiudianClick{
    NSLog(@"酒店");
    [self.danjianVC.view removeFromSuperview];
    [self.yhtVC.view removeFromSuperview];
    [self.view addSubview:self.hotelVC.view];
}
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
            

            [leftBtn setImage:[self getImageFromURL:self.userInfo.Headportrait] forState:UIControlStateNormal];
            
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
            
            if (JiuDian(self.userInfo.Profession)) {
              
            }else{
                //酒店切换页面
                
                NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray: self.tabBarController.viewControllers];
                [vcs removeLastObject];
                
                YPMe180831Controller *f1 =[[YPMe180831Controller alloc]init];
                f1.tabBarItem.title =@"我的";
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
-(UIImage *) getImageFromURL:(NSString *)fileURL

{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
     return result;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (!UserId_New) {
        [self.navigationController.tabBarController setSelectedIndex:0];

    }else{
        [self GetUserFacilitatorInfo];
    }
//    else{
//        NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray: self.tabBarController.viewControllers];
//        [vcs removeLastObject];
//
//        YPMe180831Controller *f1 =[[YPMe180831Controller alloc]init];
//        f1.tabBarItem.title =@"我的";
//        f1.tabBarItem.image = [[UIImage imageNamed:@"tabbar_wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        f1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_wode_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        HRNavigationController *navC = [[HRNavigationController alloc] initWithRootViewController:f1];
//        [vcs addObject:navC];
//
//        self.tabBarController.viewControllers =vcs;
//
//    }

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
