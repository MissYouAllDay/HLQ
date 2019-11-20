//
//  HRMyFaXianViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/20.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRMyFaXianViewController.h"
#import "WTVSegementControl.h"
#import "UIView+Frame.h"
//#import "HRMyFXVideoViewController.h"
//#import "YPMyDongTaiController.h"
#import "HRMyDongtaiController.h"
#import "YPReMyDongTaiVideoController.h"//5-29 视频

@interface HRMyFaXianViewController ()<WTVSegmentControlDelegate>
{
    UIView *_navView;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WTVSegementControl *segementControl;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/**我的动态*/
@property(nonatomic,strong)HRMyDongtaiController  *dTvc;
///**视频*/
//@property(nonatomic,strong)HRMyFXVideoViewController  *videoVC;
@property (nonatomic, strong) YPReMyDongTaiVideoController  *videoVC;

@end

@implementation HRMyFaXianViewController

-(HRMyDongtaiController *)dTvc{
    if (!_dTvc) {
        _dTvc = [HRMyDongtaiController new];
    }
    return _dTvc;
}
//-(HRMyFXVideoViewController *)videoVC{
//    if (!_videoVC) {
//        _videoVC = [HRMyFXVideoViewController new];
//    }
//    return _videoVC;
//}

- (YPReMyDongTaiVideoController *)videoVC{
    if (!_videoVC) {
        _videoVC = [[YPReMyDongTaiVideoController alloc]init];
    }
    return _videoVC;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self setupNav];
    [self setupUI];
   
}
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
 
    
 
}
-(void)setupUI{
 
    [_navView addSubview:self.segementControl];
    [self.view addSubview:self.scrollView];
    
    //    self.titleArray = @[@"动态",@"关注",@"资讯"];
    self.titleArray = @[@"动态",@"视频"];
}
#pragma mark - lazyLoad
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.frame  = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT );
    }
    return _scrollView;
}
- (WTVSegementControl *)segementControl {
    
    if (!_segementControl) {
        
        _segementControl =  [[WTVSegementControl alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 20, 100 ,NAVIGATION_BAR_HEIGHT -20)];
        _segementControl.backgroundColor = [UIColor blueColor];
        _segementControl.lineImage = [UIImage imageNamed:@"video_line_xuanzhong"];
        _segementControl.selectedColor = MainColor;
        _segementControl.normalColor = [UIColor blackColor];
        _segementControl.fontSize = 18;
        _segementControl.backgroundColor = [UIColor clearColor];
        _segementControl.gradientBottomMargin = 5;
        _segementControl.selectedFont = [UIFont boldSystemFontOfSize:18];
        _segementControl.eHDelegate = self;
        
        
        
    }
    return _segementControl;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    
    _titleArray = titleArray;
    
    self.segementControl.titleArray = titleArray;
    self.segementControl.scrollView = self.scrollView;
    self.scrollView.contentSize = CGSizeMake(titleArray.count * self.view.width, 0);
    self.dTvc  =[[HRMyDongtaiController alloc]init];
    
    self.dTvc.view.frame =CGRectMake(0 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_dTvc.view];
    
    self.videoVC.view.frame =CGRectMake(1 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_videoVC.view];
    
    //    self.guangzhuVC.view.frame =CGRectMake(1 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    //    [self.scrollView addSubview:_guangzhuVC.view];
   
    //这里也可以添加子控制器，然后再addSubview
    //    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //        UIView *view =[[UIView alloc]init];
    //        view.frame = CGRectMake(idx * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    //        view.backgroundColor = kRandomColor;
    //
    //        [self.scrollView addSubview:view];
    //    }];
    
    //默认选中位置
    if (_titleArray.count) {
        self.segementControl.index = 0;
    }
    
}

//// 添加子子控制器
//-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
//    UIViewController *superVC = [self findViewController:self];
//    childVC.title = vcTitle;
//    [superVC addChildViewController:childVC];
//}
//// 视图控制器
//- (UIViewController *)findViewController:(UIView *)sourceView
//{
//    id target=sourceView;
//    while (target) {
//        target = ((UIResponder *)target).nextResponder;
//        if ([target isKindOfClass:[UIViewController class]]) {
//            break;
//        }
//    }
//    return target;
//}
//// 添加子控制器视图
//- (void)addChildView:(NSInteger)index{
//    UIViewController *superVC = [self findViewController:self];
//    UIViewController *vc = superVC.childViewControllers[index];
//    CGRect frame = self.contentScrollView.bounds;
//    frame.origin.x = self.superview.frame.size.width * index;
//    vc.view.frame = frame;
//    [self.contentScrollView addSubview:vc.view];
//}

#pragma mark - segementControDelegate
- (void)segmentControlSelected:(NSInteger)tag {
    
    NSLog(@"选中了第%ld个gluneko",(long)tag);
}


-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
