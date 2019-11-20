//
//  HRDTVideoViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTVideoViewController.h"
//#import "HRDTVideoCell.h"
#import "VideoCell.h"
#import "HRDongTaiModel.h"
#import "HRDTOnlyTextCell.h"
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "SidModel.h"
#import "CLPlayerView.h"
#import "HRDTVideoDetailViewController.h"
@interface HRDTVideoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,VideoCellDelegate>
{
    UITableView *thisTableView;
    NSInteger PageIndex;
    
    NSInteger zanindex;
    

    
}
/**选中动态ID*/
@property(nonatomic,copy)NSString  *DynamicID;

/** 视频数组*/
@property(nonatomic,strong)NSMutableArray  *videoArray;
/**CLplayer*/
@property (nonatomic, weak) CLPlayerView *playerView;
/**记录Cell*/
@property (nonatomic, assign) UITableViewCell *cell;
@end

@implementation HRDTVideoViewController

-(NSMutableArray *)videoArray{
    if (!_videoArray) {
        _videoArray  = [NSMutableArray array];
        
    }
    return _videoArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    PageIndex =1;
    self.view.backgroundColor =CHJ_bgColor;

    [self getDongTaiList];

    [self createUI];
  
    
    

}




-(void)createUI{
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -NAVIGATION_BAR_HEIGHT -TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.rowHeight = UITableViewAutomaticDimension;
    thisTableView.estimatedRowHeight = 280;
    thisTableView.estimatedSectionFooterHeight = 0;
    thisTableView.estimatedSectionHeaderHeight = 0;
//    thisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    thisTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        PageIndex =1;
        [self getDongTaiList];
        //         [BQActivityView showActiviTy];
    }];
    
    thisTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        PageIndex ++;
        [self getDongTaiList];
    }];
    
    [thisTableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];

    [self.view addSubview:thisTableView];
}


#pragma mark -----------tableviewDatascource -------------

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"VideoCell";
    VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    cell.dtModel =self.videoArray[indexPath.row];
    cell.delBtn.hidden =YES;
      cell.delegate = self;
    [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
      return cell;
    
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
        config.videoFillMode =VideoFillModeResizeAspect;
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
//    HRDongTaiModel *model =_videoArray[indexPath.row];
//    return [self getHeighWithTitle:model.Content font:kFont(15) width:(ScreenWidth -30)]+ScreenWidth*9/16+200;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HRDongTaiModel *model = _videoArray[indexPath.row];
    HRDTVideoDetailViewController *detailVC = [HRDTVideoDetailViewController new ];
    detailVC.DynamicID =model.DynamicID;
    detailVC.URLString =model.FileId;
    UIViewController *myvc = [self getviewController];
    [myvc.navigationController pushViewController:detailVC animated:YES];
}
- (UIViewController *)getviewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
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
#pragma mark ----------targert-----

-(void)likBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [thisTableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [thisTableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.videoArray[indexpath.row];
    self.DynamicID =model.DynamicID;
    zanindex =indexpath.row;
    [self zanRequest];
}
-(void)pinglunBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [thisTableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [thisTableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.videoArray[indexpath.row];
    HRDTVideoDetailViewController *detailVC = [HRDTVideoDetailViewController new ];
    detailVC.DynamicID =model.DynamicID;
    UIViewController *myvc = [self getviewController];
    [myvc.navigationController pushViewController:detailVC animated:YES];
}
-(void)shareBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [thisTableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [thisTableView indexPathForRowAtPoint:point];
    
    HRDongTaiModel *model = self.videoArray[indexpath.row];
    
    [self showShareSDK:[model.DynamicID integerValue] withtitle:model.DynamicerName withdes:model.Content];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDongTaiList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetDynamicList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]       = UserId_New;
    params[@"GetUserId"]   = @"00000000-0000-0000-0000-000000000000";//获取自己:用户传用户id 获取全部:000-00….
    params[@"GetFileType"]     = @2;//0全部 1照片 2视频
    params[@"PageIndex"]    = [NSString stringWithFormat:@"%zd",PageIndex];
    params[@"PageCount"]    = @"10";
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            if (PageIndex ==1) {
                
                
                NSLog(@"视频%@",object);
                [self.videoArray removeAllObjects];
                self.videoArray  =[HRDongTaiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                NSLog(@"========视频个数%zd",self.videoArray.count);
//                //
                
//                [self createUI];
//
//
                [self endRefresh];
                [thisTableView reloadData];
//
                if (self.videoArray.count ==0) {
                    [self showNoDataEmptyView];
                }else{
                    [self hidenEmptyView];
                }

                
                
            }else{
                
                
                NSArray *newArray =[HRDongTaiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                if (newArray.count ==0) {
                    thisTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{


                    [self.videoArray addObjectsFromArray:newArray];

                    [self endRefresh];
                    [thisTableView reloadData];

                
                    
                    
                }
                
                
            }
            
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [self showNetErrorEmptyView];
        
        
    }];
}

-(void)zanRequest{
    
    
    NSString *url = @"/api/HQOAApi/AddDelGivethumb";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"GivethumbTypes"]   = @0;
    params[@"ObjectId"]    = [NSString stringWithFormat:@"%@",_DynamicID];
    params[@"GivethumberId"] =UserId_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            HRDongTaiModel *model = self.videoArray[zanindex];
            HRDongTaiModel *newModel =model;
            newModel.State =!model.State;
            if (newModel.State ==1) {
                newModel.GivethumbCount =model.GivethumbCount+1;
            }else{
                newModel.GivethumbCount =model.GivethumbCount-1;
            }
            
            [_videoArray replaceObjectAtIndex:zanindex withObject:newModel];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:zanindex inSection:0];
            [thisTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            
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
    [thisTableView.mj_header endRefreshing];
    [thisTableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
    
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getDongTaiList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}
#pragma mark - shareSDK
- (void)showShareSDK:(NSInteger)dongtaiID withtitle:(NSString *)title withdes:(NSString*)des{
    
    NSString *str = [NSString stringWithFormat:@"http://www.chenghunji.com/fenxiang/Index?id=%zd",dongtaiID];
    
    [HRShareView showShareViewWithPublishContent:@{@"title":[NSString stringWithFormat:@"来自 %@ 的婚礼桥的视频",title],
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




//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
////    VideoModel *   model = [self.videoArray objectAtIndex:indexPath.row];
////
////    DetailViewController *detailVC = [[DetailViewController alloc]init];
////    detailVC.URLString  = model.m3u8_url;
////    detailVC.title = model.title;
////    //    detailVC.URLString = model.mp4_url;
////    if (indexPath.row%2) {//present测试
////        [self presentViewController:detailVC animated:YES completion:^{
////
////        }];
////    }else{//push测试
////        [self.navigationController pushViewController:detailVC animated:YES];
////    }
//}


-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
