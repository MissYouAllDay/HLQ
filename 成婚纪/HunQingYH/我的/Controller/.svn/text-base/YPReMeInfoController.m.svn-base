//
//  YPReMeInfoController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeInfoController.h"
#import "YPReMeInfoHeaderView.h"
//#import "YPReMeInfoCell.h"
#import "YPReMeInfoHeaderCell.h"

#import "HRDTOneImageCell.h"
#import "HRDTTwoImageCell.h"
#import "HRDTThreeImageCell.h"
#import "HRDTDetailViewController.h"
#import "HRDongTaiModel.h"
#import "HRDTOnlyTextCell.h"


#import "VideoCell.h"

//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "SidModel.h"
#import "CLPlayerView.h"
#import "HRDTVideoDetailViewController.h"
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 200

@interface YPReMeInfoController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,VideoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**动态数组*/
@property(nonatomic,strong)NSMutableArray  *dtArray;
/**选中动态ID*/
@property(nonatomic,copy)NSString *DynamicID;

/**CLplayer*/
@property (nonatomic, weak) CLPlayerView *playerView;
/**记录Cell*/
@property (nonatomic, assign) UITableViewCell *cell;
@end

@implementation YPReMeInfoController{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;
//    UIButton *_guanZhuBtn;
    NSInteger zanindex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self getDongTaiList];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [[UIApplication sharedApplication] keyWindow].backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];

}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor =  WhiteColor;
    [self.view addSubview:_navView];
    //设置导航栏左边通知
    _backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    _titleLabel  = [[UILabel alloc]init];
    _titleLabel.text = @"";
    _titleLabel.textColor = WhiteColor;
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    _guanZhuBtn = [[UIButton alloc]init];
//    [_guanZhuBtn setTitle:@"+关注" forState:UIControlStateNormal];
//    [_guanZhuBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    _guanZhuBtn.backgroundColor = RGB(255, 173, 0);
//    _guanZhuBtn.layer.cornerRadius = 15;
//    _guanZhuBtn.clipsToBounds = YES;
//    [_guanZhuBtn addTarget:self action:@selector(guanzhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:_guanZhuBtn];
//    [_guanZhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_backBtn);
//        make.right.mas_equalTo(-15);
//        make.size.mas_equalTo(CGSizeMake(70, 30));
//    }];
    
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 370;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      [self.tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    //    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + self.dtArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        
        
        if (indexPath.row == 0) {
            
            YPReMeInfoHeaderCell *cell = [YPReMeInfoHeaderCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"占位图"]];
            cell.nameLabel.text = self.nameStr;
            
            cell.profession.text = [CXDataManager checkUserProfession:self.professionStr];
    
            if ([self.type isEqualToString:@"1"]) {
                cell.desLab.text =@"TA的动态";
            }else{
                 cell.desLab.text =@"TA的视频";
            }
            cell.dongTai.text = [NSString stringWithFormat:@"%zd",self.dtArray.count];
            return cell;
            
        }else{
            
            if ([self.type isEqualToString:@"1"]) {
                
                
                
                HRDongTaiModel *model = self.dtArray[indexPath.row-1];
                if ([model.FileId isEqualToString:@""]) {
                    HRDTOnlyTextCell *cell = [HRDTOnlyTextCell cellWithTableView:tableView];
                    cell.dtModel =model;
                    cell.dtModel.likeNum =model.GivethumbCount;
                    if (![_id isEqualToString:[NSString stringWithFormat:@"%@",UserId_New]]) {
                        cell.guanzhuBtn.hidden =YES;
                        
                    }else{
                        cell.guanzhuBtn.hidden =NO;
                        [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
                    [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    return cell;
                }else{
                    NSArray *array = [model.FileId componentsSeparatedByString:@","];
                    
                    
                    if (array.count ==1) {
                        HRDTOneImageCell *cell = [HRDTOneImageCell cellWithTableView:tableView];
                        cell.dtModel =model;
                        
                        [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        if (![_id isEqualToString:[NSString stringWithFormat:@"%@",UserId_New]]) {
                            cell.guanzhuBtn.hidden =YES;
                            
                        }else{
                            cell.guanzhuBtn.hidden =NO;
                            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        return cell;
                    }else if (array.count ==2){
                        HRDTTwoImageCell *cell = [HRDTTwoImageCell cellWithTableView:tableView];
                        cell.dtModel =model;
                        [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        if (![_id isEqualToString:[NSString stringWithFormat:@"%@",UserId_New]]) {
                            cell.guanzhuBtn.hidden =YES;
                            
                        }else{
                            cell.guanzhuBtn.hidden =NO;
                            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        return cell;
                    }else{
                        HRDTThreeImageCell * cell = [HRDTThreeImageCell cellWithTableView:tableView];
                        cell.dtModel =model;
                        [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        if (![_id isEqualToString:[NSString stringWithFormat:@"%@",UserId_New]]) {
                            cell.guanzhuBtn.hidden =YES;
                        }else{
                            cell.guanzhuBtn.hidden =NO;
                            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        return cell;
                    }
                }
            }else{
                
                
                
                static NSString *identifier = @"VideoCell";
                VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                
                cell.dtModel =self.dtArray[indexPath.row-1];
                cell.delBtn.hidden =YES;
                cell.delegate = self;
                [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                return cell;
            }
            
            
            
            
           
        }
        

    
  
    
}
//cell离开tableView时调用
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        //区分是否是播放器所在cell,销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
}
#pragma mark - 点击播放代理
- (void)cl_tableViewCellPlayVideoWithCell:(VideoCell *)cell{
    //记录被点击的Cell
    _cell = cell;
    //销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:cell.backgroundIV.frame];
    _playerView = playerView;
    [cell.contentView addSubview:_playerView];
    //视频地址
    _playerView.url = [NSURL URLWithString:cell.dtModel.FileId];
    [_playerView updateWithConfig:^(CLPlayerViewConfig *config) {
        config.topToolBarHiddenType = TopToolBarHiddenSmall;
        config.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
        config.progressPlayFinishColor =MainColor;
    }];
    //    _playerView.smallGestureControl = YES;
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        _cell = nil;
        NSLog(@"播放完成");
    }];
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
    }else{
        
        if ([self.type isEqualToString:@"1"]) {
            HRDongTaiModel *model = _dtArray[indexPath.row-1];
            HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
            detailVC.DynamicID =model.DynamicID;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            HRDongTaiModel *model = _dtArray[indexPath.row-1];
            HRDTVideoDetailViewController *detailVC = [HRDTVideoDetailViewController new ];
            detailVC.DynamicID =model.DynamicID;
            detailVC.URLString =model.FileId;
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        
       
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 220;
//    }else{
        return 1;
//    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        YPReMeInfoHeaderView *head = [YPReMeInfoHeaderView yp_ReMeInfoHeaderView];
//        return head;
//    }else{
//        return nil;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = NavBarColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
        _titleLabel.text = @"个人信息";
    }
    else
    {
        _titleLabel.text = @"";
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pinglunBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.dtArray[indexpath.row-1];
    HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
    detailVC.DynamicID =model.DynamicID;
   
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)shareBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    
    HRDongTaiModel *model = self.dtArray[indexpath.row-1];
    
    [self showShareSDK:model.DynamicID withtitle:model.DynamicerName withdes:model.Content];
}
-(void)likBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.dtArray[indexpath.row-1];
    self.DynamicID =model.DynamicID;
    zanindex =indexpath.row-1;
    [self zanRequest];
}
-(void)shanchuClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.dtArray[indexpath.row-1];
    self.DynamicID =model.DynamicID;
    
    
    
    //设置动画类型。建议在appdelegate里面设置一次就好(APP应该统一风格)。
    [EasyShowOptions sharedEasyShowOptions].alertAnimationType =  alertAnimationTypeBounce ;
    //设置主题颜色
    [EasyShowOptions sharedEasyShowOptions].alertTintColor = [UIColor cyanColor];
    EasyShowAlertView *showView = [EasyShowAlertView showAlertWithTitle:@"温馨提示" message:@"删除这条动态？"];
    
    
    [showView addItemWithTitle:@"删除" itemType:ShowAlertItemTypeBlue callback:^(EasyShowAlertView *showview) {
        NSLog(@"删除=%@",showview) ;
        [self deleteRequest];
    }];
    [showView addItemWithTitle:@"取消" itemType:ShowAlertItemTypeRed callback:^(EasyShowAlertView *showview) {
        NSLog(@"取消=%@",showview) ;
    }];
    [EasyShowOptions sharedEasyShowOptions].alertTintColor = [UIColor clearColor];
    
    
    [showView show];
    
    
}

#pragma mark - 网络请求
- (void)getDongTaiList{
    [EasyShowLodingView showLodingText:@"" inView:self.view];

    
    NSString *url = @"/api/HQOAApi/GetDynamicList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     params[@"GetUserId" ]=UserId_New;
    params[@"UserID"]   = _id;
    params[@"DynamicType"]   = @1; //0全部、1自己
    params[@"UserTypes"]   = @0;  // 0用户、1公司
    if ([self.type isEqualToString:@"1"]) {
         params[@"FileType"]   = @0;//0图片 1视频 默认图片
    }else{
         params[@"FileType"]   = @1;//0图片 1视频 默认图片
    }
   
    params[@"PageIndex"]    = @"1";
    params[@"PageCount"]    = @"10000";
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            NSLog(@"动态%@",object);
            [self.dtArray removeAllObjects];
            self.dtArray  =[HRDongTaiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            NSLog(@"========动态个数%zd",_dtArray.count);
            //
            [self setupUI];
            
            
            [self endRefresh];
            [self.tableView reloadData];

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

-(void)zanRequest{
    
    
    NSString *url = @"/api/HQOAApi/AddDelGivethumb";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"GivethumbTypes"]   = @0;
    params[@"ObjectId"]    = _DynamicID;
    params[@"GivethumberId"] =UserId_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            HRDongTaiModel *model = self.dtArray[zanindex];
            HRDongTaiModel *newModel =model;
            newModel.State =!model.State;
            if (newModel.State ==1) {
                newModel.GivethumbCount =model.GivethumbCount+1;
            }else{
                newModel.GivethumbCount =model.GivethumbCount-1;
            }
            
            [_dtArray replaceObjectAtIndex:zanindex withObject:newModel];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:zanindex+1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        
    }];
    
}

-(void)deleteRequest{
    
    
    NSString *url = @"/api/HQOAApi/DelDynamic";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"DynamicID"]    = _DynamicID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
            [self getDongTaiList];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        
    }];
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - shareSDK
- (void)showShareSDK:(NSString *)dongtaiID withtitle:(NSString *)title withdes:(NSString*)des{
    
    NSString *str = [NSString stringWithFormat:@"http://www.chenghunji.com/fenxiang/Index?id=%@",dongtaiID];
    
    [HRShareView showShareViewWithPublishContent:@{@"title":title,
                                                   @"text" :des,
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
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

#pragma mark - getter
-(NSMutableArray *)dtArray{
    if (!_dtArray) {
        _dtArray = [NSMutableArray array];
    }
    return _dtArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
