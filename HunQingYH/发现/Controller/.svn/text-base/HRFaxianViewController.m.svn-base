//
//  HRFaxianViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRFaxianViewController.h"
#import "WTVSegementControl.h"
#import "UIView+Frame.h"
#import "HRGuanZhuViewController.h"
#import "HRDongTaiViewController.h"
#import "HRZiXunViewController.h"
#import "HRaddDongTaiController.h"
#import "HRDTVideoViewController.h"
#import "BHBPopView.h"


#import "SJRecordNavigationController.h"

#import "SJRecordViewController.h"
#import "HRAddDTVideoViewController.h"



#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface HRFaxianViewController ()<WTVSegmentControlDelegate>

{
    UIView *_navView;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WTVSegementControl *segementControl;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/**关注*/
@property(nonatomic,strong)HRGuanZhuViewController  *guangzhuVC;
/**动态*/
@property(nonatomic,strong)HRDongTaiViewController  *dongtaiVC;

/**视频*/
@property(nonatomic,strong)HRDTVideoViewController  *videoVC;


@end

@implementation HRFaxianViewController
-(HRGuanZhuViewController *)guangzhuVC{
    if(!_guangzhuVC){
        _guangzhuVC =[HRGuanZhuViewController new];
    }
    return _guangzhuVC;
}
-(HRDongTaiViewController *)dongtaiVC{
    if(!_dongtaiVC){
        _dongtaiVC = [HRDongTaiViewController new];
        
    }
    return _dongtaiVC;
}

-(HRDTVideoViewController *)videoVC{
    if (!_videoVC) {
        _videoVC = [HRDTVideoViewController new];
    }
    return _videoVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    
    if (!_navView) {
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    _navView.backgroundColor = WhiteColor;
    self.view.backgroundColor =CHJ_bgColor;
    
   
  

}
-(void)setupUI{
    [self.view addSubview:_navView];
    UIButton * addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
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
        _scrollView.frame  = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT -TAB_BAR_HEIGHT);
    }
    return _scrollView;
}
- (WTVSegementControl *)segementControl {
    
    if (!_segementControl) {
        
        _segementControl =  [[WTVSegementControl alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth*0.7 ,NAVIGATION_BAR_HEIGHT -20)];
        _segementControl.backgroundColor = [UIColor whiteColor];
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
    self.dongtaiVC  =[[HRDongTaiViewController alloc]init];
    
    self.dongtaiVC.view.frame =CGRectMake(0 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_dongtaiVC.view];
    
    self.videoVC = [[HRDTVideoViewController alloc]init];
    self.videoVC.view.frame =CGRectMake(1 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_videoVC.view];
 

 
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---------target----------
-(void)addBtnClick{
    
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"照片" Icon:@"images.bundle/Find_piture"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"视频" Icon:@"images.bundle/Find_video"];
    
    //添加popview
    [BHBPopView showToView:self.view.window withItems:@[item0,item1]andSelectBlock:^(BHBItem *item) {
        NSLog(@"选中%@项",item.title);
        
        
        if ([item.title isEqualToString:@"照片"]) {
                HRaddDongTaiController *addVC = [HRaddDongTaiController new];
                [self.navigationController pushViewController:addVC animated:YES];
        }else{
//            SJRecordViewController *videoVC = [SJRecordViewController new];
//            SJRecordNavigationController *nav = [[SJRecordNavigationController alloc] initWithRootViewController:videoVC];
//            [self presentViewController:nav animated:YES completion:nil];
            HRAddDTVideoViewController *videoVC = [HRAddDTVideoViewController new];
            [self.navigationController pushViewController:videoVC animated:YES];
        }
    }];
    

}

@end
