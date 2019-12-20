//
//  YPKeYuan190513ViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190513ViewController.h"
#import "YPFaBuKeYuanViewController.h"//19-04-01 发布客源
#import "YPKeYuan190513PublishViewController.h"
#import "YPKeYuan190514RecommendViewController.h"
#import "YPKeYuan190521MyPublishController.h"
#import "YPKeYuan190306AllController.h"//全部客源
#import "YPKeYuanGuanFangController.h"//官方推荐
#import "YPMyKeYuan190311BaseController.h"

@interface YPKeYuan190513ViewController ()

@property (nonatomic, strong) NSArray *menuList;
@property (nonatomic, assign) BOOL autoSwitch;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation YPKeYuan190513ViewController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self setupUI];
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
}

- (void)setupUI{
    
    self.magicView.itemScale = 1.2;
    self.magicView.headerHeight = 0;
    self.magicView.navigationHeight = NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT+10;
    self.magicView.againstStatusBar = YES;
    self.magicView.sliderExtension = 5.0;
    self.magicView.navigationInset = UIEdgeInsetsMake(0, 20, 0, 0);
    //    self.magicView.sliderOffset = 0;
    self.magicView.sliderWidth = 32;
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.view.backgroundColor = WhiteColor;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    if (YongHu(Profession_New)){
        self.menuList = @[@"发布需求",@"推荐好友"];
    }else{
        self.menuList = @[@"全部客源",@"官方推荐"];
    }
    if (!self.rightButton) {
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72, 28)];
    }
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.rightButton setBackgroundColor:CHJ_RedColor];
    self.rightButton.layer.cornerRadius = 14;
    self.rightButton.clipsToBounds = YES;
    self.rightButton.center = self.view.center;
    self.magicView.rightNavigatoinItem = self.rightButton;
    if (YongHu(Profession_New)){
        [self.rightButton setTitle:@"我的发布" forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitle:@"我的客源" forState:UIControlStateNormal];
    }
    if (self.formIndex==1) {
        UIButton *backBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        [backBtn setTitle:@"" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        self.magicView.leftNavigatoinItem =backBtn;
        [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.magicView reloadData];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.menuList;
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
    if (YongHu(Profession_New)) {
        if (0 == pageIndex) {
            static NSString *recomId = @"YPKeYuan190513PublishViewController";
            YPKeYuan190513PublishViewController *all = [magicView dequeueReusablePageWithIdentifier:recomId];
            if (!all) {
                all = [[YPKeYuan190513PublishViewController alloc] init];
            }
            return all;
        }else{
            static NSString *recomId = @"YPKeYuan190514RecommendViewController";
            YPKeYuan190514RecommendViewController *all = [magicView dequeueReusablePageWithIdentifier:recomId];
            if (!all) {
                all = [[YPKeYuan190514RecommendViewController alloc] init];
            }
            return all;
        }
    }else{
        if (0 == pageIndex) {
            static NSString *recomId = @"YPKeYuan190306AllController";
            YPKeYuan190306AllController *all = [magicView dequeueReusablePageWithIdentifier:recomId];
            if (!all) {
                all = [[YPKeYuan190306AllController alloc] init];
            }
            return all;
        }else{
            static NSString *recomId = @"YPKeYuanGuanFangController";
            YPKeYuanGuanFangController *all = [magicView dequeueReusablePageWithIdentifier:recomId];
            if (!all) {
                all = [[YPKeYuanGuanFangController alloc] init];
            }
            return all;
        }
    }
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
}

#pragma mark - target
- (void)rightButtonClick{
    //    NSLog(@"我的客源");
    if (YongHu(Profession_New)){
        YPKeYuan190521MyPublishController *fabu = [[YPKeYuan190521MyPublishController alloc]init];
        fabu.type = 1;
        [self presentViewController:fabu animated:YES completion:nil];
    }else{
        YPMyKeYuan190311BaseController *my = [[YPMyKeYuan190311BaseController alloc]init];
        [self.navigationController pushViewController:my animated:YES];
    }
    
}

#pragma mark - getter
- (NSArray *)menuList{
    if (!_menuList) {
        _menuList = [[NSArray alloc]init];
    }
    return _menuList;
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
