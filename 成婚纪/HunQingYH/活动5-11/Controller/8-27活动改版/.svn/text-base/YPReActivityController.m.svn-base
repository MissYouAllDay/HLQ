//
//  YPReActivityController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityController.h"
#import "YPReActivityHotelController.h"
#import "YPGetFacilitatorActivityIdentityList.h"

@interface YPReActivityController ()

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorActivityIdentityList *> *menuList;

@end

@implementation YPReActivityController{
    UILabel *label;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self GetFacilitatorActivityIdentityList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
 
}

- (void)setupUI{
    
    self.magicView.itemScale = 1.2;
    self.magicView.headerHeight = 0;
    self.magicView.navigationHeight = NAVIGATION_BAR_HEIGHT;
    self.magicView.againstStatusBar = YES;
    self.magicView.sliderExtension = 5.0;
    self.magicView.navigationInset = UIEdgeInsetsMake(0, ScreenWidth-80*self.menuList.count-50, 0, 0);
    self.magicView.sliderOffset = -20;
    self.magicView.sliderWidth = 60;
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.view.backgroundColor = CHJ_bgColor;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.magicView.separatorHidden = YES;
    
//    self.menuList = @[@"酒店",@"婚庆"];
    
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
    }
//    label.text = @"活动";
    label.text = @"特惠";//18-08-31 改为折扣 18-09-05 特惠
    label.textColor = BlackColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    self.magicView.leftNavigatoinItem = label;
    label.center = self.view.center;
    
    [self.magicView reloadData];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *marr = [NSMutableArray array];
    for (YPGetFacilitatorActivityIdentityList *list in self.menuList) {
        [marr addObject:list.Name];
    }
    return marr.copy;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:GrayColor forState:UIControlStateNormal];
        [menuItem setTitleColor:BlackColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    YPGetFacilitatorActivityIdentityList *list = self.menuList[pageIndex];
    
    static NSString *recomId = @"YPReActivityHotelController";
    YPReActivityHotelController *dongtai = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!dongtai) {
        dongtai = [[YPReActivityHotelController alloc] init];
    }
    dongtai.titleStr = list.Name;
    dongtai.IdentityId = list.IdentityId;
    dongtai.TopImg = list.TopImg;
    return dongtai;
    
//    if (0 == pageIndex) {
//        static NSString *recomId = @"YPReActivityHotelController";
//        YPReActivityHotelController *dongtai = [magicView dequeueReusablePageWithIdentifier:recomId];
//        if (!dongtai) {
//            dongtai = [[YPReActivityHotelController alloc] init];
//        }
//        dongtai.titleStr = list.Name;
//        dongtai.IdentityId = list.IdentityId;
//        return dongtai;
//    }else{
//        static NSString *recomId = @"YPReActivityHotelController";
//        YPReActivityHotelController *guanzhu = [magicView dequeueReusablePageWithIdentifier:recomId];
//        if (!guanzhu) {
//            guanzhu = [[YPReActivityHotelController alloc] init];
//        }
//        return guanzhu;
//    }
//    return nil;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidAppear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

#pragma mark - 网络请求
#pragma mark 获取参与服务商身份列表
- (void)GetFacilitatorActivityIdentityList{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorActivityIdentityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            _TopImg = [object objectForKey:@"TopImg"];
            
            [self.menuList removeAllObjects];
            
            self.menuList = [YPGetFacilitatorActivityIdentityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];

            [self.menuList enumerateObjectsUsingBlock:^(YPGetFacilitatorActivityIdentityList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (JiuDian(obj.IdentityId)) {
                    [self.menuList exchangeObjectAtIndex:idx withObjectAtIndex:0];
                }else if (HunQing(obj.IdentityId)){
                    [self.menuList exchangeObjectAtIndex:idx withObjectAtIndex:1];
                }else if (HunSha(obj.IdentityId)){
                    [self.menuList exchangeObjectAtIndex:idx withObjectAtIndex:2];
                }
            }];
            [self setupUI];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorActivityIdentityList *> *)menuList{
    if (!_menuList) {
        _menuList = [NSMutableArray array];
    }
    return _menuList;
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
