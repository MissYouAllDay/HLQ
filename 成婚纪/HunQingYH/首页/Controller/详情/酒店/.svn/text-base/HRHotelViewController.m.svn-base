//
//  HRHotelViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelViewController.h"
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "UINavigationBar+Awesome.h"
#import "SDCycleScrollView.h"
#import "HRHotelJSTableViewController.h"
#import "HRHotelTingTableViewController.h"
#import "HRCarTeamController.h"
//2-6 添加 动态
//#import "YPHotelDongTaiTableViewController.h"
//5-23 修改 动态
#import "YPReReHomeSupplierDongTaiController.h"

#import "LEECoolButton.h"
#import "FL_Button.h"
#import "HRAnLiModel.h"
@interface HRHotelViewController ()<TYSlidePageScrollViewDataSource,TYSlidePageScrollViewDelegate>
{
    NSString *shoucangType;// 0 没有收藏 1已经收藏
}
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic ,strong) UIView *userHeader;

@property (nonatomic ,strong) HRHotelJSTableViewController *ctrl1;
@property (nonatomic ,strong) HRHotelTingTableViewController *ctrl2;
@property(nonatomic,strong)HRCarTeamController *ctrl3;
/////2-6 添加 动态
//@property(nonatomic,strong)YPHotelDongTaiTableViewController *ctrl4;
///5-23 修改 动态
@property (nonatomic, strong) YPReReHomeSupplierDongTaiController *ctrl4;

@property(nonatomic,strong)NSMutableArray *anLiArr;


@end

@implementation HRHotelViewController{
      UIView *navView;
    //    NSInteger _pageIndex;
    LEECoolButton *starButton;//收藏按钮
    NSInteger isShouCangRequest;//1 需要请求收藏接口 其他数字不需要
}

-(NSMutableArray *)anLiArr{
    if (!_anLiArr) {
        _anLiArr =[NSMutableArray array];
    }
    return _anLiArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =bgColor;
    
    isShouCangRequest =0;
    [self addSlidePageScrollView];
    
    [self addHeaderView];
    
    [self createNav];
    
    [self createBottomView];
    [self addTabPageMenu];
    
    [self getXQRequest];
}
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    
    if ([self.zhiyeName isEqualToString:@"酒店"]) {
        navView.backgroundColor = [UIColor clearColor];
    }else{
        navView.backgroundColor = WhiteColor;
    }
    
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40,20));
        make.left.mas_equalTo(navView);
        make.centerY.mas_equalTo(navView.mas_centerY).offset(10);
    }];
    
    
}
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth,50)];
    bottomView.backgroundColor =WhiteColor;
    
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =bgColor;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(2, 30));
        
    }];
    
    
    //    LEECoolButton *starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake(10, 10, 20, 20)];
    starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake((ScreenWidth/2-31)/2-45, 3, 20, 20)WithTitle:@"收藏" TitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f]];
    
    starButton.frame = CGRectMake(15, 10, ScreenWidth/2-31, 30);
    
    [starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:starButton];
 
    
    
    FL_Button *phoneBtn = [FL_Button fl_shareButton];
    [phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [phoneBtn setImage:[UIImage imageNamed:@"手机"] forState:UIControlStateNormal];
    [phoneBtn setTitle:@" 电话" forState:UIControlStateNormal];
    
    [phoneBtn setTitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f] forState:UIControlStateNormal];
    phoneBtn.status = FLAlignmentStatusNormal;
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.frame = CGRectMake(ScreenWidth/2+1,10, ScreenWidth/2-31, 30);
    [bottomView addSubview:phoneBtn];
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, CGRectGetHeight(self.view.frame)-50)];
    //CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    slidePageScrollView.pageTabBarIsStopOnTop = 1;
    slidePageScrollView.pageTabBarStopOnTopHeight = NAVIGATION_BAR_HEIGHT;
    slidePageScrollView.parallaxHeaderEffect = YES;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    _slidePageScrollView.headerView = self.userHeader;
}

- (void)addTabPageMenu
{
    if ([self.zhiyeName isEqualToString:@"酒店"]) {
        TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"酒店信息",@"宴会厅",@"动态"]];
        titlePageTabBar.frame = CGRectMake(0, CGRectGetMaxY(self.userHeader.frame), CGRectGetWidth(_slidePageScrollView.frame), 40);
        titlePageTabBar.backgroundColor = WhiteColor;
        titlePageTabBar.horIndicatorSpacing = 40;
        _slidePageScrollView.pageTabBar = titlePageTabBar;
    }else{
        TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"简介",@"车型",@"动态"]];
        titlePageTabBar.frame = CGRectMake(0, CGRectGetMaxY(self.userHeader.frame), CGRectGetWidth(_slidePageScrollView.frame), 40);
        titlePageTabBar.backgroundColor = WhiteColor;
        titlePageTabBar.horIndicatorSpacing = 40;
        _slidePageScrollView.pageTabBar = titlePageTabBar;
    }
    
   
}

- (void)addTableView{
    
    if (!self.ctrl1) {
        self.ctrl1 = [[HRHotelJSTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        self.ctrl1.rowhight =[self getHeighWithTitle:self.BriefinTroduction font:[UIFont systemFontOfSize:15] width:ScreenWidth-60];
        self.ctrl1.anLiArr =self.anLiArr;
        self.ctrl1.BriefinTroduction =self.BriefinTroduction;
        self.ctrl1.Adress =self.Adress;
        self.ctrl1.SupplierID =self.SupplierID;
    }
    if (!self.ctrl2) {
        self.ctrl2 = [[HRHotelTingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        self.ctrl2.RummeryID =self.RummeryID;
        self.ctrl2.SupplierID =self.SupplierID;
        self.ctrl2.zhiyeName =self.zhiyeName;
//        if ([self.fromFlag isEqualToString:@"2"]) {
//            self.ctrl2.fromFlag =@"2";
//        }else{
//            self.ctrl2.fromFlag =@"3";
//        }
    }
    if (!self.ctrl3) {
        self.ctrl3 =[[HRCarTeamController alloc]initWithStyle:UITableViewStyleGrouped];
    }
    
    if (!self.ctrl4) {
        self.ctrl4 = [[YPReReHomeSupplierDongTaiController alloc] init];
        self.ctrl4.userID = self.UserID;
    }
    
    self.ctrl1.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl2.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl3.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl4.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    //    self.ctrl2.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        _pageIndex = 1;
    //        [self getBanquetHallList];
    //    }];
    
    [self addChildViewController:self.ctrl1];
    [self addChildViewController:self.ctrl2];
    [self addChildViewController:self.ctrl4];
//    [self addChildViewController:self.ctrl3];
}

#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    if (index == 2) {
        YPReReHomeSupplierDongTaiController *dongtai = self.childViewControllers[index];
        return dongtai.collectionView;
    }else{
        UITableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }
}

#pragma mark - delegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    //    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    CGFloat headerContentViewHeight = -(CGRectGetHeight(slidePageScrollView.headerView.frame)+CGRectGetHeight(slidePageScrollView.pageTabBar.frame));
    // 获取当前偏移量
    CGFloat offsetY = pageScrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - headerContentViewHeight;
    
    CGFloat alpha = delta / (CGRectGetHeight(slidePageScrollView.headerView.frame) - NAVIGATION_BAR_HEIGHT);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBarColor colorWithAlphaComponent:alpha]];
}

- (UIView *)userHeader{
    if (!_userHeader) {
        _userHeader = [[UIView alloc]init];
        _userHeader.frame = CGRectMake(0, 0, ScreenWidth,150);
        _userHeader.backgroundColor =[UIColor whiteColor];
        
        UIImageView *iconImageView;
        if ([self.zhiyeName isEqualToString:@"酒店"]) {
            iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -NAVIGATION_BAR_HEIGHT, ScreenWidth,150+NAVIGATION_BAR_HEIGHT)];
            UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,150+NAVIGATION_BAR_HEIGHT)];
            mask.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
            [iconImageView addSubview:mask];
        }else{
            iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-40, 20, 80, 80)];
        }
        
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.Headportrait]placeholderImage:[UIImage imageNamed:@"占位图"]];
        [_userHeader addSubview:iconImageView];

        UILabel *nameLab;
        
        if ([self.zhiyeName isEqualToString:@"酒店"]) {
            nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-100, 80, 200, 25)];
            nameLab.textColor = WhiteColor;
        }else{
            nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-100, 100, 200, 25)];
            nameLab.textColor = BlackColor;
        }
        nameLab.text =self.Name;
        nameLab.textAlignment =NSTextAlignmentCenter;
        nameLab.font = [UIFont boldSystemFontOfSize:17.0];
        [_userHeader addSubview:nameLab];
        
        UIButton *zhiyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [zhiyeBtn setBackgroundColor:RGB(146, 194, 57)];
        zhiyeBtn.titleLabel.font =kFont(13);
        [zhiyeBtn setTitle:self.zhiyeName forState:UIControlStateNormal];
        zhiyeBtn.clipsToBounds =YES;
        zhiyeBtn.layer.cornerRadius =2;
        [zhiyeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_userHeader addSubview:zhiyeBtn];
        [zhiyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_userHeader);
            make.top.mas_equalTo(nameLab.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
    }
    return _userHeader;
}


- (void)starButtonAction:(LEECoolButton *)sender{
  

    if (sender.selected) {
        
        //未选中状态
        
        [sender deselect];
        
        
    } else {
        
        //选中状态
        
        [sender select];
    }
    NSLog(@"%zd",isShouCangRequest);
    if (isShouCangRequest ==1) {
         isShouCangRequest =0;
    }else{
        
        self.IsCollection =!_IsCollection;
        isShouCangRequest =0;
//        NSLog(@"%zd",self.IsCollection);
        if (self.IsCollection ==1){
             [self shouCangRequest];
           
        }else{
            [self shouCangRequest];
//            [self QXshouCangRequest];
        }
    }

}
-(void)phoneBtnClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.PhoneNo];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getXQRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetSupplierInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserID"]   = myID;
    params[@"SupplierID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];
    if (self.SupplierID ==[mySupplierID integerValue]) {
            params[@"Type"]  = @"1"; //0、用户获取供应商1、供应商获取自己
    }else{
            params[@"Type"]  = @"0"; //0、用户获取供应商1、供应商获取自己
    }

    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.BriefinTroduction =[object objectForKey:@"BriefinTroduction"];
            self.SupplierID =[[object objectForKey:@"SupplierID"]integerValue];
            self.RummeryID =[[object objectForKey:@"RummeryID"]integerValue];
            self.PhoneNo =[object objectForKey:@"PhoneNo"];
            self.anLiArr  =[HRAnLiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            self.IsCollection =[[object objectForKey:@"IsCollection"]integerValue];
            self.CollectionID =[[object objectForKey:@"CollectionID"]integerValue];
            [self addTableView];
            
            [_slidePageScrollView reloadData];
            NSLog(@"%zd",self.IsCollection);
          //处理收藏按钮
            if (self.IsCollection ==1) {
                //已经收藏 只需要改变收藏按钮样式，无需请求接口
                isShouCangRequest =1;
                shoucangType =@"1";
                [self starButtonAction:starButton];
            }else{
                shoucangType =@"0";
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
-(void)shouCangRequest{
    NSLog(@"收藏状态%zd",self.IsCollection);
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/AddAndDelCollectionInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"CollectionType"]   = @"0";//0供应商、1方案、2宴会
     if ([self.Name isEqualToString:@"酒店"]){
         params[@"TypeID"] =[NSString stringWithFormat:@"%zd",self.RummeryID];//除酒店传酒店ID、婚庆公司传婚庆ID、其他传供应商ID
     }else{
          params[@"TypeID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];//除酒店传酒店ID、婚庆公司传婚庆ID、其他传供应商ID
     }
   
    params[@"CollectorsType"]  = @"0";//0用户端、1公司端
    params[@"CollectorsID"]   = myID;
    if ([shoucangType isEqualToString:@"0"]) {
         params[@"Start"]   = @"0";//0添加、1删除
    }else{
         params[@"Start"]   = @"1";//0添加、1删除
    }

   
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
    
            NSLog(@"%@",object);
            
            if ([shoucangType isEqualToString:@"0"]) {
                shoucangType =@"1";
                [EasyShowTextView showText:@"收藏成功"];
            }else{
                shoucangType =@"0";
                [EasyShowTextView showText:@"取消收藏成功"];
            }
     
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

@end
