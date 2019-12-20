//
//  YPHomeInfoPageController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHomeInfoPageController.h"
#import "HRDTListCell.h"
#import "HRDTDetailViewController.h"//图文详情
#import "YPHomeInfoPageHeadReusableView.h"
#import "HRDTVideoDetailViewController.h"//视频详情

static NSString *headID = @"YPHomeInfoPageHeadReusableView";

@interface YPHomeInfoPageController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSInteger PageIndex;
    
    NSInteger zanindex;
}

/**动态collectionview*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**动态数组*/
@property (nonatomic, strong) NSMutableArray *dtArray;
/**选中动态ID*/
@property (nonatomic, copy) NSString *DynamicID;

@end

@implementation YPHomeInfoPageController{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self getDongTaiList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - getter
- (NSMutableArray *)dtArray{
    if (!_dtArray) {
        _dtArray = [NSMutableArray array];
    }
    return _dtArray;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    PageIndex =1;
    self.view.backgroundColor = CHJ_bgColor;
    [self setupNav];
    [self createUI];
}

- (void)setupNav{
    
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
    _titleLabel.textColor = BlackColor;
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)createUI{
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc]init];
    layoutView.scrollDirection =UICollectionViewScrollDirectionVertical;
    layoutView.itemSize =CGSizeMake((ScreenWidth-30)/2, (ScreenWidth-10)/2+80);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) collectionViewLayout:layoutView];
    self.collectionView.backgroundColor =CHJ_bgColor;
    self.collectionView.delegate =self;
    self.collectionView.dataSource =self;
    [self.view addSubview:self.collectionView];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        PageIndex =1;
        [self getDongTaiList];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        PageIndex ++;
        [self getDongTaiList];
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HRDTListCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HRDTListCell"];
 
    // 注册头部
    [self.collectionView registerNib:[UINib nibWithNibName:@"YPHomeInfoPageHeadReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
}

#pragma mark ---------collectionViewDatascource --------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(ScreenWidth, 180);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader){
            
            YPHomeInfoPageHeadReusableView *headerView = (YPHomeInfoPageHeadReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
            
            [headerView.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            headerView.titleLabel.text = self.nameStr;
            
            if (self.profession.length > 0) {
                headerView.shenfen.text = self.profession;
            }else{
                headerView.shenfen.text = [CXDataManager checkUserProfession:self.professionStr];
            }
            
            headerView.dongtai.text = [NSString stringWithFormat:@"%zd",self.dtArray.count];
            
            return headerView;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
    HRDongTaiModel *model = _dtArray[indexPath.row];
//    HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
//    detailVC.DynamicID =model.DynamicID;
//    [self.navigationController pushViewController:detailVC animated:YES];

    //5-29
    if (model.FileType ==1) {
        
        //图文
        HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
        detailVC.DynamicID =model.DynamicID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else  if (model.FileType ==2){
        //视频
        HRDTVideoDetailViewController *videoDetailVC = [HRDTVideoDetailViewController new];
        videoDetailVC.URLString =model.FileId;
        videoDetailVC.DynamicID =model.DynamicID;
        [self.navigationController pushViewController:videoDetailVC animated:YES];
    }

}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)likBtnClick:(id)sender event:(id)event{
    
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:position];
    HRDongTaiModel *model = self.dtArray[indexPath.row];
    self.DynamicID =model.DynamicID;
    zanindex =indexPath.row;
    [self zanRequest];
}

- (void)getDongTaiList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetDynamicList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"GetUserId"] = self.ObjectId;
    params[@"UserId"] = UserId_New;
    if ([self.type isEqualToString:@"1"]) {
        params[@"GetFileType"]   = @1;//0全部 1照片 2视频
    }else if ([self.type isEqualToString:@"2"]) {
        params[@"GetFileType"]   = @2;//0全部 1照片 2视频
    }else{
        params[@"GetFileType"]   = @0;//0全部 1照片 2视频
    }
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
    params[@"ObjectId"]    = [NSString stringWithFormat:@"%@",_DynamicID];
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
- (void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

#pragma mark - 缺省
- (void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.collectionView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.collectionView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getDongTaiList];
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
