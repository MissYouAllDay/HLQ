//
//  YPMeAddYanHuiTingController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeAddYanHuiTingController.h"
#pragma mark - Cell
#import "YPSupplierInfoInputCell.h"
#import "YPMeAddYanHuiTingWHCell.h"
#import "YPMeAddYanHuiTingTableCountCell.h"
#pragma mark - VC

#pragma mark - Model

///18-08-30 上传封面
#import "HXPhotoView.h"
#import "HXPhotoPicker.h"
#import "BANetManager.h"
#import "HXPhotoTools.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface YPMeAddYanHuiTingController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,HXPhotoViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) HXPhotoView *onePhotoView;
@property (strong, nonatomic) HXPhotoManager *oneManager;
@property (strong, nonatomic) HXPhotoView *twoPhotoView;
@property (strong, nonatomic) HXPhotoManager *twoManager;

@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;

@end

@implementation YPMeAddYanHuiTingController{
    UIView *_navView;
    
//    NSString *upFMString;//添加网络请求封面字段
    NSString *upXCString;//添加相册网络请求字段
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
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(16);
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).mas_offset(15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"添加宴会厅";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"保存" forState:UIControlStateNormal];
    [moreBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = kFont(16);
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //基本信息
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3){
            YPSupplierInfoInputCell *cell = [YPSupplierInfoInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"名称";
                cell.inputTF.placeholder = @"请输入宴会厅名称";
                cell.inputTF.enabled = YES;
                self.nameTF = cell.inputTF;
            }else if (indexPath.row == 1) {
                cell.nameLabel.text = @"面积";
                cell.inputTF.placeholder = @"0.0 ㎡";
                cell.inputTF.enabled = YES;
                self.mianjiTF = cell.inputTF;
            }else if (indexPath.row == 3) {
                cell.nameLabel.text = @"层高";
                cell.inputTF.placeholder = @"0.0 m";
                cell.inputTF.enabled = YES;
                self.cenggaoTF = cell.inputTF;
            }
            return cell;
        }else if (indexPath.row == 2){
            YPMeAddYanHuiTingWHCell *cell = [YPMeAddYanHuiTingWHCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.lengthTF = cell.lengthTF;
            self.widthTF = cell.widthTF;
            return cell;
        }else if (indexPath.row == 4){
            YPMeAddYanHuiTingTableCountCell *cell = [YPMeAddYanHuiTingTableCountCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.tableMinTF = cell.minTF;
            self.tableMaxTF = cell.maxTF;
            return cell;
        }
    //添加封面图 -- 18-11-19 去掉,直接用详情图的第一张为封面-窦 添加宴会厅图片
    }else if (indexPath.section == 1){

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (!self.onePhotoView) {
            self.onePhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 20, self.view.frame.size.width - kPhotoViewMargin * 2, 200) WithManager:self.oneManager];
        }
        self.onePhotoView.delegate = self;
        self.onePhotoView.backgroundColor = WhiteColor;
        self.oneManager.configuration.photoMaxNum = 50;//本质不限制张数

        self.oneManager.localImageList = self.upfmArray;

        [self.onePhotoView refreshView];

        [cell.contentView addSubview:self.onePhotoView];

        return cell;
//    //添加宴会厅图片
//    }else if (indexPath.section == 1){
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]init];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        if (!self.twoPhotoView) {
//            self.twoPhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 20, self.view.frame.size.width - kPhotoViewMargin * 2, 200) WithManager:self.twoManager];
//        }
//        self.twoPhotoView.delegate = self;
//        self.twoPhotoView.backgroundColor = WhiteColor;
//        self.twoManager.configuration.photoMaxNum = 20;
//        
//        self.twoManager.localImageList = self.upXCArray;
//        
//        [self.twoPhotoView refreshView];
//        
//        [cell.contentView addSubview:self.twoPhotoView];
//        
//        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 55;
    }else if (indexPath.section == 1){
        return self.onePhotoView.frame.size.height+40;
//    }else{
//        return self.twoPhotoView.frame.size.height+40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 60;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        
        UIView *line = [UIView new];
        line.backgroundColor = CHJ_bgColor;
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(view);
            make.height.mas_equalTo(14);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        if (section == 1) {
//            label.text = @"添加封面图";
//        }else if (section == 2){
            label.text = @"添加宴会厅图片";
        }
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).mas_offset(16);
            make.left.mas_equalTo(18);
        }];
        
        UIView *line1 = [UIView new];
        line1.backgroundColor = CHJ_bgColor;
        [view addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(view);
            make.height.mas_equalTo(1);
        }];
        
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    [self uploadSelectImageRequest];//上传封面图
}

#pragma mark - getter
- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)oneManager {
    if (!_oneManager) {
        _oneManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _oneManager;
}

- (HXPhotoManager *)twoManager {
    if (!_twoManager) {
        _twoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _twoManager;
}

- (NSMutableArray *)upfmArray{
    if (!_upfmArray) {
        _upfmArray =[NSMutableArray array];
    }
    return _upfmArray;
}

//- (NSMutableArray *)upXCArray{
//    if (!_upXCArray) {
//        _upXCArray =[NSMutableArray array];
//    }
//    return _upXCArray;
//}

#pragma mark - HXPhotoViewDelegate
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    if (self.onePhotoView == photoView) {//相册选择器
        
        [self.upfmArray removeAllObjects];

        __weak typeof(self) weakSelf = self;
        [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
            for (int i=0; i<imageList.count; i++) {
                [self.upfmArray addObject:imageList[i]];
            }
        } failed:^{
            
        }];
        
    }
//    else if (self.twoPhotoView == photoView) {//相册选择器
//        
//        [self.upXCArray removeAllObjects];
//        __weak typeof(self) weakSelf = self;
//        [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
//            for (int i=0; i<imageList.count; i++) {
//                [self.upXCArray addObject:imageList[i]];
//            }
//        } failed:^{
//            
//        }];
//        
//    }
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    if (self.onePhotoView == photoView) {
        [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
//    else if (self.twoPhotoView == photoView){
//        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
}

#pragma mark - 网络请求
#pragma mark 上传相册
- (void)uploadSelectImageRequest{
    [EasyShowLodingView showLoding];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:@"0" forKey:@"ot"];
    [dict setValue:UserId_New forKey:@"oi"];
    [dict setValue:@"2" forKey:@"t"];
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = dict;
    imageEntity.imageArray = self.upfmArray;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"相册返回：====%@",response);
        upXCString =[response objectForKey:@"Inform"];
        [self AddBanquetHallInfo];
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark 添加厅信息
- (void)AddBanquetHallInfo{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddBanquetHallInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"BanquetHallName"] = self.nameTF.text;
    params[@"MaxTableCount"] = self.tableMaxTF.text;
    params[@"MinTableCount"] = self.tableMinTF.text;
    params[@"FloorPrice"] = @"";
    params[@"TypeQuestion"] = upXCString;//图片
    params[@"Acreage"] = self.mianjiTF.text;
    params[@"Length"] = self.lengthTF.text;
    params[@"Width"] = self.widthTF.text;
    params[@"Height"] = self.cenggaoTF.text;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"发布成功!" inView:self.view];
            [self performSelector:@selector(backVC) withObject:nil afterDelay:1];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
