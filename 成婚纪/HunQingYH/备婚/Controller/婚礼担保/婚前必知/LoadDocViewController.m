//
//  LoadDocViewController.m
//  JhtDocViewerDemo
//
//  GitHub主页: https://github.com/jinht
//  CSDN博客: http://blog.csdn.net/anticipate91
//
//  Created by Jht on 2017/10/19.
//  Copyright © 2017年 JhtDocViewer. All rights reserved.
//

#import "LoadDocViewController.h"
#import <JhtDocViewer/JhtLoadDocView.h>
#import <JhtDocViewer/OtherOpenButtonParamModel.h>
#import <JhtDocViewer/JhtShowDumpingViewParamModel.h>

@implementation LoadDocViewController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CHJ_bgColor;
    
    // 移除父类的tableView
    [_baseTableView removeFromSuperview];
    
    // 设置导航栏
//    [self ldSetNav];
    [self setupNav];
    
    // 创建UI界面
    [self ldCreateUI];
}


#pragma mark - SetNav
/** 设置导航栏 */
//- (void)ldSetNav {
//    // 设置导航栏返回按钮
//    [self bsCreateNavigationBarLeftBtn];
//
//    // 设置导航栏标题
//    [self bsCreateNavigationBarTitleViewWithLabelTitle:self.titleStr];
//}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}


#pragma mark - UI界面
/** 创建UI界面 */
- (void)ldCreateUI {
    // 提示框Model
    JhtShowDumpingViewParamModel *showDumpingViewParamModel = [[JhtShowDumpingViewParamModel alloc] init];
    showDumpingViewParamModel.showTextFont = [UIFont boldSystemFontOfSize:15];
    showDumpingViewParamModel.showBackgroundColor = [UIColor whiteColor];
    showDumpingViewParamModel.showBackgroundImageName = @"dumpView";
    
    // 《用其他应用打开按钮》配置Model
    OtherOpenButtonParamModel *otherOpenButtonParamModel = [[OtherOpenButtonParamModel alloc] init];
    otherOpenButtonParamModel.title_Normal = @"分享或打印";
    otherOpenButtonParamModel.title_Hlighted = @"分享或打印";
    otherOpenButtonParamModel.titleFont = [UIFont boldSystemFontOfSize:20.0];
    otherOpenButtonParamModel.backgroundColor = NavBarColor;
//  otherOpenButtonParamModel.isHiddenBtn = YES;
    
    JhtLoadDocView *docView = [[JhtLoadDocView alloc] initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) withFileModel:self.currentFileModel withShowErrorViewOfFatherView:self.navigationController.view withLoadDocViewParamModel:nil withShowDumpingViewParamModel:showDumpingViewParamModel withOtherOpenButtonParamModel:otherOpenButtonParamModel];
    
    [self.view addSubview:docView];
    
    [docView finishedDownloadCompletionHandler:^(NSString *urlStr) {
        NSLog(@"网络下载文件成功后保存在《本地的路径》：\n%@", urlStr);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
