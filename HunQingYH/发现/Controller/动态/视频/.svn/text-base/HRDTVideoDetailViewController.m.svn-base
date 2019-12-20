//
//  HRDTVideoDetailViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTVideoDetailViewController.h"
#import "HRDTDetailTopCell.h"
#import "HRDTTextOnlyCell.h"
#import "JPImageShowBackView.h"
#import "HRDTPingLunCell.h"
#import "XMActionSheet.h"
#import "HRTextView.h"
#import "HRLickPeopleCell.h"
#import "HRLikePeopleListController.h"
#import "HRPingLunModel.h"
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WMPlayer.h"
//#import "UIViewController+GestureStateBlock.h"
#import "detalVideoCell.h"
//5-24 替换 个人信息
#import "YPHomeInfoPageController.h"
//5-31 修改 酒店/婚车个人信息
#import "HRHotelViewController.h"
//5-31 修改 其他 个人信息
#import "YPSupplierOtherInfoController.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页
#import "YYKit.h"
#import <YYCache.h>
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 150

@interface HRDTVideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WMPlayerDelegate>
{
    UIView *_navView;
    UITableView *thisTableView;
    JPImageShowBackView      *_imageShowBackView;
    UIButton *likeBtn;
      UIButton *likeNumBtn;
    //视频
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    
    UIButton *backBtn;
    UIImageView *iconImgV;
    UILabel *titleLab;
    UIButton *moreBtn;
    UIButton *guanzhu;
    /**5-28 关注状态
     0未关注，1已关注*/
    NSInteger FollowState;
}
/**发起人类型*/
@property(nonatomic,assign)NSInteger  ObjectTypes;
/**发起人ID -- 用户ID*/
@property(nonatomic,copy)NSString  *ObjectId;
/**发起人头像*/
@property(nonatomic,copy)NSString  *DynamicerHeadportrait;
/**发起人名字*/
@property(nonatomic,copy)NSString  *DynamicerName;
/**标题*/
@property(nonatomic,copy)NSString  *Title;
/**内容*/
@property(nonatomic,copy)NSString  *Content;
/**图片或视频地址*/
@property(nonatomic,copy)NSString  *FileUrl;
/**文件类型 1图片 2视频*/
@property(nonatomic,copy)NSString  *FileType;
/**浏览量*/
@property(nonatomic,assign)NSInteger  BrowseCount;
/**点击量*/
@property(nonatomic,assign)NSInteger  GivethumbCount;
/**点赞状态*/
@property(nonatomic,assign)NSInteger  State;
/**分享量*/
@property(nonatomic,assign)NSInteger  ShareCount;
/**评论量*/
@property(nonatomic,assign)NSInteger  CommentsCount;
/**评论时间*/
@property(nonatomic,copy)NSString  *CreateTime;
/**评论数组*/
@property(nonatomic,strong)NSMutableArray  *pinglunArr;
/**总点赞数*/
@property(nonatomic,assign)NSInteger  TotalCount;
/**点赞数组*/
@property(nonatomic,strong)NSMutableArray  *zanArray;
/**5-31 添加
 供应商ID */
@property (nonatomic, copy) NSString *FacilitatorId;

@property (nonatomic,strong)HRTextView *hrTextView;
/**输入的评论内容*/
@property(nonatomic,copy)NSString  *inputStr;
/**身份编码*/
@property(nonatomic,copy)NSString  *OccupationCode;
/**封面图*/
@property(nonatomic,copy)NSString  *CoverImg;
@property(nonatomic,retain)detalVideoCell *currentCell;
@end

@implementation HRDTVideoDetailViewController
//视频
- (instancetype)init{
    self = [super init];
    if (self) {
        isSmallScreen = NO;
    }
    return self;
}
-(BOOL)prefersStatusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    [self.navigationController.navigationBar setHidden:YES];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


///把播放器wmPlayer对象放到cell上，同时更新约束
-(void)toCell{
    detalVideoCell *currentCell = (detalVideoCell *)[thisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
//    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.7f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.backgroundIV.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [currentCell.backgroundIV addSubview:wmPlayer];
        [currentCell.backgroundIV bringSubviewToFront:wmPlayer];
        [wmPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wmPlayer).with.offset(0);
            make.width.mas_equalTo(wmPlayer.frame.size.width);
            make.height.mas_equalTo(wmPlayer.frame.size.height);
        }];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            wmPlayer.effectView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-155/2, [UIScreen mainScreen].bounds.size.height/2-155/2, 155, 155);
        }else{
        }
        
        [wmPlayer.FF_View  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(wmPlayer.contentView);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(120);
        }];
        
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(70);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(20);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        wmPlayer.FF_View.hidden = YES;
    }];
    
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
    
    [wmPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.top.equalTo(wmPlayer).with.offset(0);
    }];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        wmPlayer.effectView.frame = CGRectMake([UIScreen mainScreen].bounds.size.height/2-155/2, [UIScreen mainScreen].bounds.size.width/2-155/2, 155, 155);
    }else{
    }
    [wmPlayer.FF_View  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.height/2-120/2);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-60/2);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(120);
    }];
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.top.equalTo(wmPlayer.contentView).with.offset(0);
    }];
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.bottom.equalTo(wmPlayer.contentView).with.offset(0);
    }];
    
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset(0);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-30/2);
        make.height.equalTo(@30);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.height/2-22/2);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-22/2);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    wmPlayer.fullScreenBtn.selected = YES;
    wmPlayer.isFullscreen = YES;
    wmPlayer.FF_View.hidden = YES;
}
-(void)toSmallScreen{
    //放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.7f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height-49-([UIScreen mainScreen].bounds.size.width/2)*0.75, [UIScreen mainScreen].bounds.size.width/2, ([UIScreen mainScreen].bounds.size.width/2)*0.75);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        
        [wmPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2);
            make.height.mas_equalTo(([UIScreen mainScreen].bounds.size.width/2)*0.75);
            make.left.equalTo(wmPlayer).with.offset(0);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        wmPlayer.FF_View.hidden = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
}

///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
    detalVideoCell *currentCell = (detalVideoCell *)[thisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
    detalVideoCell *currentCell = (detalVideoCell *)[thisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}


-(void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    UIView *cellView = [sender superview];
    while (![cellView isKindOfClass:[UITableViewCell class]])
    {
        cellView =  [cellView superview];
    }
    self.currentCell = (detalVideoCell *)cellView;
//    VideoModel *model = [self.dataSource objectAtIndex:sender.tag];
    if (isSmallScreen) {
        [self releaseWMPlayer];
        isSmallScreen = NO;
    }
    if (wmPlayer) {
        [self releaseWMPlayer];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        //关闭音量调节的手势
        //        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        wmPlayer.URLString = self.URLString;
        wmPlayer.titleLabel.text = @"";
        //        [wmPlayer play];
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        //关闭音量调节的手势
        //        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.titleLabel.text =@"";
        wmPlayer.URLString = self.URLString;
    }
    
    [self.currentCell.backgroundIV addSubview:wmPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [thisTableView reloadData];
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        iconImgV.hidden = NO;
        iconImgV.alpha = alpha;
        
        titleLab.hidden = NO;
        titleLab.alpha = alpha;
        
        //5-28 如果是自己 不显示关注按钮
        NSString *myid = UserId_New;
        if ([self.ObjectId integerValue] == [myid integerValue]) {
            guanzhu.hidden = YES;
        }else{
            guanzhu.hidden = NO;
        }
        guanzhu.alpha = alpha;
    }else {
        iconImgV.hidden = YES;
        
        titleLab.hidden = YES;
        
        guanzhu.hidden = YES;
    }
    
    if(scrollView ==thisTableView){
        if (wmPlayer==nil||wmPlayer.isFullscreen) {
            return;
        }
        
        if (wmPlayer.superview) {
            CGRect rectInTableView = [thisTableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [thisTableView convertRect:rectInTableView toView:[thisTableView superview]];
            if (rectInSuperview.origin.y<-self.currentCell.backgroundIV.frame.size.height||rectInSuperview.origin.y>[UIScreen mainScreen].bounds.size.height-64-49) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.backgroundIV.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}
/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}
-(NSMutableArray *)pinglunArr{
    if (!_pinglunArr) {
        _pinglunArr = [NSMutableArray array];
        
    }
    return _pinglunArr;
}
-(NSMutableArray *)zanArray{
    if (!_zanArray) {
        _zanArray =[NSMutableArray array];
    }
    
    return _zanArray;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    _inputStr =@"";
    [self setupNav];
    [self createUI];
    [self getDongTaiDetail];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable =NO;
 
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    if (!_navView) {
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    if (!backBtn) {
        backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    //5-28 修改 -------------------------
    if (!iconImgV) {
        iconImgV = [[UIImageView alloc]init];
    }
    [iconImgV sd_setImageWithURL:[NSURL URLWithString:self.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [_navView addSubview:iconImgV];
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.left.mas_equalTo(backBtn.mas_right).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    iconImgV.hidden = YES;
    iconImgV.layer.cornerRadius = 15;
    iconImgV.clipsToBounds = YES;
    
    if (!titleLab) {
        titleLab = [[UILabel alloc]init];
    }
    titleLab.text = self.DynamicerName;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    titleLab.hidden = YES;
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.left.mas_equalTo(iconImgV.mas_right).mas_offset(5);
    }];
    
    //5-28 修改 -------------------------
    
    if ([self.fromType isEqualToString:@"0"]) {
        //我的动态
        if (!moreBtn) {
            moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [moreBtn setTitle:@"" forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview: moreBtn];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(30, 40));
            make.right.mas_equalTo(_navView).mas_offset(-15);
            make.bottom.mas_equalTo(_navView.mas_bottom);
        }];
        
    }else{
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
    }
    
    if (!guanzhu) {
        guanzhu = [[UIButton alloc]init];
    }
    [guanzhu setTitle:@" + 关注 " forState:UIControlStateNormal];
    [guanzhu setTitleColor:WhiteColor forState:UIControlStateNormal];
    [guanzhu setTitle:@" 已关注 " forState:UIControlStateSelected];
    [guanzhu setTitleColor:GrayColor forState:UIControlStateSelected];
    if (guanzhu.isSelected) {//已关注
        [guanzhu setBackgroundColor:WhiteColor];
        guanzhu.layer.borderColor = LightGrayColor.CGColor;
        guanzhu.layer.borderWidth = 1;
    }else{
        [guanzhu setBackgroundColor:RGB(250, 80, 120)];
    }
    
    //5-28 如果是自己 不显示关注按钮
    NSString *myid = UserId_New;
    if ([self.ObjectId integerValue] == [myid integerValue]) {
        guanzhu.hidden = YES;
    }else{
        guanzhu.hidden = NO;
    }
    
    [guanzhu addTarget:self action:@selector(guanzhuClick) forControlEvents:UIControlEventTouchUpInside];
    guanzhu.hidden = YES;
    [_navView addSubview:guanzhu];
    [guanzhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.size.mas_equalTo(CGSizeMake(70, 25));
        make.right.mas_equalTo(-50);
        make.left.mas_greaterThanOrEqualTo(titleLab.mas_right);
    }];
    guanzhu.layer.cornerRadius = 5;
    guanzhu.clipsToBounds = YES;
    
}
-(void)createUI{
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [thisTableView registerNib:[UINib nibWithNibName:@"detalVideoCell" bundle:nil] forCellReuseIdentifier:@"detalVideoCell"];
    [self.view addSubview:thisTableView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thisTableView.frame), ScreenWidth, 50)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];
    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview: shareBtn];
//    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(bottomView);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.right.mas_equalTo(bottomView.mas_right).offset(-10);
//    }];
    
    
    likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.State ==1) {
        [likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
    }else{
        [likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
    }
    [likeBtn addTarget:self action:@selector(zanRequest) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview: likeBtn];
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(bottomView.mas_right).offset(-15);
    }];

    UIView *bgview  = [[UIView alloc]init];
    bgview.backgroundColor =CHJ_bgColor;
    bgview.clipsToBounds =YES;
    bgview.layer.cornerRadius =10;
    [bottomView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView.mas_left).offset(10);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(likeBtn.mas_left).offset(-15);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.font = kFont(15);
    lab.textColor = LightGrayColor;
    lab.text = @"写下你对幸福的见解吧...";
    [bgview addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(bgview);
        make.left.mas_equalTo(bgview.mas_left).offset(10);
//        make.width.mas_equalTo(100);
    }];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.backgroundColor =[UIColor clearColor];
    [cleanBtn addTarget:self action:@selector(pingLunClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview: cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(bgview);
        
    }];
}

- (HRTextView *)hrTextView{
    if (!_hrTextView) {
        _hrTextView = [[HRTextView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        _hrTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [_hrTextView setPlaceholderText:@"说点什么吧"];
        __block HRDTVideoDetailViewController *  blockSelf = self;
        _hrTextView.HRTextViewBlock = ^(NSString *test){
            
            _inputStr =test;
            [blockSelf pinglunRequest];
        };
    }
    return _hrTextView;
}

#pragma mark --------tableviewDatascource ----------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if(section ==0){
      
        
            return 3;
        
        
    }else{
        return self.pinglunArr.count;
        
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0){

            if(indexPath.row ==0){
                
                HRDTDetailTopCell *cell = [HRDTDetailTopCell cellWithTableView:tableView];
                [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
                if ([self.DynamicerName isEqualToString:@""]) {
                    cell.nameLab.text =@"未设置姓名";
                }else{
                    cell.nameLab.text =self.DynamicerName;
                }
                
                cell.shenfengLab.text = [CXDataManager checkUserProfession:self.OccupationCode];
                cell.shenfengLab.backgroundColor = RGB(250, 80, 120);
                
                //5-28 如果是自己 不显示关注按钮
                NSString *myid = UserId_New;
                if ([self.ObjectId integerValue] == [myid integerValue]) {
                    cell.guanzhuBtn.hidden = YES;
                }else{
                    cell.guanzhuBtn.hidden = NO;
                }
                
                [cell.guanzhuBtn addTarget:self action:@selector(guanzhuClick) forControlEvents:UIControlEventTouchUpInside];
                
                cell.guanzhuBtn.selected = guanzhu.selected;
                
                [cell.guanzhuBtn setTitle:@" + 关注 " forState:UIControlStateNormal];
                [cell.guanzhuBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
                [cell.guanzhuBtn setTitle:@" 已关注 " forState:UIControlStateSelected];
                [cell.guanzhuBtn setTitleColor:GrayColor forState:UIControlStateSelected];
                
                if (cell.guanzhuBtn.isSelected) {//已关注
                    [cell.guanzhuBtn setBackgroundColor:WhiteColor];
                    cell.guanzhuBtn.layer.borderColor = LightGrayColor.CGColor;
                    cell.guanzhuBtn.layer.borderWidth = 1;
                }else{
                    [cell.guanzhuBtn setBackgroundColor:RGB(250, 80, 120)];
                }
                
                cell.timeLab.text =self.CreateTime;
                
                //5-31 添加 跳转个人主页
                [cell.cleanBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            }else if (indexPath.row ==1){
                static NSString *identifier = @"detalVideoCell";
                detalVideoCell *cell = (detalVideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                cell.backgroundIV.contentMode = UIViewContentModeScaleAspectFit;
                     cell.backgroundIV.clipsToBounds = YES;
              
                [cell.backgroundIV sd_setImageWithURL:[NSURL URLWithString:self.CoverImg]];
                [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
                cell.playBtn.tag = indexPath.row;
                
                
                if (wmPlayer&&wmPlayer.superview) {
                    NSLog(@"播放器存在");
                    if (indexPath.row==currentIndexPath.row) {
                        [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
                    }else{
                        [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
                    }
                    NSArray *indexpaths = [tableView indexPathsForVisibleRows];
                    if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
                        if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                            wmPlayer.hidden = NO;
                        }else{
                            wmPlayer.hidden = YES;
                            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
                        }
                    }else{
                        if ([cell.backgroundIV.subviews containsObject:wmPlayer]) {
                            [cell.backgroundIV addSubview:wmPlayer];
                            [wmPlayer play];
                            wmPlayer.hidden = NO;
                        }
                    }
                }
                
                
                return cell;
            }else {
                HRDTTextOnlyCell *cell = [HRDTTextOnlyCell cellWithTableView:tableView];
                cell.desLab.text =self.Content;
                
                return cell;
            }
        
            
        
        
        
        
        
    }else{
        HRPingLunModel *model = _pinglunArr[indexPath.row];
        
        HRDTPingLunCell *cell = [HRDTPingLunCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        cell.deleteBtn.tag = indexPath.row + 1000;
        //4-13 添加
     
        NSString *str = UserId_New;
        if ([model.CommentsPeopleId doubleValue] == [str doubleValue]) {
            cell.deleteBtn.hidden = NO;
            [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.deleteBtn.hidden = YES;
        }
        return cell;
    }
    
}
#pragma mark ----------tableviewdelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
//        if (indexPath.row ==3) {
//            HRLikePeopleListController *lickVC = [HRLikePeopleListController new];
//            lickVC.DynamicID =_DynamicID;
//               lickVC.type =@"2";
//            [self.navigationController pushViewController:lickVC animated:YES];
//        }
    }else{
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0){
    
            
            
            
            
            if (indexPath.row ==0) {
                return 50;
            }else if(indexPath.row ==1){
                
                return     ScreenWidth*9/16 ;
                  
                    
                    
    
                
            }else {
                return [self getHeighWithTitle:self.Content font:kFont(15) width:ScreenWidth-20]+ 30;
            }
            
            
            

        
        
        
        
        
        
    }else{
        return 120;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section ==0){
        return 0;
    }else{
        return 30;
    }
}
#pragma mark - 动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section ==0){
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        headerView.backgroundColor =WhiteColor;
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.font = kFont(13);
        titleLab.textColor =TextNormalColor;
        
        titleLab.text =[NSString stringWithFormat:@"查看全部%zd条评论",    _pinglunArr.count];
        [headerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(headerView.mas_left).offset(10);
        }];
        
        
        likeNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeNumBtn setTitle:[NSString stringWithFormat:@"%zd 喜欢",self.zanArray.count] forState:UIControlStateNormal];
        [likeNumBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
        [likeNumBtn addTarget:self action:@selector(checkLikePeopke) forControlEvents:UIControlEventTouchUpInside];
        [likeNumBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
        likeNumBtn.titleLabel.font =kFont(13);
        [headerView addSubview:likeNumBtn];
        [likeNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.right.mas_equalTo(headerView.mas_right);
            make.size.mas_equalTo(CGSizeMake(150, 30));
            
        }];
        return headerView;
    }
}
#pragma mark ---------target ---------
-(void)backVC{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
    [self.navigationController  popViewControllerAnimated:YES];
}

-(void)moreBtnClick{
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        [XMActionSheet xm_actionSheetWithActionTitles:@[@"分享",@"删除"] actionHander:^(NSUInteger index) {
            
            if (index ==0) {
                [self shareBtnClick];
            }else{
                [self deleteRequest];
            }
        }];
    }
}

-(void)pingLunClick{
    NSLog(@"点击评论");
    [self.view addSubview:self.hrTextView];
    _hrTextView.hidden =NO;
    [_hrTextView.textView becomeFirstResponder];
}
-(void)checkLikePeopke{
    HRLikePeopleListController *lickVC = [HRLikePeopleListController new];
    lickVC.DynamicID =_DynamicID;
    lickVC.type =@"1";
    [self.navigationController pushViewController:lickVC animated:YES];
}
-(void)shareBtnClick{
    [self showShareSDK:[self.DynamicID integerValue] withtitle:self.DynamicerName withdes:self.Content];
}

- (void)deleteBtnClick:(UIButton *)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该条评论?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag;
    [alert show];
    
}

#pragma mark 关注
- (void)guanzhuClick{
    NSLog(@"guanzhuClick");
    
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        if (guanzhu.isSelected) {//已关注
            NSLog(@"已关注");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定取消关注?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 123;
            [alert show];
        }else{//未关注
            NSLog(@"未关注");
            [self UserFollow];
        }
    }
}

#pragma mark 5-31 点击头像
- (void)iconBtnClick{
    
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = self.FacilitatorId;
    hotelVC.profession = self.OccupationCode;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        if (alertView.tag == 123) {
            [self DeleteUserFollow];//取消关注
        }else{
            HRPingLunModel *model = _pinglunArr[alertView.tag-1000];
            
            [self DelCommentsWithCommentsID:model.CommentsID AndCommentserId:model.CommentsPeopleId];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)getDongTaiDetail{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetDynamicInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]   = UserId_New;
    params[@"DynamicID"]    = _DynamicID;;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            NSLog(@"动态详情%@",object);
            self.DynamicerHeadportrait =[object objectForKey:@"DynamicerHeadportrait"];
            self.DynamicerName =[object objectForKey:@"DynamicerName"];
            self.ObjectTypes =[[object objectForKey:@"ObjectTypes"]integerValue];
            self.FileUrl =[object objectForKey:@"FileUrl"];
            self.CreateTime =[object objectForKey:@"CreateTime"];
            self.Content =[object objectForKey:@"Content"];
            self.State =[[object objectForKey:@"State"]integerValue];
            self.OccupationCode =[object objectForKey:@"OccupationCode"];
            self.CoverImg =[object objectForKey:@"CoverImg"];
            self.pinglunArr  =[HRPingLunModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            if (_State ==1) {
                [likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
            }else{
                [likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
            }
            
            //5-29 发起人ID
            self.ObjectId = [object valueForKey:@"ObjectId"];
            
            //5-28 关注状态 0未关注，1已关注
            FollowState = [[object valueForKeyPath:@"FollowState"] integerValue];
            
            //5-31 添加 供应商ID
            self.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            
            //5-28
            [iconImgV sd_setImageWithURL:[NSURL URLWithString:self.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            titleLab.text = self.DynamicerName;
            
            if (FollowState == 0) {//0未关注，1已关注
                guanzhu.selected = NO;
            }else{
                guanzhu.selected = YES;
            }
            
            [self setupNav];
            
            [thisTableView reloadData];
            [self getzanlist];
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

- (void)getzanlist{
    
    NSString *url = @"/api/HQOAApi/GetGivethumbList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]   = UserId_New;
    params[@"DynamicID"]    =_DynamicID;
    params[@"PageIndex"] =@"0";
    params[@"PageCount"] =@"100000";
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.TotalCount =[[object objectForKey:@"TotalCount"]integerValue];
            self.zanArray  =[HRZanModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
        
//                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
//                [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//
             [likeNumBtn setTitle:[NSString stringWithFormat:@"%zd 喜欢",self.zanArray.count] forState:UIControlStateNormal];

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {

        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
}

-(void)zanRequest{
    
    NSString *url = @"/api/HQOAApi/AddDelGivethumb";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"DynamicId"]    = _DynamicID;
    params[@"GivethumberId"] =UserId_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            _State =!_State;
            if (_State ==1) {
                [likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
            }else{
                [likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
            }
            [self getzanlist];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
           
        }
        
    } Failure:^(NSError *error) {
      
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
       
    }];
    
}
-(void)pinglunRequest{
    
    
    NSString *url = @"/api/HQOAApi/AddComments";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"DynamicId"]    =_DynamicID;
    params[@"CommentserId"] =UserId_New;
    params[@"Content"] =_inputStr;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"评论成功!"];
            [self getDongTaiDetail];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
    
        }
        
    } Failure:^(NSError *error) {
      
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
       
    }];
    
}

#pragma mark 删除评论
-(void)DelCommentsWithCommentsID:(NSString *)commentsID AndCommentserId:(NSString *)commentserId{
    
    
 
    NSString *url = @"/api/HQOAApi/DelComments";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"CommentsID"]       = commentsID;
    params[@"CommentserId"]     = commentserId;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"删除评论成功!"];
            [self getDongTaiDetail];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 删除动态
-(void)deleteRequest{
    
    NSString *url = @"/api/HQOAApi/DelDynamic";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"DynamicID"]    = _DynamicID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            [EasyShowTextView showSuccessText:@"删除成功!"];
            [self performSelector:@selector(backVC) withObject:self afterDelay:1.0];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
    
}

#pragma mark 用户关注
-(void)UserFollow{
    
    NSString *url = @"/api/HQOAApi/UserFollow";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]       = UserId_New;
    params[@"FollowId"]     = self.ObjectId;//关注Id
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            [EasyShowTextView showSuccessText:@"关注成功!"];
            [self getDongTaiDetail];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 用户取消关注
-(void)DeleteUserFollow{
    
    NSString *url = @"/api/HQOAApi/DeleteUserFollow";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]       = UserId_New;
    params[@"FollowId"]     = self.ObjectId;//关注Id
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self setupNav];
            [thisTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            
            [EasyShowTextView showSuccessText:@"取消关注成功!"];
            [self getDongTaiDetail];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - shareSDK
- (void)showShareSDK:(NSInteger)dongtaiID withtitle:(NSString *)title withdes:(NSString*)des{
    
      NSString *str = [NSString stringWithFormat:@"http://www.chenghunji.com/fenxiang/Index?id=%zd",dongtaiID];
    [HRShareView showShareViewWithPublishContent:@{@"title":des,
                                                   @"text" :[NSString stringWithFormat:@"来自 %@ 的婚礼桥视频",title],
                                                   @"image":_DynamicerHeadportrait,
                                                   @"url"  :str}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
    
    
  
   
    
}
@end
