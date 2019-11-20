//
//  YPReFindGunaZhuController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReFindGunaZhuController.h"
#import "HRDTListCell.h"
#import "HRDTDetailViewController.h"
#import "YPGetSupplierDynamicList.h"
#import "HRDTVideoDetailViewController.h"//视频动态
#import "LMHWaterFallLayout.h"
//动态计算网络图片高度
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"

@interface YPReFindGunaZhuController ()<UICollectionViewDelegate,UICollectionViewDataSource,LMHWaterFallLayoutDeleaget>{
    NSInteger PageIndex;
    
    NSInteger zanindex;
}
/**动态collectionview*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**动态数组*/
@property (nonatomic, strong) NSMutableArray<YPGetSupplierDynamicList *> *dtArray;
/**选中动态ID*/
@property (nonatomic, assign) NSInteger DynamicID;

@end

@implementation YPReFindGunaZhuController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    PageIndex =1;
//    [self GetDynamicList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    PageIndex =1;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self GetDynamicList];
    
    [self createUI];
}

-(void)createUI{
//    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc]init];
//    layoutView.scrollDirection =UICollectionViewScrollDirectionVertical;
//    layoutView.itemSize =CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-10)/2+80);
    
    //19-01-30 瀑布流
    LMHWaterFallLayout *layout = [[LMHWaterFallLayout alloc]init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) collectionViewLayout:layout];//-TAB_BAR_HEIGHT
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
    cell.listModel = self.dtArray[indexPath.row];
    
    YPGetSupplierDynamicList *model = self.dtArray[indexPath.row];
    NSString *str = model.CoverImg;
    
    NSArray *array = [model.FileId componentsSeparatedByString:@","];
    
    if ([model.FileType isEqualToString:@"2"]) {
        cell.videoImgV.hidden = NO;
        [cell.FMImageView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [collectionView  xh_reloadItemAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
    }else{
        cell.videoImgV.hidden = YES;
        [cell.FMImageView sd_setImageWithURL:[NSURL URLWithString:array[0]]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [collectionView  xh_reloadItemAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
    }
    
    
    
    return cell;
}

#pragma  mark -----collectionViewDelegate ---------

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
    YPGetSupplierDynamicList *model = _dtArray[indexPath.row];
    
//    HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
//    detailVC.DynamicID = [model.DynamicID integerValue];
//    UIViewController *myvc = [self getviewController];
//    [myvc.navigationController pushViewController:detailVC animated:YES];
    
    if ([model.FileType isEqualToString:@"1"]) {
        
        //图文
        HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
        detailVC.DynamicID = model.DynamicID ;
        UIViewController *myvc = [self getviewController];
        [myvc.navigationController pushViewController:detailVC animated:YES];
    }else if ([model.FileType isEqualToString:@"2"]){
        //视频
        HRDTVideoDetailViewController *videoDetailVC = [HRDTVideoDetailViewController new];
        
        videoDetailVC.URLString = model.FileId;
        videoDetailVC.DynamicID = model.DynamicID ;
        UIViewController *myvc = [self getviewController];
        [myvc.navigationController pushViewController:videoDetailVC animated:YES];
    }
    
}

#pragma mark - LMHWaterFallLayoutDelegate
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    YPGetSupplierDynamicList *model = self.dtArray[indexPath];
    NSString *str = model.CoverImg;
    
    NSArray *array = [model.FileId componentsSeparatedByString:@","];
    
    if ([model.FileType isEqualToString:@"2"]) {
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:(ScreenWidth-30)/2 estimateHeight:200]+50;
    }else{
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:array[0]] layoutWidth:(ScreenWidth-30)/2 estimateHeight:200]+50;
    }
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 10;
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 2;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ------target-------
-(void)likBtnClick:(id)sender event:(id)event{
    
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:position];
    YPGetSupplierDynamicList *model = self.dtArray[indexPath.row];
    self.DynamicID = [model.DynamicID integerValue];
    zanindex =indexPath.row;
    [self zanRequest];
}

#pragma mark - 网络请求

- (void)GetDynamicList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFollowDynamicList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"]       = UserId_New;
    params[@"GetFileType"]     = @0;//0全部 1照片 2视频
    params[@"PageIndex"]    = [NSString stringWithFormat:@"%zd",PageIndex];
    params[@"PageCount"]    = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            if (PageIndex ==1) {
                
                
                NSLog(@"关注%@",object);
                [self.dtArray removeAllObjects];
                self.dtArray  = [YPGetSupplierDynamicList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                NSLog(@"========关注个数%zd",_dtArray.count);
                //
                [self createUI];
                
                [self endRefresh];
                [self.collectionView reloadData];
                
                if (self.dtArray.count ==0) {
                    [self showNoDataEmptyView];
                }else{
                    [self hidenEmptyView];
                }

            }else{
 
                NSArray *newArray = [YPGetSupplierDynamicList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
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
    params[@"ObjectId"]    = [NSString stringWithFormat:@"%zd",_DynamicID];
    params[@"GivethumberId"] =UserId_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPGetSupplierDynamicList *model = self.dtArray[zanindex];
            YPGetSupplierDynamicList *newModel = model;
            newModel.State = !model.State;
            if (newModel.State == 1) {
                newModel.GivethumbCount = model.GivethumbCount+1;
            }else{
                newModel.GivethumbCount = model.GivethumbCount-1;
            }
            
            [_dtArray replaceObjectAtIndex:zanindex withObject:newModel];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:zanindex inSection:0];
            [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] ];
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];

        }
        
    } Failure:^(NSError *error) {

        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
 
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetSupplierDynamicList *> *)dtArray{
    if (!_dtArray) {
        _dtArray = [NSMutableArray array];
    }
    return _dtArray;
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
        [self GetDynamicList];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
