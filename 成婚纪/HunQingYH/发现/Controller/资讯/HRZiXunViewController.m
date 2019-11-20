//
//  HRZiXunViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRZiXunViewController.h"
#import "FL_Button.h"
#import "HXSearchBar.h"
#import "UIParameter.h"
#import "NinaSelectionView.h"
#import "HRZiXunCell.h"
#import "YPGetWeddingInformationList.h"//模型
#import "YPGetInformationArticleList.h"
#import "YPReHomeNewsDetailController.h"
#import "HRNewsDetailViewController.h"//图文混排详情


@interface HRZiXunViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,NinaSelectionDelegate>
{
    UITableView *thisTableView;
    FL_Button *leiBth;
    NSString *changeStr;
    NSInteger _pageIndex;
    
    NSString *_selectTag;
    NSString *_searchStr;
    UIView *nodateView;
}
@property (nonatomic, strong) NinaSelectionView *ninaSelectionView;
///标题模型数组
@property (nonatomic, strong) NSMutableArray<YPGetWeddingInformationList *> *titleMarr;
///标题数组
@property (nonatomic, strong) NSMutableArray *tagMarr;
///文章数组
@property (nonatomic, strong) NSMutableArray<YPGetInformationArticleList *> *infoList;

@end

@implementation HRZiXunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    nodateView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-60-TAB_BAR_HEIGHT)];
    nodateView.backgroundColor = [UIColor whiteColor];
   
    [self GetWeddingInformationList];
    
    _pageIndex = 1;
    
    [self createUI];
    
    [self GetInformationArticleListWithWeddingInformationId:@"0" AndTitle:@""];//传0查全部
}
-(void)createUI{

    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    
    leiBth = [FL_Button fl_shareButton];
    [leiBth setBackgroundColor:[UIColor whiteColor]];
    [leiBth setImage:[UIImage imageNamed:@"下拉_Gray"] forState:UIControlStateNormal];
    [leiBth setTitle:@"婚礼" forState:UIControlStateNormal];
    [leiBth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leiBth.status = FLAlignmentStatusCenter;
    leiBth.titleLabel.font = [UIFont systemFontOfSize:14];
    [leiBth addTarget:self action:@selector(leiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leiBth];
    [leiBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.left.mas_equalTo(topView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    
    //加上 搜索栏
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(120, 10, ScreenWidth  - 130, 40)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"搜索你感兴趣的资讯标题关键字";
    //光标颜色
    searchBar.cursorColor =MainColor;
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 4;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    searchBar.searchBarTextField.layer.borderColor = WhiteColor.CGColor;
    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    searchBar.searchBarTextField.backgroundColor =RGB(235, 235, 235);
    
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [topView addSubview:searchBar];
   
 
    
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight -NAVIGATION_BAR_HEIGHT-60-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    thisTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:_searchStr];
    }];
    thisTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:_searchStr];
    }];
    [self.view addSubview:thisTableView];
}

#pragma mark -----------tableviewDatascource -------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetInformationArticleList *info = self.infoList[indexPath.row];
    
    HRZiXunCell *cell = [HRZiXunCell cellWithTableView:tableView];
    cell.infoModel = info;
    return cell;
}
#pragma mark -----------tableviewDelegate -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetInformationArticleList *article = self.infoList[indexPath.row];
//    YPReHomeNewsDetailController *detail = [[YPReHomeNewsDetailController alloc]init];
//    detail.articleModel = article;
    HRNewsDetailViewController *detail  = [[HRNewsDetailViewController alloc]init];
    detail.newsId =article.InformationArticleID;
    [[self getviewController].navigationController pushViewController:detail animated:YES];
}

#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HXSearchBar *sear = (HXSearchBar *)searchBar;
    //取消按钮
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    
   
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
    //请求网络
    NSLog(@"搜索");
    _searchStr = searchBar.text;
    
    [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:_searchStr];
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
}
#pragma mark - NinaSelectionDelegate
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Choose %li button",(long)button.tag);
    changeStr = button.titleLabel.text;
    
    if (button.tag == 1) {//全部
        
        _selectTag = @"0";
        
        [leiBth setTitle:changeStr forState:UIControlStateNormal];
        [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.3];
        //    [thisTableView reloadData];
        [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:_searchStr];
        
    }else{
        
        YPGetWeddingInformationList *tag = self.titleMarr[button.tag-2];
        _selectTag = tag.WeddingInformationID;
        
        [leiBth setTitle:changeStr forState:UIControlStateNormal];
        [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.3];
        //    [thisTableView reloadData];
        [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:_searchStr];
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

#pragma mark --------target---------
-(void)leiBtnClick{
      [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
}

#pragma mark - 网络请求
#pragma mark 获取婚礼资讯列表
- (void)GetWeddingInformationList{
    [nodateView removeFromSuperview];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"PageIndex"] = @"1";
//    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.titleMarr = [YPGetWeddingInformationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetWeddingInformationList *info in self.titleMarr) {
                [self.tagMarr addObject:info.Title];
            }
            
            [self.view addSubview:self.ninaSelectionView];
            
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

#pragma mark 获取资讯文章列表
- (void)GetInformationArticleListWithWeddingInformationId:(NSString *)articleID AndTitle:(NSString *)title{
    [nodateView removeFromSuperview];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetInformationArticleList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    params[@"WeddingInformationId"] = articleID;
    params[@"Title"] = title;//模糊搜索
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {

                [self.infoList removeAllObjects];

                self.infoList = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

                [thisTableView reloadData];
                [self endRefresh];
            }else{
                NSArray *newArray = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

                if (newArray.count == 0) {
                    thisTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.infoList addObjectsFromArray:newArray];

                    [self endRefresh];
                    [thisTableView reloadData];
                }

            }

            if (self.infoList.count > 0) {
                
                [self hidenEmptyView];
                
            }else{

//                [EasyShowTextView showText:@"当前暂无数据!"];

                [self showNoDataEmptyView];

            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });

//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];

        [self showNetErrorEmptyView];
        
    }];
    
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
        [_tagMarr addObject:@"婚礼"];
    }
    return _tagMarr;
}

- (NSMutableArray<YPGetInformationArticleList *> *)infoList{
    if (!_infoList) {
        _infoList = [NSMutableArray array];
    }
    return _infoList;
}

- (NinaSelectionView *)ninaSelectionView {
    if (!_ninaSelectionView) {
        _ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:self.tagMarr PopDirection:NinaPopFromBelowToTop];
        _ninaSelectionView.ninaSelectionDelegate = self;
        _ninaSelectionView.defaultSelected = 1;
        _ninaSelectionView.shadowEffect = YES;
        _ninaSelectionView.shadowAlpha = 0.5;
    }
    return _ninaSelectionView;
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
    
    
    
  
    [self.view addSubview:nodateView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:nodateView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
       
        }];
    });
    
    
  
    
}
-(void)showNetErrorEmptyView{
    
 
    [self.view addSubview:nodateView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:nodateView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
            [nodateView removeFromSuperview];
            [self GetInformationArticleListWithWeddingInformationId:_selectTag AndTitle:@""];
        }];
    });
    
    
    
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
