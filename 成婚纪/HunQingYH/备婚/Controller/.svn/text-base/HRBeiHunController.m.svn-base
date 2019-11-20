//
//  HRBeiHunController.m
//  HunQingYH
//
//  Created by Hiro on 2018/5/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRBeiHunController.h"
#import <SDCycleScrollView.h>

#import "YPGetWeddingInformationList.h"
#import "YPGetInformationArticleList.h"
#import "HRZiXunCell.h"
#import "YPBeiHunColViewCell.h"
//#import "YPBHProjectController.h"//我要出方案
#import "YPKeYuan190514PublishRingController.h"//19-05-19 免费领对戒
#import "YPNewlywedsController.h"//新婚档案
#import "YPBHShowFangAnController.h"//方案展示
#import "YPBHInviteController.h"//邀请有礼
#import "YPBHAssureController.h"//婚礼担保
#import "YPBHWelfareController.h"//签单福利
#import "YPMarriageNoticeController.h"//婚前必知
#import "YPFreeWeddingController.h"//2-7 添加 免费办婚礼
//#import "HRYQJHController.h"//邀请结婚
#import "HRFAStoreViewController.h"
#import "dynamicItem.h"
#import "delegateContainer.h"
#import "zhnBaseViewController.h"
#import "zhnToolView.h"
#import "HRAllBiJiViewController.h"
//5-23 邀请结婚
#import "YPReYQJHController.h"

//18-08-11 备婚图片从banner接口获取
#import "YPGetWebBannerUrl.h"

// toolview 的默认高度
static const CGFloat KtoolViewHeight = 40;

@interface HRBeiHunController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIDynamicAnimatorDelegate,UITableViewDelegate,zhnToolViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SDCycleScrollView *scrollView;
///标题模型数组
@property (nonatomic, strong) NSMutableArray<YPGetWeddingInformationList *> *titleMarr;
///标题数组
@property (nonatomic, strong) NSMutableArray *tagMarr;
/**封面banner图片数组*/
@property(nonatomic,strong)NSMutableArray  *bannerArr;
@property (nonatomic, strong) UICollectionView *colView;

@property (nonatomic,weak) UIView * noticeView;
@property (nonatomic,weak) UIScrollView * backScrollView;
@property (nonatomic,weak) UIView * fakeNavibar;
@property (nonatomic,assign) CGFloat contentoffSetY;
@property (nonatomic,strong) UIDynamicAnimator * animator;
@property (nonatomic,getter = isGesTurePaing) BOOL gesTurePaing;
@property (nonatomic,strong) NSMutableArray * customDelegateArray;
@property (nonatomic,weak) zhnBaseViewController * currentShowContentController;
@property (nonatomic,assign) BOOL isPushed;
@end

@implementation HRBeiHunController{
    UIView *_navView;
    UIView *topView;
    UIView *_bannerView;
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isPushed = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    
    [self GetBannerList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isPushed = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - getter
- (NSMutableArray<YPGetWeddingInformationList *> *)titleMarr{
    if (!_titleMarr) {
        _titleMarr = [NSMutableArray array];
    }
    return _titleMarr;
}

- (NSMutableArray *)tagMarr{
    if (!_tagMarr) {
        _tagMarr = [NSMutableArray array];
        
    }
    return _tagMarr;
}
-(NSMutableArray *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}
#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =WhiteColor;
   
    self.navigationController.navigationBar.translucent = NO;
  //初始化数据
   self.bannerViewHeight = ScreenWidth*0.4+113+40+KtoolViewHeight;
   
   
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"备婚";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}
-(void)setupUI{
    self.toolTitleArray = self.tagMarr;
    NSMutableArray *linshiArr = [NSMutableArray array];
    for ( int i=0; i<self.titleMarr.count; i++) {
        [linshiArr addObject:[HRAllBiJiViewController class] ];
    }
    self.contentViewControllerArray =[NSArray arrayWithArray:linshiArr];

    
    self.contentoffSetY = - self.bannerViewHeight ;
    
    // 动力学动画
    UIDynamicAnimator * animator = [[UIDynamicAnimator alloc]init];
    animator.delegate = self;
    self.animator = animator;
    
    [self initContentViewController];
    [self initBannerView];
    
    [self setupNav];
  
}


- (void)initBannerView{
    
    if (!_bannerView) {
         _bannerView = [[UIView alloc]init];
    }
    [self.view addSubview:_bannerView];
    _bannerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.frame.size.width, self.bannerViewHeight);
    self.noticeView = _bannerView;
    _bannerView.backgroundColor =[UIColor redColor];
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenWidth*0.4) delegate:self placeholderImage:[UIImage imageNamed:@"图片占位图"]];//5-22 5:2
        [_bannerView addSubview:_scrollView];
 
    }
    
    self.scrollView.imageURLStringsGroup =self.bannerArr;

    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ScreenWidth/4.0, 113);
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.4, ScreenWidth, 113) collectionViewLayout:layout];
    }
    [self.colView registerNib:[UINib nibWithNibName:@"YPBeiHunColViewCell" bundle:nil] forCellWithReuseIdentifier:@"YPBeiHunColViewCell"];
    self.colView.backgroundColor = CHJ_bgColor;
    self.colView.delegate = self;
    self.colView.dataSource = self;
    [_bannerView addSubview:self.colView];
    
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.4+113, ScreenWidth, 40)];
    topView.backgroundColor =CHJ_bgColor;
    
    UILabel *topTitleLab = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    topTitleLab.text =@"备婚笔记";
    topTitleLab.textAlignment =NSTextAlignmentCenter;
    topTitleLab.font =kFont(17);
    [topView addSubview:topTitleLab];
    [_bannerView addSubview:topView];

    
    
    zhnToolView * toolView = [zhnToolView zhnToolViewWithTitleArray:self.toolTitleArray];
    self.delegate = toolView;
    [_bannerView addSubview:toolView];
    toolView.frame = CGRectMake(0, ScreenWidth*0.4+113+40, ScreenWidth, KtoolViewHeight);
    toolView.commonfontSize = 16;
    toolView.highLightFontSize = 18;
    toolView.tintColor = MainColor;
    toolView.zhnDelegate = self;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panTheView:)];
    [_bannerView addGestureRecognizer:pan];
}

- (void)initContentViewController{
    
    UIScrollView * backScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:backScrollView];
    backScrollView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    backScrollView.contentSize = CGSizeMake(ScreenWidth * self.contentViewControllerArray.count, ScreenHeight - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    backScrollView.pagingEnabled = YES;
    backScrollView.delegate = self;
    backScrollView.bounces = NO;
    backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView = backScrollView;
    
    // 这里可以优化成按需加载(也就是显示当当前页面了在显示)
    for (int index = 0; index < self.contentViewControllerArray.count; index++) {
        
        Class contentVC = self.contentViewControllerArray[index];
        zhnBaseViewController * tempVC = [[contentVC alloc]init];
        YPGetWeddingInformationList *tag = self.titleMarr[index];
        tempVC.leiID =tag.WeddingInformationID;
        tempVC.zhn_tableViewEdinsets = UIEdgeInsetsMake(self.bannerViewHeight, 0, 0, 0);

        tempVC.view.backgroundColor =[UIColor whiteColor];
        tempVC.view.frame = CGRectMake(ScreenWidth * index, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-KtoolViewHeight-TAB_BAR_HEIGHT);
        
        [tempVC.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(tempVC)];
        [self addChildViewController:tempVC];
        [backScrollView addSubview:tempVC.view];
        // 让代理能够多对一
        delegateContainer * container = [delegateContainer containerDelegateWithFirst:self second:tempVC];
        [self.customDelegateArray addObject:container];
        tempVC.tableView.delegate = (id)container;
        
        
            self.currentShowContentController = tempVC;
        
    }
}


- (void)pushAction {
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
}


- (NSMutableArray *)customDelegateArray{
    if (_customDelegateArray == nil) {
        _customDelegateArray = [NSMutableArray array];
    }
    return _customDelegateArray;
}

- (void)panTheView:(UIPanGestureRecognizer *)pan{
    
    static CGPoint startPoint;
    static CGFloat currentOffsety;
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPoint = [pan locationInView:self.view];
        currentOffsety = self.contentoffSetY;
        [self.animator removeAllBehaviors];
    }else if(pan.state == UIGestureRecognizerStateChanged){
        
        CGPoint changePoint = [pan locationInView:self.view];
        CGFloat delta = startPoint.y - changePoint.y;
        self.currentShowContentController.tableView.contentOffset = CGPointMake(0, delta + currentOffsety);
        
    }else if(pan.state == UIGestureRecognizerStateChanged || pan.state == UIGestureRecognizerStateEnded){
        
        CGPoint changePoint = [pan locationInView:self.view];
        CGFloat delta = startPoint.y - changePoint.y;
        
        if (delta < 0) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.currentShowContentController.tableView.contentOffset = CGPointMake(0, - self.bannerViewHeight);
            } completion:nil];
            
        }else{
            CGFloat speed = [pan velocityInView:self.view].y;
            // 模拟器你用力拖动的时候speed会变成0,真机测试没问题
            //            if (speed == 0) {
            //                speed = -2500;
            //            }
            
            // 速度快于某个值才能响应事件
            if (speed < - 100) {
                // 这里算是这个库非常非常重要的一点了
                dynamicItem * item = [dynamicItem new];
                UIDynamicItemBehavior * inertialBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[item]];
                [inertialBehavior addLinearVelocity:CGPointMake(0, speed) forItem:item];
                inertialBehavior.resistance = 2.0;
                CGPoint currentPoint = self.noticeView.center;
                item.center = CGPointMake(0, currentPoint.y);
                
                inertialBehavior.action = ^(){
                    
                    if (item.center.y >= - KtoolViewHeight) {
                        self.noticeView.center = CGPointMake(currentPoint.x, item.center.y);
                    }else{
                        self.noticeView.center = CGPointMake(currentPoint.x, - KtoolViewHeight);
                    }
                    CGFloat currentY =  - item.center.y - (self.bannerViewHeight/2);
                    if (currentY > self.currentShowContentController.tableView.contentSize.height - ScreenHeight) {
                        
                    }else{
                        self.currentShowContentController.tableView.contentOffset = CGPointMake(0, -item.center.y - (self.bannerViewHeight/2));
                    }
                };
                [self.animator addBehavior:inertialBehavior];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.isPushed) {return;}
    if (context) {
        zhnBaseViewController * vc = (__bridge zhnBaseViewController *)context;
        
        CGFloat delta = self.bannerViewHeight + vc.tableView.contentOffset.y-NAVIGATION_BAR_HEIGHT;
        if (delta < self.bannerViewHeight - KtoolViewHeight - NAVIGATION_BAR_HEIGHT) {
            self.noticeView.frame = CGRectMake(0, - delta, self.view.frame.size.width, self.bannerViewHeight);
            self.contentoffSetY = vc.tableView.contentOffset.y;
            CGFloat scale = delta / (self.bannerViewHeight - KtoolViewHeight - NAVIGATION_BAR_HEIGHT);
            self.fakeNavibar.alpha = scale;
        }else{
            self.fakeNavibar.alpha = 1;
            self.noticeView.frame = CGRectMake(0, -(self.bannerViewHeight - KtoolViewHeight - NAVIGATION_BAR_HEIGHT), self.view.frame.size.width, self.bannerViewHeight);
            self.contentoffSetY = - KtoolViewHeight ;
        }
    }
}

#pragma mark - tableView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        for (zhnBaseViewController * tempVC in self.childViewControllers) {
            if (![tempVC isEqual:self.currentShowContentController]) {
                tempVC.tableView.contentOffset = CGPointMake(0, self.contentoffSetY);
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        int currentIndex = scrollView.contentOffset.x / ScreenWidth;
        if ([self.delegate respondsToSelector:@selector(zhnContainerContentScrollToIndex:)]) {
            [self.delegate zhnContainerContentScrollToIndex:currentIndex];
        }
        self.currentShowContentController = self.childViewControllers[currentIndex];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.gesTurePaing) {
        [self.animator removeAllBehaviors];
    }
}

#pragma mark - Dynamic的代理方法
// 结束
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    self.gesTurePaing = NO;
}
// 开始
- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    self.gesTurePaing = YES;
}

#pragma  mark  -  toolview的代理方法
- (void)zhnToolViewSelectedIndex:(NSInteger)index animate:(BOOL)animate{
    
    self.currentShowContentController = self.childViewControllers[index];
    
    for (zhnBaseViewController * tempVC in self.childViewControllers) {
        tempVC.tableView.contentOffset =  CGPointMake(0, self.contentoffSetY);
    }
    CGRect needShowRect = CGRectMake(index * ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [self.backScrollView scrollRectToVisible:needShowRect animated:animate];
}


#pragma  mark - 移除监听
- (void)dealloc{
    for (UIViewController * contentVC in self.childViewControllers) {
        if ([contentVC isKindOfClass:[zhnBaseViewController class]]) {
            [[(zhnBaseViewController *)contentVC tableView] removeObserver:self forKeyPath:@"contentOffset" context:(__bridge void * _Nullable)([(zhnBaseViewController *)contentVC tableView] )];
        }
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/4.0, 113);
    
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return 5;
    //    return 6;//2-5 修改 隐藏方案展示
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    YPBeiHunColViewCell *cell = [YPBeiHunColViewCell cellWithColView:collectionView AndIndexPath:indexPath];
    YPBeiHunColViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPBeiHunColViewCell" forIndexPath:indexPath];
    cell.backgroundColor = WhiteColor;
    switch (indexPath.item) {
        case 0:
            cell.iconImgV.image = [UIImage imageNamed:@"re_免费出方案"];
            cell.titleLabel.text = @"免费出方案";
            break;
        case 1:
            
            cell.iconImgV.image = [UIImage imageNamed:@"re_免费办婚礼"];
            cell.titleLabel.text = @"免费办婚礼";
            break;
            
        case 2:
            cell.iconImgV.image = [UIImage imageNamed:@"re_婚礼担保"];
            cell.titleLabel.text = @"婚礼担保";
            break;
            
            
        case 3:
            cell.iconImgV.image = [UIImage imageNamed:@"re_共享方案"];
            cell.titleLabel.text = @"共享方案";
            break;
        default:
            break;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.item) {
        case 0:{
            [self IsNewPeopleAddCustom];//判断是否添加订制
            break;
        }
        case 1:{
            
            YPFreeWeddingController *freeWedding = [[YPFreeWeddingController alloc]init];
            [self.navigationController pushViewController:freeWedding animated:YES];
            break;
        }
            
        case 2:{
            
            YPBHAssureController *assure = [[YPBHAssureController alloc]init];
            [self.navigationController pushViewController:assure animated:YES];
            
            
            break;
        }
            
            
        case 3:{
            
            //方案商城
            HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
            [self.navigationController pushViewController:faanganVC animated:YES];
            break;
        }
        default:
            break;
    }
    
}
#pragma mark - 网络请求
#pragma mark 8备婚图片
- (void)GetBannerList{
    
    NSString *url = @"/api/HQOAApi/GetBannerList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BannerType"] = @"8";//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner 8备婚图片
    NSString *area = areaID_New;
    if (area.length > 0) {
        params[@"Code"] = areaID_New;
    }else{
        params[@"Code"] = @"0";//没值传0 -- 18-08-15 窦
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.bannerArr removeAllObjects];
            
            NSMutableArray *marr = [NSMutableArray array];
            marr = [YPGetWebBannerUrl mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            for (YPGetWebBannerUrl *url in marr) {
                [self.bannerArr addObject:url.BannerURL];
            }
            
            [self initBannerView];
            
            [self GetWeddingInformationList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取标题列表
- (void)GetWeddingInformationList{

    NSString *url = @"/api/HQOAApi/GetWeddingInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"PageIndex"] = @"1";
//    params[@"PageCount"] = @"100";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.titleMarr removeAllObjects];
            [self.tagMarr removeAllObjects];
            
            self.titleMarr = [YPGetWeddingInformationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetWeddingInformationList *info in self.titleMarr) {
                [self.tagMarr addObject:info.Title];
            }
            
            [self setupUI];
         
//            YPGetWeddingInformationList *tag = self.titleMarr[0];
//            _selectTag = tag.WeddingInformationID;
//            [self GetInformationArticleListWithWeddingInformationId:_selectTag];
//
//
            
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

#pragma mark 判断新人是否添加了订制
- (void)IsNewPeopleAddCustom{

    NSString *url = @"/api/HQOAApi/IsNewPeopleAddCustom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *customID = [object valueForKey:@"NewPeopleCustomID"];//未添加返回0
            NSString *state = [object valueForKey:@"CustomState"];
            if ([customID integerValue] == 0) {
                //未添加
                //我要出方案 添加界面
                YPKeYuan190514PublishRingController *project = [[YPKeYuan190514PublishRingController alloc]init];
                [self.navigationController pushViewController:project animated:YES];
            }else{
                
                //我要出方案
                YPNewlywedsController *weds = [[YPNewlywedsController alloc]init];
                //                weds.typeNum = @"";
                weds.upState = [state integerValue];//提交状态
                [self.navigationController pushViewController:weds animated:YES];
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
@end
