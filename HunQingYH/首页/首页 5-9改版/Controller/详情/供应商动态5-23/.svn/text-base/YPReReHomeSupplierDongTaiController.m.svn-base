//
//  YPReReHomeSupplierDongTaiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeSupplierDongTaiController.h"
#import "HRDTListCell.h"
#import "HRDTDetailViewController.h"
#import "HRDTVideoDetailViewController.h"//视频详情
#import "YPSupplierHomePageHeader.h"

@interface YPReReHomeSupplierDongTaiController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSInteger PageIndex;
    
    NSInteger zanindex;
}

/**动态数组*/
@property (nonatomic, strong) NSMutableArray *dtArray;
/**选中动态ID*/
@property (nonatomic, assign) NSString *DynamicID;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation YPReReHomeSupplierDongTaiController

#pragma mark - getter
- (NSMutableArray *)dtArray{
    if (!_dtArray) {
        _dtArray = [NSMutableArray array];
    }
    return _dtArray;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetDynamicList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    PageIndex =1;
    self.view.backgroundColor =CHJ_bgColor;
    
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil]; //其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
}

- (void)acceptMsg:(NSNotification *)notification {
    //NSLog(@"%@",notification);
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        self.canScroll = YES;
        self.collectionView.showsVerticalScrollIndicator = YES;
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.collectionView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:nil];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)createUI{
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc]init];
    layoutView.scrollDirection =UICollectionViewScrollDirectionVertical;
    layoutView.itemSize =CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-10)/2+80);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40-56-HOME_INDICATOR_HEIGHT) collectionViewLayout:layoutView];
    self.collectionView.backgroundColor =CHJ_bgColor;
    self.collectionView.delegate =self;
    self.collectionView.dataSource =self;
    [self.view addSubview:self.collectionView];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        PageIndex =1;
        [self GetDynamicList];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        PageIndex ++;
        [self GetDynamicList];
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HRDTListCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HRDTListCell"];

}

#pragma mark ---------collectionViewDatascource --------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dtArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HRDTListCell *cell = (HRDTListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HRDTListCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor =[UIColor clearColor];
    [cell.likeBtn addTarget:self action:@selector(likBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.dtModel =self.dtArray[indexPath.row];
    
    return cell;
}

#pragma  mark -----collectionViewDelegate ---------
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
//    HRDongTaiModel *model = _dtArray[indexPath.row];
//    HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
//    detailVC.DynamicID =model.DynamicID;
////    UIViewController *myvc = [self getviewController];
////    [myvc.navigationController pushViewController:detailVC animated:YES];
//    [self.navigationController pushViewController:detailVC animated:YES];

    //5-30 修改
    HRDongTaiModel *model = _dtArray[indexPath.row];
    if (model.FileType ==1) {
        
        //图文
        HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
        detailVC.DynamicID =model.DynamicID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else  if (model.FileType==2){
        //视频
        HRDTVideoDetailViewController *videoDetailVC = [HRDTVideoDetailViewController new];
        
        videoDetailVC.URLString =model.FileId;
        videoDetailVC.DynamicID =model.DynamicID;
        [self.navigationController pushViewController:videoDetailVC animated:YES];
    }

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

#pragma Mark-------target-------
-(void)likBtnClick:(id)sender event:(id)event{
    
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:position];
    HRDongTaiModel *model = self.dtArray[indexPath.row];
    self.DynamicID =model.DynamicID;
    zanindex =indexPath.row;
    [self zanRequest];
}
#pragma mark - 网络请求
#pragma mark - 获取动态
- (void)GetDynamicList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetDynamicList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"GetUserId"]   = self.userID;//要获取用户的ID
    params[@"UserID"]   = UserId_New;//当前用户的ID
    params[@"DynamicType"]   = @1; //0全部、1自己
    params[@"UserTypes"]   = @0;  // 0用户、1公司
    params[@"FileType"]   = @2;//0图片 1视频 默认图片 2全部 3关注
    params[@"PageIndex"]    = [NSString stringWithFormat:@"%zd",PageIndex];
    params[@"PageCount"]    = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            if (PageIndex ==1) {
                
                NSLog(@"动态%@",object);
                [self.dtArray removeAllObjects];
                self.dtArray  =[HRDongTaiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                NSLog(@"========动态个数%zd",_dtArray.count);
                //
//                [self createUI];
                
                [self endRefresh];
                [self.collectionView reloadData];
                
                if (self.dtArray.count ==0) {
                    [self showNoDataEmptyView];
                }else{
                    [self hidenEmptyView];
                }
     
            }else{
                
                NSArray *newArray =[HRDongTaiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                if (newArray.count ==0) {
                    self.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    
                    [self.dtArray addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.collectionView reloadData];
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
    params[@"ObjectId"]    = _DynamicID;
    params[@"GivethumberId"] = UserId_New;//点赞人ID
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
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:zanindex inSection:0];
            [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] ];
            
            
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
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.collectionView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.collectionView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetDynamicList];
    }];
    
}

-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
