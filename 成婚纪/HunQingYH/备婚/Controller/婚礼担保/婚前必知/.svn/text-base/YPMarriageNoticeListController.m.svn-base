//
//  YPMarriageNoticeListController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMarriageNoticeListController.h"
#import "YPAssureListCell.h"
#import "LoadDocViewController.h"
#import <JhtDocViewer/JhtFileModel.h>
#import <JhtDocViewer/OtherOpenButtonParamModel.h>
#import <JhtDocViewer/JhtShowDumpingViewParamModel.h>
@interface YPMarriageNoticeListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/**致辞稿数组*/
@property(nonatomic,strong)NSArray  *zhiciArray;
/**风俗数组*/
@property(nonatomic,strong)NSArray  *fengsuArray;
/**必备数组*/
@property(nonatomic,strong)NSArray  *bibeiArray;
@end

@implementation YPMarriageNoticeListController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}
-(void)loadData{
 
    
    
    
    _zhiciArray = @[@{@"fileName":@"领导讲话.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/领导讲话.doc"},
                           @{@"fileName":@"新郎父亲致辞.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/新郎父亲致辞.doc"},
                            @{@"fileName":@"新娘父亲演讲稿.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/新娘父亲演讲稿.doc"},
                             @{@"fileName":@"证婚人致辞.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/证婚人致辞.doc"},
                             @{@"fileName":@"主婚人讲话稿.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/主婚人讲话稿.doc"},
                             @{@"fileName":@"新郎致辞.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼致辞稿/新郎致辞.doc"}
                        
                           ];
    _fengsuArray =  @[@{@"fileName":@"青岛当地婚礼流程.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼风俗风俗/青岛当地婚礼流程.doc"},
                             @{@"fileName":@"青岛风俗习惯.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼风俗风俗/青岛风俗习惯.doc"},
                             @{@"fileName":@"新人当天礼仪指导.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼风俗风俗/新人当天礼仪指导.doc"}
                            
                             
                             ];
    _bibeiArray = @[@{@"fileName":@"新郎家或新娘准备的东西.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼必备/新郎家或新娘准备的东西.doc"},
                            @{@"fileName":@"婚礼操办总管职责.doc",@"fileUrl":@"http://www.chenghunji.com/download/婚礼必备/婚礼操办总管职责.doc"}
                            
                            ];
    
}
#pragma mark - UI
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

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 00;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.titleStr isEqualToString:@"婚礼致辞稿"]) {
        return _zhiciArray.count;
    }else if ([self.titleStr isEqualToString:@"婚礼风俗"]){
        return _fengsuArray.count;
    }else{
        return _bibeiArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    YPAssureListCell *cell = [YPAssureListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.descLabel.hidden = YES;
    if ([self.titleStr isEqualToString:@"婚礼致辞稿"]) {
        cell.titleLabel.text = [_zhiciArray[indexPath.row]objectForKey:@"fileName"];
    }else if ([self.titleStr isEqualToString:@"婚礼风俗"]){
       cell.titleLabel.text = [_fengsuArray[indexPath.row]objectForKey:@"fileName"];
    }else{
       cell.titleLabel.text = [_bibeiArray[indexPath.row]objectForKey:@"fileName"];
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 第一个是 网络的，需要下载的
    JhtFileModel *fileModel = [[JhtFileModel alloc] init];
    
    if ([self.titleStr isEqualToString:@"婚礼致辞稿"]) {
        
        fileModel.fileId =[_zhiciArray[indexPath.row]objectForKey:@"fileName"];
        // **后缀就是文件格式，切记**
        fileModel.fileName = [_zhiciArray[indexPath.row]objectForKey:@"fileName"];
        fileModel.viewFileType = Type_Docx;
        
        //    fileModel.fileName = @"哈哈哈.docx";
        //    fileModel.viewFileType = Type_Docx;
        //    fileModel.url = @"http://mexue-inform-file.oss-cn-beijing.aliyuncs.com/577e2300c94f6e51316a299d";
        //    fileModel.fileSize = @"21.39KB";
        //汉字连接网址格式化处理
        NSString *encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)[_zhiciArray[indexPath.row]objectForKey:@"fileUrl"],
                                                                  (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                  NULL,
                                                                  kCFStringEncodingUTF8));
        
        //    NSURL *url = [NSURL URLWithString:encodedString];
        fileModel.url = encodedString;
        //        fileModel.url = @"http://osyeryz0j.bkt.clouddn.com/jht-hljf-text/IPHONE%E6%89%8B%E6%9C%BAVPN%E9%85%8D%E7%BD%AE%E6%8C%87%E5%AF%BC.pdf";
        fileModel.fileSize = @"";
        fileModel.attachmentFileSize = @"";
    }else if ([self.titleStr isEqualToString:@"婚礼风俗"]){
        fileModel.fileId =[_fengsuArray[indexPath.row]objectForKey:@"fileName"];
        // **后缀就是文件格式，切记**
        fileModel.fileName = [_fengsuArray[indexPath.row]objectForKey:@"fileName"];
        fileModel.viewFileType = Type_Docx;

        //汉字连接网址格式化处理
        NSString *encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)[_fengsuArray[indexPath.row]objectForKey:@"fileUrl"],
                                                                  (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                  NULL,
                                                                  kCFStringEncodingUTF8));
        
        //    NSURL *url = [NSURL URLWithString:encodedString];
        fileModel.url = encodedString;
        fileModel.fileSize = @"";
        fileModel.attachmentFileSize = @"";
    }else{
        fileModel.fileId =[_bibeiArray[indexPath.row]objectForKey:@"fileName"];
        // **后缀就是文件格式，切记**
        fileModel.fileName = [_bibeiArray[indexPath.row]objectForKey:@"fileName"];
        fileModel.viewFileType = Type_Docx;

        //汉字连接网址格式化处理
        NSString *encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)[_bibeiArray[indexPath.row]objectForKey:@"fileUrl"],
                                                                  (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                  NULL,
                                                                  kCFStringEncodingUTF8));
        
        //    NSURL *url = [NSURL URLWithString:encodedString];
        fileModel.url = encodedString;
        fileModel.fileSize = @"";
        fileModel.attachmentFileSize = @"";
    }

  
  
    LoadDocViewController *load = [[LoadDocViewController alloc] init];
    JhtFileModel *model = fileModel;
    load.titleStr = model.fileName;
    load.currentFileModel = model;
    
    [self.navigationController pushViewController:load animated:YES];
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
