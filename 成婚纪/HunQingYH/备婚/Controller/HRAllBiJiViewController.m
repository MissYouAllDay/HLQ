//
//  HRAllBiJiViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/5/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRAllBiJiViewController.h"
#import "YPGetInformationArticleList.h"
#import "YPReHomeNewsCell.h"
#import "HRNewsDetailViewController.h"
@interface HRAllBiJiViewController (){
    NSInteger _pageIndex;
}
///文章数组
@property (nonatomic, strong) NSMutableArray<YPGetInformationArticleList *> *infoList;
@end

@implementation HRAllBiJiViewController
- (NSMutableArray<YPGetInformationArticleList *> *)infoList{
    if (!_infoList) {
        _infoList = [NSMutableArray array];
    }
    return _infoList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
    _pageIndex =1;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _pageIndex = 1;
//        [self GetInformationArticleListWithWeddingInformationId:self.leiID ];
//    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetInformationArticleListWithWeddingInformationId:self.leiID ];
    }];
    NSLog(@"文章ID%@",self.leiID);
    [self GetInformationArticleListWithWeddingInformationId:self.leiID];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPGetInformationArticleList *info = self.infoList[indexPath.row];
    
//    HRZiXunCell *cell = [HRZiXunCell cellWithTableView:tableView];
//    cell.infoModel = info;
//    return cell;

    
    YPReHomeNewsCell *cell = [YPReHomeNewsCell cellWithTableView:tableView];
    cell.titleLabel.text = info.Title;
    cell.tagLabel.text = [NSString stringWithFormat:@"%@",info.WeddingInformationTitle];
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:info.ShowImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YPGetInformationArticleList *article = self.infoList[indexPath.row];
    HRNewsDetailViewController *detail  = [[HRNewsDetailViewController alloc]init];
    detail.newsId =article.InformationArticleID;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取资讯文章列表
- (void)GetInformationArticleListWithWeddingInformationId:(NSString *)articleID {
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetInformationArticleList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    params[@"WeddingInformationId"] = articleID;
    params[@"Title"] = @"";//模糊搜索
    NSLog(@"请求ID%@",articleID);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.infoList removeAllObjects];
                
                self.infoList = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                [self.tableView reloadData];
                [self endRefresh];
            }else{
                NSArray *newArray = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.infoList addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.tableView reloadData];
                }
                
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
        
        
        
    }];
    
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


@end
