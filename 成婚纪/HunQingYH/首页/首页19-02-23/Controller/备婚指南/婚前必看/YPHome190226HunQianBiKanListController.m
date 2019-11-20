//
//  YPHome190226HunQianBiKanListController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190226HunQianBiKanListController.h"
#import "YPGetInformationArticleList.h"
#import "YPHome180904BeiHunNoteListCell.h"
#import "HRNewsDetailViewController.h"

@interface YPHome190226HunQianBiKanListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetInformationArticleList *> *articleMarr;

@end

@implementation YPHome190226HunQianBiKanListController{
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetInformationArticleList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pageIndex = 1;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-60-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetInformationArticleList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetInformationArticleList];
    }];
    
}

- (void)setArticleID:(NSString *)articleID {
 
    _articleID = articleID;
    [self GetInformationArticleList];
    NSLog(@"&&&&^^^^****%@",articleID);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articleMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //备婚笔记
    YPGetInformationArticleList *article = self.articleMarr[indexPath.row];
    
    YPHome180904BeiHunNoteListCell *cell = [YPHome180904BeiHunNoteListCell cellWithTableView:tableView];
    if (article.Title.length > 0) {
        cell.titleLabel.text = article.Title;
    }else{
        cell.titleLabel.text = @"无名称";
    }
    if (article.TextContent.length > 0) {
        cell.subLabel.text = article.TextContent;
    }else{
        cell.subLabel.text = @"无内容";
    }
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:article.ShowImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPGetInformationArticleList *article = self.articleMarr[indexPath.row];
    HRNewsDetailViewController *detail = [[HRNewsDetailViewController alloc]init];
    detail.newsId = article.InformationArticleID;
    [[self getviewController].navigationController pushViewController:detail animated:YES];
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

#pragma mark - 网络请求
#pragma mark 获取资讯文章列表
- (void)GetInformationArticleList{

    [EasyShowLodingView showLoding];

    NSString *url = @"/api/HQOAApi/GetInformationArticleList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    params[@"WeddingInformationId"] = self.articleID;//5-10 全部传0
    params[@"Title"] = @"";//模糊搜索

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            // 菊花不会自动消失，需要自己移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [EasyShowLodingView hidenLoding];
            });

            if (_pageIndex == 1) {

                [self.articleMarr removeAllObjects];

                self.articleMarr = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            }else{
                NSArray *newArray = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.articleMarr addObjectsFromArray:newArray];
                }

            }

            [self.tableView reloadData];
            [self endRefresh];

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

#pragma mark - getter
- (NSMutableArray<YPGetInformationArticleList *> *)articleMarr{
    if (!_articleMarr) {
        _articleMarr = [NSMutableArray array];
    }
    return _articleMarr;
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetInformationArticleList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetInformationArticleList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
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
