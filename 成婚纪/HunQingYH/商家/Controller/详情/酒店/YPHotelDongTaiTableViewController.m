//
//  YPHotelDongTaiTableViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelDongTaiTableViewController.h"
#import "HRDTOneImageCell.h"
#import "HRDTTwoImageCell.h"
#import "HRDTThreeImageCell.h"
#import "HRDTDetailViewController.h"
#import "HRDongTaiModel.h"
#import "HRDTOnlyTextCell.h"

@interface YPHotelDongTaiTableViewController ()
{
    NSInteger zanindex;
}
/**动态数组*/
@property(nonatomic,strong)NSMutableArray  *dtArray;
/**选中动态ID*/
@property(nonatomic,assign)NSInteger  DynamicID;

@end

@implementation YPHotelDongTaiTableViewController

-(NSMutableArray *)dtArray{
    if (!_dtArray) {
        _dtArray = [NSMutableArray array];
    }
    return _dtArray;
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
    self.view.backgroundColor =bgColor;
    
    [self createUI];
}

#pragma mark - UI
-(void)createUI{
    
    self.view.backgroundColor = bgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 280;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

}

#pragma mark -----------tableviewDatascource -------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dtArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HRDongTaiModel *model = self.dtArray[indexPath.row];
    if ([model.Imgs isEqualToString:@""]) {
        HRDTOnlyTextCell *cell = [HRDTOnlyTextCell cellWithTableView:tableView];
        cell.dtModel =model;
        cell.dtModel.likeNum =model.GivethumbCount;
        cell.guanzhuBtn.hidden =NO;
        [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        NSArray *array = [model.Imgs componentsSeparatedByString:@","];
        
        
        if (array.count ==1) {
            HRDTOneImageCell *cell = [HRDTOneImageCell cellWithTableView:tableView];
            cell.dtModel =model;
            
            [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.guanzhuBtn.hidden =NO;
            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (array.count ==2){
            HRDTTwoImageCell *cell = [HRDTTwoImageCell cellWithTableView:tableView];
            cell.dtModel =model;
            [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.guanzhuBtn.hidden =NO;
            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            HRDTThreeImageCell * cell = [HRDTThreeImageCell cellWithTableView:tableView];
            cell.dtModel =model;
            [cell.likeBtn addTarget:self action:@selector(likBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.guanzhuBtn.hidden =NO;
            [cell.guanzhuBtn addTarget:self action:@selector(shanchuClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
    
    
}
#pragma mark -----------tableviewDelegate -------------
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HRDongTaiModel *model = self.dtArray[indexPath.row];
//    NSArray *array = [model.Imgs componentsSeparatedByString:@","];
//    if ([model.Imgs isEqualToString:@""]) {
//        return [self getHeighWithTitle:model.Content font:kFont(15) width:ScreenWidth-20]+145;
//    }else if (array.count ==1){
//         return 36+140+(ScreenWidth-20)*9/16;
//    }else if (array.count ==2){
//         return 36+150+(ScreenWidth-20)/2;
//    }else{
//         return 36+140+(ScreenWidth-20)/3;
//    }
//
//
//}


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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HRDongTaiModel *model = _dtArray[indexPath.row];
    HRDTDetailViewController *detailVC = [HRDTDetailViewController new ];
    detailVC.DynamicID =model.DynamicID;
    [self.navigationController pushViewController:detailVC animated:YES];
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
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)likBtnClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.dtArray[indexpath.row];
    self.DynamicID =model.DynamicID;
    zanindex =indexpath.row;
    [self zanRequest];
}
-(void)shanchuClick:(UIButton *)sender{
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
    HRDongTaiModel *model = self.dtArray[indexpath.row];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
#pragma mark 获取动态
- (void)getDongTaiList{
    [EasyShowLodingView showLodingText:@"" inView:self.view];
    NSString *url = @"/api/User/GetDynamicList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.UserID.length > 0) {
        params[@"UserID"]   = self.UserID;
    }else{
        params[@"UserID"]   = @3;//传0 全部 随便传
    }
    params[@"DynamicType"]   = @1; //0全部、1自己
    params[@"UserTypes"]   = @0;  // 0用户、1公司
    
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
            [self createUI];
            
            if (self.dtArray.count == 0) {
                
                [self  showNoDataEmptyView];
                
            }
            
            [self endRefresh];
            [self.tableView reloadData];
            
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
    
    
    NSString *url = @"/api/User/AddDelGivethumb";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"GivethumbTypes"]   = @0;
    params[@"ObjectId"]    = [NSString stringWithFormat:@"%zd",_DynamicID];
    params[@"GivethumberId"] =myID;
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
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            
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

-(void)deleteRequest{
    
    
    NSString *url = @"/api/User/DelDynamic";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"DynamicID"]    = [NSString stringWithFormat:@"%zd",_DynamicID];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
            [self getDongTaiList];
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
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getDongTaiList];
    }];
    
}

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getDongTaiList];
    }];
    
}

@end
