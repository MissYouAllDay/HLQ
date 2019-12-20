//
//  YPReReHomeWedPackageDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeWedPackageDetailController.h"
#import "YPWedPackageHeadView.h"
#import "YPWedPackageDetailInfoCell.h"
#import "TLTableViewCell.h"
#import "YPWedPackageDetailWuLiaoCell.h"//物料
#import "YPWedPackageDetailYuLanCell.h"//预览
#import "YPWedPackageBestHotelIMGCell.h"//酒店
#import "HRDTPingLunCell.h"//评论
#import "YPWedPackageHeadTitleCell.h"//6.20 预览头部

#import "YPWedPachageDetailDescController.h"//套餐描述
#import "YPWedPackageDetailPhotoController.h"//预览图片
#import "YPWedPackageDetailVideoController.h"//视频
#import "YPWedPackageDetailWuLiaoController.h"//物料清单-富文本

#import "TLAttributedLabel.h"
#import "TLModel.h"
#import "WMPlayer.h"
#import "detalVideoCell.h"
#import "FL_Button.h"
#import "HRTextView.h"
//动态高度图片cell
#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
static NSString *const cellId = @"DemoVC1Cell";
#import "GKPhotoBrowser.h"
#import "XMActionSheet.h"

//模型
#import "YPGetWeddingPackageInfo.h"//信息
#import "YPGetWeddingPackageAreaImg.h"//图片
#import "YPGetWeddingPackageVideoCaseList.h"//视频
#import "YPGetWeddingPackageEvaluateList.h"//评价
#import "YYKit.h"
#import <YYCache.h>
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 200

static NSString *const identifier = @"TLTableViewCell";

@interface YPReReHomeWedPackageDetailController ()<UITableViewDelegate,UITableViewDataSource,TLTableViewCellDelegate,UIScrollViewDelegate,WMPlayerDelegate,UIAlertViewDelegate,GKPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *offscreenCell;
@property (nonatomic, strong) TLModel *tlModel;

@property (nonatomic, strong) detalVideoCell *currentCell;
//@property (nonatomic, copy) NSString * URLString;

@property (nonatomic, strong) YPGetWeddingPackageInfo *infoModel;
/**图片模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageAreaImg *> *imgMarr;
/**视频模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageVideoCaseList *> *videoMarr;
/**评价模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageEvaluateList *> *pingMarr;

/**评价界面*/
@property (nonatomic, strong) HRTextView *hrTextView;
/**输入的评论内容*/
@property (nonatomic, copy) NSString *inputStr;

/**预览图片总张数*/
@property (nonatomic, assign) NSInteger imgCount;

/**图片数组*/
@property(nonatomic,strong)NSArray  *photoArray;

@end

@implementation YPReReHomeWedPackageDetailController{
    UIView   *_navView;
    UIButton *_backBtn;
    UIButton *_saveBtn;
    UIButton *_shareBtn;
    
    //视频
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    [self.navigationController.navigationBar setHidden:YES];
    
    [self GetWeddingPackageInfo];
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
    
    _inputStr =@"";
    
    self.offscreenCell = [NSMutableDictionary dictionary];
    
    [self setupUI];
    [self setupNav];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    
    self.fd_interactivePopDisabled = YES;
}

#pragma mark - UI
- (void)setupNav{
    
    if (!_navView) {
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //渐变背景
    UIView *colorView = [[UIView alloc] init];
    [colorView setFrame:CGRectMake(0,0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:colorView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
//    gradient.startPoint = CGPointMake(0, 0.5);
//    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGBA(0, 0, 0, 0.16).CGColor,
                       (id)RGBA(0, 0, 0, 0.08).CGColor,
                       (id)RGBA(0, 0, 0, 0).CGColor, nil];
    [colorView.layer addSublayer:gradient];
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [colorView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    //设置导航栏右边分享 -- 6-14 暂时隐藏
//    if (!_shareBtn) {
//        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    }
//    [_shareBtn setImage:[UIImage imageNamed:@"wedP_share"] forState:UIControlStateNormal];
//    [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:_shareBtn];
//    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.size.mas_equalTo(CGSizeMake(20, 40));
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(_backBtn);
//    }];
    
//    //设置导航栏右边收藏 -- 6-15 暂时隐藏
//    if (!_saveBtn) {
//         _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    }
//    [_saveBtn setImage:[UIImage imageNamed:@"wedP_save"] forState:UIControlStateNormal];
//    [_saveBtn setImage:[UIImage imageNamed:@"wedP_save_select"] forState:UIControlStateSelected];
//    [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [colorView addSubview:_saveBtn];
//    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.size.mas_equalTo(CGSizeMake(20, 40));
////        make.right.mas_equalTo(_shareBtn.mas_left).mas_offset(-12);
//        make.right.mas_equalTo(-15);
//        make.centerY.mas_equalTo(_backBtn);
//    }];

}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TLTableViewCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"detalVideoCell" bundle:nil] forCellReuseIdentifier:@"detalVideoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(50);
    }];
    
    FL_Button *kefuBtn = [FL_Button fl_shareButton];
    [kefuBtn setTitle:@"客服" forState:UIControlStateNormal];
    [kefuBtn setImage:[UIImage imageNamed:@"wedP_kefu"] forState:UIControlStateNormal];
    [kefuBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    kefuBtn.status = FLAlignmentStatusTop;
    kefuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [kefuBtn addTarget:self action:@selector(kefuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:kefuBtn];
    [kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(view);
        make.width.mas_equalTo(ScreenWidth/3.0-1);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kefuBtn.mas_right);
        make.centerY.mas_equalTo(kefuBtn);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(1);
    }];
    
    FL_Button *pingBtn = [FL_Button fl_shareButton];
    [pingBtn setTitle:@"评价" forState:UIControlStateNormal];
    [pingBtn setImage:[UIImage imageNamed:@"wedP_ping"] forState:UIControlStateNormal];
    [pingBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    pingBtn.status = FLAlignmentStatusTop;
    pingBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [pingBtn addTarget:self action:@selector(pingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:pingBtn];
    [pingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(view);
        make.left.mas_equalTo(kefuBtn.mas_right).mas_offset(1);
        make.width.mas_equalTo(ScreenWidth/3.0);
    }];
    
    FL_Button *appointBtn = [FL_Button fl_shareButton];
    [appointBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [appointBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    appointBtn.status = FLAlignmentStatusNormal;
    [appointBtn setBackgroundColor:RGB(250, 80, 120)];
    appointBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [appointBtn addTarget:self action:@selector(appointBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:appointBtn];
    [appointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(view);
        make.right.mas_equalTo(view);
        make.width.mas_equalTo(ScreenWidth/3.0);
    }];
}

- (YPWedPackageHeadView *)addHeaderView{
    
    YPWedPackageHeadView *view = [YPWedPackageHeadView yp_wedPackageHeadView];
    view.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.8);
    
    //6-20 修改
    view.videoBtn.hidden = YES;
    view.photoBtn.hidden = YES;
    view.countBtn.hidden = YES;
    
//    [view.videoBtn addTarget:self action:@selector(headVideoBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [view.photoBtn addTarget:self action:@selector(headPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//    [view.countBtn setTitle:[NSString stringWithFormat:@"  %zd 图片·%zd 视频  ",self.imgCount,self.videoMarr.count] forState:UIControlStateNormal];
    return view;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6+self.imgMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else if (section == 1 || section == 2 || section == (4+self.imgMarr.count)){
        return 1;
    }else if (section == (3+self.imgMarr.count)){//视频
        return self.videoMarr.count == 0 ? 0 : 1;//只展示一个
    }else if (section == (5+self.imgMarr.count)){//评论
        return self.pingMarr.count;
    }else{
        YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[section-3];
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < imgModel.ImageData.count; i ++) {
            if (i < 3) {//最多展示三个
                YPGetWeddingPackageAreaImgData *data = imgModel.ImageData[i];
                [marr addObject:data.Image];
            }
        }
        return marr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            YPWedPackageDetailInfoCell *cell = [YPWedPackageDetailInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.infoModel = self.infoModel;
            return cell;
        }else{
            TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            cell.delegate = self;//暂时不用
            if (self.infoModel.BriefIntroduction.length > 0) {
                self.tlModel.title = self.infoModel.BriefIntroduction;
            }else{
                self.tlModel.title = @"无描述";
            }
            self.tlModel.numberOfLines = numberOfLines;
            self.tlModel.state = TLNormalState;
            [cell setModel:self.tlModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1){
        YPWedPackageDetailWuLiaoCell *cell = [YPWedPackageDetailWuLiaoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.lookBtn addTarget:self action:@selector(wuliaoLookBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 2){
        
        YPWedPackageHeadTitleCell *cell = [YPWedPackageHeadTitleCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == (3+self.imgMarr.count)){//视频
        
        YPGetWeddingPackageVideoCaseList *videoModel = self.videoMarr[indexPath.row];
        
        static NSString *identifier = @"detalVideoCell";
        detalVideoCell *cell = (detalVideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.backgroundIV.contentMode = UIViewContentModeScaleAspectFit;
        cell.backgroundIV.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.URLString = videoModel.VideoId;//???
        
        [cell.backgroundIV sd_setImageWithURL:[NSURL URLWithString:videoModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片"]];
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
        
    }else if (indexPath.section == (4+self.imgMarr.count)){//最佳酒店
        
        YPWedPackageBestHotelIMGCell *cell = [YPWedPackageBestHotelIMGCell cellWithTableView:tableView];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.HotelImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.section == (5+self.imgMarr.count)){//评论
        
        YPGetWeddingPackageEvaluateList *pingModel = self.pingMarr[indexPath.row];
        
        HRDTPingLunCell *cell = [HRDTPingLunCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pingModel = pingModel;
        cell.deleteBtn.tag = indexPath.row + 1000;
        NSString *str = UserId_New;
        if ([pingModel.PeopleId doubleValue] == [str doubleValue]) {
            cell.deleteBtn.hidden = NO;
            [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.deleteBtn.hidden = YES;
        }
        return cell;
        
    }else{
        
        YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[indexPath.section-3];
        
        DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        //6-20 点击查看图片列表
        cell.lookAll = @"lookAll";
        
        self.photoArray = imgModel.ImageData;//赋值查看全部数组
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < imgModel.ImageData.count; i ++) {
            if (i < 3) {//最多展示三个
                YPGetWeddingPackageAreaImgData *data = imgModel.ImageData[i];
                [marr addObject:data.Image];
            }
        }
        
        NSString *str = marr[indexPath.row];
        
        cell.imgStr = str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 130;
        }else{
            TLTableViewCell *cell = [self.offscreenCell objectForKey:identifier];
            if(!cell){
                cell = [[TLTableViewCell alloc] init];
                [self.offscreenCell setObject:cell forKey:identifier];
            }
            
            [cell.label setText:self.tlModel.title];
            cell.label.state = self.tlModel.state;
            cell.label.numberOfLines = self.tlModel.numberOfLines;
            
            CGSize size = [cell.label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*kMargin, MAXFLOAT)];
            return size.height + 2*kMargin;
        }
    }else if (indexPath.section == 1){
        return 60;
    }else if (indexPath.section == 2){
        return 50;
    }else if (indexPath.section == (3+self.imgMarr.count)){//视频
        if (self.videoMarr.count > 0) {
            return 220;
        }else{
            return 50;
        }
    }else if (indexPath.section == (4+self.imgMarr.count)){//最佳酒店
        return 200;
    }else if (indexPath.section == (5+self.imgMarr.count)){//评论
        return 120;
    }else{
        YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[indexPath.section-3];
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < imgModel.ImageData.count; i ++) {
            if (i < 3) {//最多展示三个
                YPGetWeddingPackageAreaImgData *data = imgModel.ImageData[i];
                [marr addObject:data.Image];
            }
        }
        
        NSString *str = marr[indexPath.row];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == (3+self.imgMarr.count) || section == (4+self.imgMarr.count) || section == (5+self.imgMarr.count)) {//只有视频、酒店和评论有头部
//        return 50;
//    }else{
//        return 0.1;
//    }
    
    if (section == 0 || section == 1 || section == 2) {
        return 0.1;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == (3+self.imgMarr.count)) {//只有视频有底部 -- 6-26 视频无底部
//        return 60;
//    }else
    if (section == 0 || section == 1 || section == (2 + self.imgMarr.count) || section == (4+self.imgMarr.count) || section == (5+self.imgMarr.count) || section == (3+self.imgMarr.count)){
        return 10;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1 || section == 2) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        
        if (section == (3+self.imgMarr.count) || section == (4+self.imgMarr.count) || section == (5+self.imgMarr.count)) {
            
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:20];
            label.textColor = GrayColor;
            
            UILabel *count = [[UILabel alloc]init];
            
            if (section == (3+self.imgMarr.count)){
                label.text = @"实例视频";
                
                UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                [allBtn setTitleColor:RGB(250, 80, 120) forState:UIControlStateNormal];
                allBtn.titleLabel.font = [UIFont systemFontOfSize:17];
                [allBtn addTarget:self action:@selector(allVideoClick) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:allBtn];
                [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(view);
                    make.right.mas_equalTo(-18);
                }];
                
            }else if (section == (4+self.imgMarr.count)){
                label.text = @"最佳酒店";
            }else if (section == (5+self.imgMarr.count)){
                label.text = @"评价";
                count.font = [UIFont systemFontOfSize:14];
                count.textColor = GrayColor;
                count.text = [NSString stringWithFormat:@"( %zd )",self.pingMarr.count];
                [view addSubview:count];
            }
            
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view);
                make.left.mas_equalTo(18);
            }];
            if (section == (5+self.imgMarr.count)) {
                [count mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(label);
                    make.left.mas_equalTo(label.mas_right).mas_offset(12);
                }];
            }
        }else{
            
            YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[section-3];
            
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:17];
            label.textColor = BlackColor;
            label.text = imgModel.AreaName;
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view);
                make.left.mas_equalTo(18);
            }];
            
            UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
            [allBtn setTitleColor:RGB(250, 80, 120) forState:UIControlStateNormal];
            allBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            allBtn.tag = section-3 + 1000;
            [allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:allBtn];
            [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view);
                make.right.mas_equalTo(-18);
            }];
        }
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    //6-26 视频无底部
//    if (section == (3+self.imgMarr.count)) {
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = WhiteColor;
//
//        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [allBtn setTitle:@"查看全部视频" forState:UIControlStateNormal];
//        [allBtn addTarget:self action:@selector(allVideoClick) forControlEvents:UIControlEventTouchUpInside];
//        [allBtn setTitleColor:RGB(250, 80, 120) forState:UIControlStateNormal];
//        [view addSubview:allBtn];
//        [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(view);
//            make.bottom.mas_equalTo(-10);
//            make.left.mas_equalTo(18);
////            make.right.mas_equalTo(-18);
//        }];
//
//        UIView *line = [[UIView alloc]init];
//        line.backgroundColor = CHJ_bgColor;
//        [view addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(allBtn.mas_bottom);
//            make.left.right.bottom.mas_equalTo(view);
//        }];
//
//        return view;
//    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        return view;
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            NSLog(@"info");
            YPWedPachageDetailDescController *detail = [[YPWedPachageDetailDescController alloc]init];
            detail.descStr = self.infoModel.BriefIntroduction;
            [self presentViewController:detail animated:YES completion:nil];
        }
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == (3+self.imgMarr.count) || indexPath.section == (4+self.imgMarr.count) || indexPath.section == (5+self.imgMarr.count)){
        
    }else{
        
        YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[indexPath.section-3];
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < imgModel.ImageData.count; i ++) {
            if (i < 3) {//最多展示三个
                YPGetWeddingPackageAreaImgData *data = imgModel.ImageData[i];
                [marr addObject:data.Image];
            }
        }
        
        NSMutableArray *photos = [NSMutableArray new];
        [marr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GKPhoto *photo = [GKPhoto new];
            photo.url = [NSURL URLWithString:obj];
            
            [photos addObject:photo];
        }];
        
        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.row];
        browser.showStyle = GKPhotoBrowserShowStyleNone;
        browser.delegate =self;
        [browser showFromVC:self];
        
    }
}

//#pragma mark - TLTableViewCellDelegate
//- (void)tableViewCell:(TLTableViewCell *)cell model:(TLModel *)model numberOfLines:(NSUInteger)numberOfLines {
//    model.numberOfLines = numberOfLines;
//    
//    if (numberOfLines == 0) {
//        model.state = TLOpenState;
//    }else {
//        model.state = TLCloseState;
//    }
//    
//    [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
//}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
//        [_saveBtn setImage:[UIImage imageNamed:@"wedP_save_gray"] forState:UIControlStateNormal];
    }
    else
    {
        _navView.backgroundColor = ClearColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
//        [_saveBtn setImage:[UIImage imageNamed:@"wedP_save"] forState:UIControlStateNormal];
    }
    
    if(scrollView == self.tableView){
        if (wmPlayer==nil||wmPlayer.isFullscreen) {
            return;
        }
        
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        if (alertView.tag == 1234) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"15192055999"]]];
        }else{
            YPGetWeddingPackageEvaluateList *list = self.pingMarr[alertView.tag-1000];
            
            [self DeleteWeddingPackageEvaluateWithID:list.Id];
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnClick{
    NSLog(@"shareBtnClick");
}

- (void)saveBtnClick:(UIButton *)sender{
    NSLog(@"saveBtnClick");
    
    sender.selected = !sender.selected;
    
//    [self AddAndDelCollectionInfo];//收藏暂时隐藏
}

#pragma mark - head target
- (void)headVideoBtnClick{
    NSLog(@"headVideoBtnClick");
    
    YPWedPackageDetailVideoController *video = [[YPWedPackageDetailVideoController alloc]init];
    video.videoArr = self.videoMarr.copy;
    [self presentViewController:video animated:YES completion:nil];
}

- (void)headPhotoBtnClick{
    NSLog(@"headPhotoBtnClick");
    
    YPWedPackageDetailPhotoController *photo = [[YPWedPackageDetailPhotoController alloc]init];
    photo.imgArr = self.imgMarr.copy;
    [self presentViewController:photo animated:YES completion:nil];
}

#pragma mark - 物料 target
- (void)wuliaoLookBtnClick{
    NSLog(@"wuliaoLookBtnClick");
    
    YPWedPackageDetailWuLiaoController *detail  = [[YPWedPackageDetailWuLiaoController alloc]init];
    detail.contentStr = self.infoModel.DetailedList;
    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark - 全部 target
- (void)allPhotoClick{
    NSLog(@"allPhotoClick");
    
    YPWedPackageDetailPhotoController *photo = [[YPWedPackageDetailPhotoController alloc]init];
    photo.imgArr = self.imgMarr.copy;
    [self presentViewController:photo animated:YES completion:nil];
}

- (void)allVideoClick{
    NSLog(@"allVideoClick");
    
    YPWedPackageDetailVideoController *video = [[YPWedPackageDetailVideoController alloc]init];
    video.videoArr = self.videoMarr.copy;
    [self presentViewController:video animated:YES completion:nil];
}

#pragma mark - 评论 target
- (void)deleteBtnClick:(UIButton *)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该条评论?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag;
    [alert show];
    
}

#pragma mark - bottom target
- (void)kefuBtnClick{
    NSLog(@"kefuBtnClick");

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系客服" message:@"手机号 : 15192055999\n微    信 : 15192055999" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.tag = 1234;
    [alert show];
}

- (void)pingBtnClick{
    NSLog(@"pingBtnClick");
    
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        [self.view addSubview:self.hrTextView];
        _hrTextView.hidden =NO;
        [_hrTextView.textView becomeFirstResponder];
    }
}

- (void)appointBtnClick{
    NSLog(@"appointBtnClick");
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        [self CreateWeddingPackageReserve];
    }
}

#pragma mark - 预览图全部
- (void)allBtnClick:(UIButton *)sender{
    
    YPGetWeddingPackageAreaImg *imgModel = self.imgMarr[sender.tag-1000];
    
    NSMutableArray *photos = [NSMutableArray new];
    [imgModel.ImageData enumerateObjectsUsingBlock:^(YPGetWeddingPackageAreaImgData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj.Image];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.delegate =self;
    [browser showFromVC:self];
    
}

#pragma mark - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index {
    
    
    [XMActionSheet xm_actionSheetWithActionTitles:@[@"保存图片"] actionHander:^(NSUInteger index) {
        
        if (index ==0) {
            YPGetWeddingPackageAreaImgData *data = self.photoArray[index];
            [self toSaveImage:data.Image];
        }
        
        
    }];
    
    
    
    
}

- (void)toSaveImage:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    //    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //从网络下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img= [UIImage imageWithData:data];
    
    // 保存图片到相册中
    UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        [EasyShowTextView showErrorText:@"图片保存失败"];
    }
    else  // No errors
    {
        [EasyShowTextView showSuccessText:@"图片保存成功"];
        
    }
}

#pragma mark - 网络请求
#pragma mark 获取婚礼套餐详情
- (void)GetWeddingPackageInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"0";//角色(0用户,1婚庆公司)
    params[@"Id"] = self.packageId;
    
    params[@"UserId"] = UserId_New;//18-08-09 添加
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.Name = [object valueForKey:@"Name"];
            self.infoModel.OriginalPrice = [object valueForKey:@"OriginalPrice"];
            self.infoModel.PresentPrice = [object valueForKey:@"PresentPrice"];
            self.infoModel.CostPrice = [object valueForKey:@"CostPrice"];
            self.infoModel.Label = [object valueForKey:@"Label"];
            self.infoModel.BriefIntroduction = [object valueForKey:@"BriefIntroduction"];
            self.infoModel.DetailedList = [object valueForKey:@"DetailedList"];
            self.infoModel.CoverMap = [object valueForKey:@"CoverMap"];
            self.infoModel.ShelfType = [object valueForKey:@"ShelfType"];
            self.infoModel.HotelImage = [object valueForKey:@"HotelImage"];

            //6-15 添加 暂时无用
            self.infoModel.CollectionType = [object valueForKey:@"CollectionType"];
            
            //18-08-09 添加 - 暂时无用
            self.infoModel.DetailedListPrice = [object valueForKey:@"DetailedListPrice"];
            self.infoModel.OriginalPackage = [object valueForKey:@"OriginalPackage"];
            
//            [self.tableView reloadData];
            
            [self GetWeddingPackageAreaImg];
            
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

#pragma mark 获取区域图片
- (void)GetWeddingPackageAreaImg{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageAreaImg";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SchemeId"] = self.packageId;//套餐和区域Id默认传一个
    params[@"AreaId"] = @"0";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.imgCount = [[object valueForKey:@"ImgCount"] integerValue];
            
            self.imgMarr = [YPGetWeddingPackageAreaImg mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            [self GetWeddingPackageVideoCaseList];
            
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

#pragma mark 获取婚礼套餐视频案例
- (void)GetWeddingPackageVideoCaseList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageVideoCaseList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.packageId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.videoMarr = [YPGetWeddingPackageVideoCaseList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            self.tableView.tableHeaderView = [self addHeaderView];
            
            [self.tableView reloadSection:(3+self.imgMarr.count) withRowAnimation:UITableViewRowAnimationNone];
            
            [self GetWeddingPackageEvaluateList];
            
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

#pragma mark 获取婚礼套餐评价列表
- (void)GetWeddingPackageEvaluateList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageEvaluateList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.packageId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.pingMarr = [YPGetWeddingPackageEvaluateList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadSection:(5+self.imgMarr.count) withRowAnimation:UITableViewRowAnimationNone];
            
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

#pragma mark 婚礼套餐预定
- (void)CreateWeddingPackageReserve{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateWeddingPackageReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PeopleId"] = UserId_New;
    params[@"SchemeId"] = self.packageId;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"预定成功!"];
            
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

#pragma mark 新增婚礼套餐-评价
- (void)CreateWeddingPackageEvaluate{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateWeddingPackageEvaluate";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PeopleId"] = UserId_New;
    params[@"Content"] = self.inputStr;
    params[@"Image"] = @"";
    params[@"SchemeId"] = self.packageId;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"评论成功!"];
            [self GetWeddingPackageEvaluateList];
            
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

#pragma mark 删除婚礼套餐-评价
- (void)DeleteWeddingPackageEvaluateWithID:(NSString *)evaluateID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DeleteWeddingPackageEvaluate";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = evaluateID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"删除评论成功!"];
            [self GetWeddingPackageEvaluateList];
            
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

//#pragma mark 加入/删除收藏信息 -- 暂时隐藏
//-(void)AddAndDelCollectionInfo{
//    
//    [EasyShowLodingView showLoding];
//    NSString *url = @"/api/HQOAApi/AddAndDelCollectionInfo";
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"CollectionType"]   = @"3";//0供应商、1方案、2宴会，3婚礼套餐
//    params[@"TypeID"] = self.packageId;//套餐Id
//    
//    params[@"CollectorsType"]  = @"0";//0用户端、1公司端
//    params[@"CollectorsID"]   = UserId_New;
//    if (_saveBtn.isSelected) {
//        params[@"Start"]   = @"0";//0添加、1删除
//    }else{
//        params[@"Start"]   = @"1";//0添加、1删除
//    }
//
//    NSLog(@"%@",params);
//    
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
//            NSLog(@"%@",object);
//            
//            if (_saveBtn.isSelected) {
//                [EasyShowTextView showText:@"收藏成功!"];
//            }else{
//                [EasyShowTextView showText:@"取消收藏成功!"];
//            }
//            
//        }else{
//            
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//        }
//        
//    } Failure:^(NSError *error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//        
//    }];
//}

#pragma mark - getter
- (TLModel *)tlModel{
    if (!_tlModel) {
        _tlModel = [[TLModel alloc]init];
//        _tlModel.title = @"泽天ss与京东老总刘强东的约会照。4月7日，刘强东微博发声，称“我们每个人都有选择和决定自己生活的权利。小天是我见过最单纯善良的人，很遗憾自己没能保护好她。感谢大家关心，只求以后可以正常牵手而行。祝大家幸福！";
//        _tlModel.numberOfLines = numberOfLines;
//        _tlModel.state = TLNormalState;
    }
    return _tlModel;
}

- (YPGetWeddingPackageInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetWeddingPackageInfo alloc]init];
    }
    return _infoModel;
}

- (NSMutableArray<YPGetWeddingPackageAreaImg *> *)imgMarr{
    if (!_imgMarr) {
        _imgMarr = [NSMutableArray array];
    }
    return _imgMarr;
}

- (NSMutableArray<YPGetWeddingPackageVideoCaseList *> *)videoMarr{
    if (!_videoMarr) {
        _videoMarr = [NSMutableArray array];
    }
    return _videoMarr;
}

- (NSMutableArray<YPGetWeddingPackageEvaluateList *> *)pingMarr{
    if (!_pingMarr) {
        _pingMarr = [NSMutableArray array];
    }
    return _pingMarr;
}

- (HRTextView *)hrTextView{
    if (!_hrTextView) {
        _hrTextView = [[HRTextView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        _hrTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [_hrTextView setPlaceholderText:@"说点什么吧"];
        __block YPReReHomeWedPackageDetailController *  blockSelf = self;
        _hrTextView.HRTextViewBlock = ^(NSString *test){
            
            _inputStr =test;
            NSLog(@"评论 ---- %@",blockSelf.inputStr);
            [blockSelf CreateWeddingPackageEvaluate];
        };
    }
    return _hrTextView;
}

- (NSArray *)photoArray{
    if (!_photoArray) {
        _photoArray =[NSArray array];
    }
    return _photoArray;
}

#pragma mark - 视频
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
    detalVideoCell *currentCell = (detalVideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:(3+self.imgMarr.count)]];
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
    detalVideoCell *currentCell = (detalVideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:(3+self.imgMarr.count)]];
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
    detalVideoCell *currentCell = (detalVideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:(3+self.imgMarr.count)]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}


-(void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:(3+self.imgMarr.count)];
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
    
    YPGetWeddingPackageVideoCaseList *videoModel;
    if (self.videoMarr.count > 0) {
        videoModel = self.videoMarr[0];
    }
    
    if (wmPlayer) {
        [self releaseWMPlayer];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        //关闭音量调节的手势
        //        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
//        wmPlayer.URLString = self.URLString;
        wmPlayer.URLString = videoModel.VideoId;
        wmPlayer.titleLabel.text = @"";
        //        [wmPlayer play];
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        //关闭音量调节的手势
        //        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.titleLabel.text =@"";
//        wmPlayer.URLString = self.URLString;
        wmPlayer.URLString = videoModel.VideoId;
    }
    
    [self.currentCell.backgroundIV addSubview:wmPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.tableView reloadData];
    
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

- (void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
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
