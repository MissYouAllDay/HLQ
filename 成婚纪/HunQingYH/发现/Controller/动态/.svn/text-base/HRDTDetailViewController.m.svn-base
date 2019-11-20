//
//  HRDTDetailViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTDetailViewController.h"
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

#import <SDCycleScrollView.h>

#import "GKPhotoBrowser.h"
//#import "YPReMeInfoController.h"
//5-24 替换 个人信息
#import "YPHomeInfoPageController.h"
//5-31 修改 酒店/婚车个人信息
#import "HRHotelViewController.h"
//5-31 修改 其他 个人信息
#import "YPSupplierOtherInfoController.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 150

@interface HRDTDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SDCycleScrollViewDelegate,GKPhotoBrowserDelegate,UIScrollViewDelegate>
{
    UIView *_navView;
    UITableView *thisTableView;
    JPImageShowBackView     *_imageShowBackView;
    UIButton *likeBtn;
    UIButton *likeNumBtn;
    
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

@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) UIView *fromView;

@property (nonatomic, weak) UIView *actionSheet;
/**图片数组*/
@property(nonatomic,strong)NSArray  *photoArray;
@end

@implementation HRDTDetailViewController{
 
    UIButton *backBtn;
    UIImageView *iconImgV;
    UILabel *titleLab;
    UIButton *moreBtn;
    UIButton *guanzhu;
    /**5-28 关注状态
     0未关注，1已关注*/
    NSInteger FollowState;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self getDongTaiDetail];
    [self.navigationController.navigationBar setHidden:YES];
}

#pragma mark - getter
-(NSArray *)photoArray{
    if (!_photoArray) {
        _photoArray =[NSArray array];
    }
    return _photoArray;
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
    
    [self setupNav];//5-28 修改
    [self createUI];

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
    [self.view addSubview:thisTableView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thisTableView.frame), ScreenWidth, 50)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];

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
    bgview.layer.cornerRadius = 5;
    [bottomView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView.mas_left).offset(15);
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
        __block HRDTDetailViewController *  blockSelf = self;
        _hrTextView.HRTextViewBlock = ^(NSString *test){
            
            _inputStr =test;
            [blockSelf pinglunRequest];
        };
    }
    return _hrTextView;
}

#pragma mark - scrollViewDelegate
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
    }
    else
    {
        iconImgV.hidden = YES;
        
        titleLab.hidden = YES;
        
        guanzhu.hidden = YES;
    }
}

#pragma mark --------tableviewDatascource ----------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    if(section ==0){
        if ([self.FileUrl isEqualToString:@""]) {
            return 2;
        }else{
              return 3;
        }
      
    }else{
        return self.pinglunArr.count;
        
    }
        
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0){
        
        
        if ([self.FileUrl isEqualToString:@""]) {

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
                
                [cell.cleanBtn addTarget:self action:@selector(iconImageClick) forControlEvents:UIControlEventTouchUpInside];
                cell.timeLab.text =self.CreateTime;
                return cell;
            }else {
                HRDTTextOnlyCell *cell = [HRDTTextOnlyCell cellWithTableView:tableView];
                cell.desLab.text =self.Content;
                
                return cell;
            }
            
        }else{
            
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
                
                [cell.cleanBtn addTarget:self action:@selector(iconImageClick) forControlEvents:UIControlEventTouchUpInside];
                cell.timeLab.text =self.CreateTime;
                return cell;
            }else if (indexPath.row ==1){
                UITableViewCell *cell = [UITableViewCell new];
                
                self.photoArray = [self.FileUrl componentsSeparatedByString:@","];
//
//
//                //宽高可以随便写 XY必须确定
//                _imageShowBackView = [[JPImageShowBackView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//                _imageShowBackView.smallImageUrls = array;
//                _imageShowBackView.largeImageUrls = array;
//                _imageShowBackView.superController = self;
//                [cell.contentView addSubview:_imageShowBackView];
//
                self.scrollView.imageURLStringsGroup =self.photoArray;
                [cell.contentView addSubview:self.scrollView];
                
                
                return cell;
            }else {
                HRDTTextOnlyCell *cell = [HRDTTextOnlyCell cellWithTableView:tableView];
                cell.desLab.text =self.Content;
                return cell;
            }
           
            
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
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0){
        
        if ([self.FileUrl isEqualToString:@""]) {
            
           if(indexPath.row==1){
                return [self getHeighWithTitle:self.Content font:kFont(15) width:ScreenWidth-20]+ 80;
            }else
            {
                return 50;
            }
            
        }else{

           if(indexPath.row ==1){
                //图片区域
                return ScreenWidth+40;

            }else if(indexPath.row==2){
                return [self getHeighWithTitle:self.Content font:kFont(15) width:ScreenWidth-20]+ 30;
            }else
            {
                return 50;
            }
   
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
    
        titleLab.text =[NSString stringWithFormat:@"%zd评论",    _pinglunArr.count];
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
#pragma mark -------SDCycleScrollViewdelegate --------
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
   
    
    NSMutableArray *photos = [NSMutableArray new];
    [self.photoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.delegate =self;
    [browser showFromVC:self];
}


#pragma mark - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index {
    

    [XMActionSheet xm_actionSheetWithActionTitles:@[@"保存图片"] actionHander:^(NSUInteger index) {
        
        if (index ==0) {
              [self toSaveImage:self.photoArray[index]];
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


#pragma mark - getter
- (SDCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenWidth) delegate:self placeholderImage:[UIImage imageNamed:@"图片占位图"]];
        _scrollView.currentPageDotColor =MainColor;
        _scrollView.pageDotColor =CHJ_bgColor;
        _scrollView.autoScroll =NO;
        _scrollView.pageControlBottomOffset =-30;
        _scrollView.bannerImageViewContentMode =   UIViewContentModeScaleAspectFill;
    }
    return _scrollView;
}
#pragma mark ---------target ---------
-(void)backVC{
    [self.navigationController  popViewControllerAnimated:YES];
}
-(void)checkLikePeopke{
    HRLikePeopleListController *lickVC = [HRLikePeopleListController new];
    lickVC.DynamicID =_DynamicID;
    lickVC.type =@"1";
    [self.navigationController pushViewController:lickVC animated:YES];
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

-(void)shareBtnClick{
    [self showShareSDK:self.DynamicID withtitle:self.DynamicerName withdes:self.Content];
}

- (void)deleteBtnClick:(UIButton *)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该条评论?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag;
    [alert show];

}
-(void)iconImageClick{

    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = self.FacilitatorId;
    hotelVC.profession = self.OccupationCode;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            self.FileUrl=[object objectForKey:@"FileUrl"];
            self.CreateTime =[object objectForKey:@"CreateTime"];
            self.Content =[object objectForKey:@"Content"];
            self.State =[[object objectForKey:@"State"]integerValue];
            self.OccupationCode =[object objectForKey:@"OccupationCode"];
            self.ObjectId =[object objectForKey:@"ObjectId"];
            
            //5-28 关注状态 0未关注，1已关注
            FollowState = [[object valueForKeyPath:@"FollowState"] integerValue];
            //5-31 添加 供应商ID
            self.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            
            self.pinglunArr  =[HRPingLunModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            if (_State ==1) {
                [likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
            }else{
                [likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
            }
            
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
    params[@"DynamicID"]    = _DynamicID;
    params[@"PageIndex"] =@"0";
    params[@"PageCount"] =@"100000";
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
      
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.TotalCount =[[object objectForKey:@"TotalCount"]integerValue];
            self.zanArray  =[HRZanModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
//            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//            [thisTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
            
            
            guanzhu.selected = !guanzhu.selected;
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
- (void)showShareSDK:(NSString*)dongtaiID withtitle:(NSString *)title withdes:(NSString*)des{
    
    NSString *str = [NSString stringWithFormat:@"http://www.chenghunji.com/fenxiang/Index?id=%@",dongtaiID];
    
    [HRShareView showShareViewWithPublishContent:@{@"title":des,
                                                   @"text" :[NSString stringWithFormat:@"来自 %@ 的婚礼桥动态",title],
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
