//
//  YPWedPackageDetailPhotoController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageDetailPhotoController.h"
#import "YPWedPackageDetailYuLanCell.h"
#import "YPWedPackageDetailPhotoListCell.h"

@interface YPWedPackageDetailPhotoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPWedPackageDetailPhotoController{
    UIView *_navView;
    ///NO:小 YES:大
    BOOL _showType;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UIButton *changeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setImage:[UIImage imageNamed:@"change_list"] forState:UIControlStateNormal];
    [changeBtn setImage:[UIImage imageNamed:@"change_col"] forState:UIControlStateSelected];
    _showType = changeBtn.selected;
    [changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.imgArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_showType) {//大
        YPGetWeddingPackageAreaImg *imgModel = self.imgArr[section];
        return imgModel.ImageData.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_showType) {//大
        
        YPGetWeddingPackageAreaImg *imgModel = self.imgArr[indexPath.section];
        YPGetWeddingPackageAreaImgData *imgData = imgModel.ImageData[indexPath.row];
        
        YPWedPackageDetailPhotoListCell *cell = [YPWedPackageDetailPhotoListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.imgStr = imgData.Image;
        return cell;
    }else{
        
        YPGetWeddingPackageAreaImg *imgModel = self.imgArr[indexPath.section];
        
        YPWedPackageDetailYuLanCell *cell = [YPWedPackageDetailYuLanCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (imgModel.AreaName.length > 0) {
            cell.titleLabel.text = imgModel.AreaName;
        }else{
            cell.titleLabel.text = @"无标题";
        }
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < imgModel.ImageData.count; i ++) {
            YPGetWeddingPackageAreaImgData *data = imgModel.ImageData[i];
            [marr addObject:data.Image];
        }
        cell.imgArr = marr.copy;
        
//        if (indexPath.row == 0) {
//            cell.titleLabel.text = @"主舞台";
//            cell.imgArr = @[@"http://121.42.156.151:96/2/1/13472/2/3/e74794eb-284c-4d52-8274-591c071430f6.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/c5dbb4e0-9089-460d-84af-8d093760d7c7.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/85eccbf7-308d-4add-b847-2cbd4ebc90f5.jpg",@"http://121.42.156.151:96/2/1/13472/2/3/e74794eb-284c-4d52-8274-591c071430f6.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/c5dbb4e0-9089-460d-84af-8d093760d7c7.jpg"];
//        }else if (indexPath.row == 1){
//            cell.titleLabel.text = @"迎宾通道";
//            cell.imgArr = @[@"http://121.42.156.151:96/2/1/13472/2/3/e74794eb-284c-4d52-8274-591c071430f6.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/c5dbb4e0-9089-460d-84af-8d093760d7c7.jpg"];
//        }else if (indexPath.row == 2){
//            cell.titleLabel.text = @"签到区";
//            cell.imgArr = @[@"http://121.42.156.151:96/2/1/13472/2/3/e74794eb-284c-4d52-8274-591c071430f6.jpg"];
//        }else if (indexPath.row == 3){
//            cell.titleLabel.text = @"迎宾区";
//            cell.imgArr = @[@"http://121.42.156.151:96/2/1/13472/2/3/e74794eb-284c-4d52-8274-591c071430f6.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/c5dbb4e0-9089-460d-84af-8d093760d7c7.jpg",@"http://121.42.156.151:96/2/1/100001/2/3/85eccbf7-308d-4add-b847-2cbd4ebc90f5.jpg"];
//        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_showType) {//大
        return 50;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_showType) {//大
        
        YPGetWeddingPackageAreaImg *imgModel = self.imgArr[section];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = GrayColor;
        
        if (imgModel.AreaName.length > 0) {
            label.text = imgModel.AreaName;
        }else{
            label.text = @"无标题";
        }
        
//        if (section == 0) {
//            label.text = @"主舞台";
//        }else if (section == 1){
//            label.text = @"迎宾通道";
//        }else if (section == 2){
//            label.text = @"签到区";
//        }else if (section == 3){
//            label.text = @"迎宾区";
//        }
        
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(18);
        }];
        
        return view;
    }else{
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    _showType = sender.selected;
    
    [self.tableView reloadData];
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
