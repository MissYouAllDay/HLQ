//
//  HRGZFSController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRGZFSController.h"
#import "WTVSegementControl.h"
#import "UIView+Frame.h"
#import "HRGuangZhuViewController.h"
#import "HRFenSiViewController.h"
@interface HRGZFSController ()<WTVSegmentControlDelegate>

{
    UIView *_navView;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WTVSegementControl *segementControl;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/**关注*/
@property(nonatomic,strong)HRGuangZhuViewController  *guangzhuVC;
/**粉丝*/
@property(nonatomic,strong)HRFenSiViewController  *fensiVC;

@end

@implementation HRGZFSController
-(HRGuangZhuViewController *)guangzhuVC{
    if(!_guangzhuVC){
        _guangzhuVC =[HRGuangZhuViewController new];
    }
    return _guangzhuVC;
}
-(HRFenSiViewController *)fensiVC{
    if(!_fensiVC){
        _fensiVC = [HRFenSiViewController new];
        
    }
    return _fensiVC;
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
    
    //设置导航栏左边通知
   UIButton  *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
     [_navView addSubview:self.segementControl];
    
}
-(void)setupUI{
    [self.view addSubview:_navView];
   
    [self.view addSubview:self.scrollView];
    
    self.titleArray = @[@"关注",@"粉丝"];
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
    
    self.guangzhuVC.view.frame =CGRectMake(0 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_guangzhuVC.view];
    self.fensiVC.view.frame =CGRectMake(1 * self.view.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:_fensiVC.view];
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


#pragma mark - segementControDelegate
- (void)segmentControlSelected:(NSInteger)tag {
    
    NSLog(@"选中了第%ld个gluneko",(long)tag);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
