//
//  HRMeViedoViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRMeViedoViewController.h"
#import "HRMeVideoCell.h"
#import "YPGetFileSupplierData.h"
#import <AVFoundation/AVFoundation.h>
#import "CLPlayerView.h"
#import "YPPhotoVideoNoticeView.h"//用前须知
#import "YPGetCustomerInfoBySupplier.h"

@interface HRMeViedoViewController ()<UITableViewDelegate,UITableViewDataSource,HRMeVideoCellDelegate, UIScrollViewDelegate>
{
    UIView *_navView;
}
@property (nonatomic, strong) NSMutableArray<YPGetFileSupplierData *> *listMarr;
@property (nonatomic, strong) UITableView *tableView;
/**记录Cell*/
@property (nonatomic, assign) UITableViewCell *cell;
/**CLplayer*/
@property (nonatomic, weak) CLPlayerView *playerView;

@property (nonatomic, strong) UIControl *control;

@end

@implementation HRMeViedoViewController{
    YPPhotoVideoNoticeView *_noticeView;
    
    NSInteger _pageIndex;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //销毁播放器
    [_playerView destroyPlayer];
    _playerView = nil;
    _cell = nil;
}
-(NSMutableArray<YPGetFileSupplierData *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    
    _pageIndex = 1;
    
    [self setupNav];
    [self setupUI];
    
    //4-10 修改
    if ([self.professionStr integerValue] == 1) {//1: 新人
        [self GetCustomerInfoBySupplier];
    }else{
        [self GetFileSupplier];
    }
    
}
- (void)setupNav{
    
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    if ([self.fromType isEqualToString:@"1"]) {
//        //新人自己
//         titleLab.text = @"我的视频";
//    }else{
//         titleLab.text = @"视频";
//    }
//
//    titleLab.textColor = BlackColor;
//    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
    
    //设置导航栏右边更多
    UIButton *moreBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"问号"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(20, 40));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetFileSupplier];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetFileSupplier];
    }];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       NSLog(@"视频数组个数：%zd",self.listMarr.count);
    return self.listMarr.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRMeVideoCell *cell  = [HRMeVideoCell cellWithTableView:tableView];
    cell.model =self.listMarr[indexPath.row];
    cell.delegate =self;
    if ([self.fromType isEqualToString:@"1"]) {
        //新人自己
        cell.delBtn.hidden =YES;
        cell.buhegeBtn.hidden =YES;
    }else{
        cell.delBtn.hidden =NO;
        cell.delBtn.tag = indexPath.row + 1000;
        [cell.delBtn addTarget:self action:@selector(delVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth*9/16+40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    headerView.backgroundColor =WhiteColor;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-40, 100)];
    titleLab.textAlignment =NSTextAlignmentLeft;
    if ([self.fromType isEqualToString:@"1"]) {
        //新人自己
        titleLab.text = @"我的视频";
    }else{
        titleLab.text = @"视频";
    }
    
    titleLab.font =[UIFont fontWithName:@"ArialMT"size:30];
    [headerView addSubview:titleLab];
    return headerView;
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
- (void)cl_tableViewCellPlayVideoWithCell:(HRMeVideoCell *)cell{
    //记录被点击的Cell
    _cell = cell;
    //销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(10, 0, cell.fmImageView.width, cell.fmImageView.height)];
    _playerView = playerView;
    [cell.contentView addSubview:_playerView];
    
    //视频地址
    _playerView.url = [NSURL URLWithString:cell.model.FileUrl];
    [_playerView updateWithConfig:^(CLPlayerViewConfig *config) {
        config.topToolBarHiddenType = TopToolBarHiddenSmall;
        config.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
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
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [self.view addSubview:self.control];
}

- (void)controlClick{
    
    [self.control removeFromSuperview];
}
    
- (void)delVideoBtnClick:(UIButton *)sender{
    
    [self DeleteUploadedFileWithPage:sender.tag - 1000];
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_noticeView) {
            _noticeView = [YPPhotoVideoNoticeView yp_photoVideoNoticeView];
        }
        [_control addSubview:_noticeView];
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_control);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
        }];
    }
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_noticeView.knowBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
#pragma mark 获取供应商文件上传
- (void)GetFileSupplier{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFileSupplier";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.fromType isEqualToString:@"1"]) {
        //新人自己
           params[@"UserId"]        = @"0";//用户id 供应商的 新人传0
           params[@"Status"]        = @"4";//状态 0全部 1已审核 2未审核 3已驳回 4展示给新人
    }else{
          params[@"UserId"]        = UserId_New;//用户id 供应商的 新人传0
           params[@"Status"]        = @"0";//状态 0全部 1已审核 2未审核 3已驳回 4展示给新人
    }

    params[@"CustomerId"]    = self.customerId;//客户Id 不可为空
    
 
    params[@"UploadType"]    = @"2";//文件类型 0全部，1照片，2视频
    params[@"Phone"]         = @"";
    params[@"CorpName"]      = @"";
    params[@"PageIndex"]    = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"]    = @"20";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex ==1) {
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetFileSupplierData mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetFileSupplierData mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                if (newArray.count ==0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            
            [self endRefresh];
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
            }else{
                
                //4-10 没有供应商 弹出用前须知
                [self moreBtnClick];
                
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark 供应商—婚庆公司删除上传文件
- (void)DeleteUploadedFileWithPage:(NSInteger)page{
    
    [EasyShowLodingView showLoding];
    
    YPGetFileSupplierData *data = self.listMarr[page];
    
    NSString *url = @"/api/HQOAApi/DeleteUploadedFile";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FileId"] = data.Id;//供应商以及婚庆的
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"删除成功!"];
            [self GetFileSupplier];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark 根据供应商id获取客户信息 -- 4-10 修改
- (void)GetCustomerInfoBySupplier{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCustomerInfoBySupplier";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UploadsId"] = UserId_New;//上传者id/供应商id
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSMutableArray *listMarr = [NSMutableArray array];
            
            listMarr = [YPGetCustomerInfoBySupplier mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            if (listMarr.count > 0) {
                
                //4-10 修改 先获取供应商对应的客户ID 再获取照片
                YPGetCustomerInfoBySupplier *info = listMarr[0];
                
                self.customerId = info.Customerid;
                
            }
            
            [self GetFileSupplier];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

//#pragma mark - 缺省
//-(void)showNoDataEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        [self GetFileSupplier];
//    }];
//
//}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
