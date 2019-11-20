//
//  YPSupplierPersonInfoController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//
/** 除 车手/用户 外的供应商 */

#import "YPSupplierPersonInfoController.h"
#pragma mark - Cell
#import "YPSupplierInfoInputCell.h"
#import "YPSupplierInfoRemarkCell.h"//简介
#import "YPSupplierInfoAddBaseYouhuiCell.h"
#import "YPSupplierInfoCanBiaoFirstInputCell.h"
#import "YPSupplierInfoCanBiaoOtherInputCell.h"
#import "YPHotelInfoIconCell.h"//添加头像
#pragma mark - VC
#import "YPAddRemarkController.h"
#import "YPSupplierInfoBaseYouhuiController.h"//基础优惠
#pragma mark - Model
#import "YPGetUserInfo.h"
#import "YPGetSupplierInfo.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
#import "YPGetAllOccupationList.h"//比较职业
#import "YPGetFacilitatorInfo.h"

///18-08-30 上传封面
#import "HXPhotoView.h"
#import "HXPhotoPicker.h"
#import "BANetManager.h"
#import "HXPhotoTools.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface YPSupplierPersonInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YPAddRemarkDelegate,UIActionSheetDelegate,CJAreaPickerDelegate,HXPhotoViewDelegate,UIAlertViewDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//基本信息
/**昵称*/
@property (nonatomic, strong) UITextField *nameTF;
/**手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**所在地*/
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, copy) NSString *address;

//店铺简介
/**简介*/
@property (nonatomic, copy) NSString *jianjie;

//酒店信息
/**存储餐标数组*/
@property (nonatomic, strong) __block NSMutableArray *lowestCanBiaoMarr;
/**服务费*/
@property (nonatomic, strong) UITextField *serveTF;

/**头像*/
@property (nonatomic, strong) NSMutableArray *headImgs;
@property (nonatomic, copy) NSString *headImgID;

@property (nonatomic, strong) __block YPGetFacilitatorInfo *infoModel;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger  parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

/************************封面图上传****************************/
@property (strong, nonatomic) NSMutableArray *upXCArray;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXPhotoManager *photoManager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
/************************封面图上传****************************/

@end

@implementation YPSupplierPersonInfoController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
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
    
    [self GetFacilitatorInfo];
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
    titleLab.text = @"编辑商家资料";
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
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
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
    if (JiuDian(Profession_New)) {
        return 6;
    }else{
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (JiuDian(Profession_New)) {
        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return 4;
        }else if (section == 3){
            return self.lowestCanBiaoMarr.count > 0 ? self.lowestCanBiaoMarr.count+1 : 2;
        }else if (section == 4){
            return 2;
        }else{
            return 1;
        }
    }else{
        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return 4;
        }else{
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YPHotelInfoIconCell *cell = [YPHotelInfoIconCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.changeBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        if (self.headImgs.count > 0) {
            [cell.iconImgV setImage:self.headImgs[0]];
        }else{
            [cell.iconImgV setImage:[UIImage imageNamed:@"图片占位"]];
        }
        return cell;
    }else if (indexPath.section == 1) {
        //基本信息
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            YPSupplierInfoInputCell *cell = [YPSupplierInfoInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"昵称";
                cell.inputTF.placeholder = @"请输入昵称(必填)";
                cell.inputTF.enabled = YES;
                self.nameTF = cell.inputTF;
//                if (self.infoModel.Name.length > 0) {
//                    cell.inputTF.text = self.infoModel.Name;
//                }
            }else if (indexPath.row == 1) {
                cell.nameLabel.text = @"手机";
                cell.inputTF.placeholder = @"请输入手机号(必填)";
                cell.inputTF.enabled = YES;
                self.phoneTF = cell.inputTF;
//                if (self.infoModel.Phone.length > 0) {
//                    cell.inputTF.text = self.infoModel.Phone;
//                }
            }else if (indexPath.row == 2) {
                cell.nameLabel.text = @"所在地";
                cell.inputTF.placeholder = @"请选择所在地(必填)";
                cell.inputTF.enabled = NO;
                if (self.areaid.length > 0 || self.cityInfo.length > 0) {
                    cell.inputTF.text = self.cityInfo;
                }
            }else if (indexPath.row == 3) {
                cell.nameLabel.text = @"详细地址";
                cell.inputTF.placeholder = @"请输入详细地址(必填)";
                cell.inputTF.enabled = YES;
                self.addressTF = cell.inputTF;
//                if (self.infoModel.Address.length > 0) {
//                    cell.inputTF.text = self.infoModel.Address;
//                }
            }
            return cell;
        }
    //店铺简介
    }else if (indexPath.section == 2){
        YPSupplierInfoRemarkCell *cell = [YPSupplierInfoRemarkCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.jianjie.length > 0) {
            cell.remark.text = self.jianjie;
            cell.remark.textColor = RGBS(51);
        }else{
            cell.remark.text = @"添加店铺描述，让客户对您的服务有更深的了解(必填)";
            cell.remark.textColor = RGBA(221, 221, 221, 1);
        }
        return cell;
    }
    
    if (JiuDian(Profession_New)) {
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                YPSupplierInfoCanBiaoFirstInputCell *cell = [YPSupplierInfoCanBiaoFirstInputCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text = @"最低餐标";
                cell.inputTF.placeholder = @"请输入客户最低消费餐标";
                cell.inputTF.enabled = NO;
                NSString *str = self.lowestCanBiaoMarr.count > 0 ? self.lowestCanBiaoMarr[indexPath.row] : @"";
                if (str > 0) {
                    cell.inputTF.text = str;
                }
                cell.deleteBtn.tag = indexPath.row + 1000;
                [cell.deleteBtn addTarget:self action:@selector(canbiaoDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            if (self.lowestCanBiaoMarr.count > 0) {
                if (indexPath.row == self.lowestCanBiaoMarr.count){//最后一行
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIButton *addBtn = [[UIButton alloc]init];
                    [addBtn setTitle:@"继续添加" forState:UIControlStateNormal];
                    [addBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
                    addBtn.titleLabel.font = kFont(14);
                    [addBtn addTarget:self action:@selector(canbiaoAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:addBtn];
                    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(cell.contentView);
                        make.left.mas_equalTo(104);
                    }];
                    UIView *line = [[UIView alloc]init];
                    line.backgroundColor = RGBS(230);
                    [cell.contentView addSubview:line];
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(18);
                        make.right.bottom.mas_equalTo(cell.contentView);
                        make.height.mas_equalTo(1);
                    }];
                    return cell;
                }else{
                    YPSupplierInfoCanBiaoOtherInputCell *cell = [YPSupplierInfoCanBiaoOtherInputCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    NSString *str = self.lowestCanBiaoMarr[indexPath.row];
                    if (str > 0) {
                        cell.inputTF.text = str;
                    }
                    cell.inputTF.placeholder = @"请输入客户最低消费餐标";
                    cell.inputTF.enabled = NO;
                    cell.inputTF.tag = indexPath.row + 2000;
                    cell.deleteBtn.tag = indexPath.row + 1000;
                    [cell.deleteBtn addTarget:self action:@selector(canbiaoDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }
            }else{
                if (indexPath.row == 1){//没有数据时 最后一行
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIButton *addBtn = [[UIButton alloc]init];
                    [addBtn setTitle:@"继续添加" forState:UIControlStateNormal];
                    [addBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
                    addBtn.titleLabel.font = kFont(14);
                    [addBtn addTarget:self action:@selector(canbiaoAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:addBtn];
                    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(cell.contentView);
                        make.left.mas_equalTo(104);
                    }];
                    UIView *line = [[UIView alloc]init];
                    line.backgroundColor = RGBS(230);
                    [cell.contentView addSubview:line];
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(18);
                        make.right.bottom.mas_equalTo(cell.contentView);
                        make.height.mas_equalTo(1);
                    }];
                    return cell;
                }else{
                    YPSupplierInfoCanBiaoOtherInputCell *cell = [YPSupplierInfoCanBiaoOtherInputCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    NSString *str = self.lowestCanBiaoMarr[indexPath.row];
                    if (str > 0) {
                        cell.inputTF.text = str;
                    }
                    cell.inputTF.placeholder = @"请输入客户最低消费餐标";
                    cell.inputTF.enabled = NO;
                    cell.inputTF.tag = indexPath.row + 2000;
                    cell.deleteBtn.tag = indexPath.row + 1000;
                    [cell.deleteBtn addTarget:self action:@selector(canbiaoDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }
            }
            
        }else if (indexPath.section == 4){
            if (indexPath.row == 0) {
                YPSupplierInfoInputCell *cell = [YPSupplierInfoInputCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text = @"服务费";
                cell.inputTF.placeholder = @"请输入服务费比例";
                cell.inputTF.enabled = YES;
                self.serveTF = cell.inputTF;
                if (self.infoModel.ServiceCharge.length > 0) {
                    cell.inputTF.text = self.infoModel.ServiceCharge;
                }
                return cell;
            }else if (indexPath.row == 1) {
                YPSupplierInfoAddBaseYouhuiCell *cell = [YPSupplierInfoAddBaseYouhuiCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.countLabel.text = [NSString stringWithFormat:@"当前%zd条优惠",self.infoModel.BasicPreferencesCount.integerValue];
                return cell;
            }
        }else if (indexPath.section == 5){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!self.photoView) {
                self.photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 0, self.view.frame.size.width - kPhotoViewMargin * 2, 200) WithManager:self.photoManager];
            }
            self.photoView.delegate = self;
            self.photoView.backgroundColor = WhiteColor;
            self.photoManager.configuration.photoMaxNum = 50;
            
            [self.photoView refreshView];
            
            [cell.contentView addSubview:self.photoView];
            
            return cell;
        }
    }else{//非酒店
        if (indexPath.section == 3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!self.photoView) {
                self.photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 0, self.view.frame.size.width - kPhotoViewMargin * 2, 200) WithManager:self.photoManager];
            }
            self.photoView.delegate = self;
            self.photoView.backgroundColor = WhiteColor;
            self.photoManager.configuration.photoMaxNum = 50;
            
            [self.photoView refreshView];
            
            [cell.contentView addSubview:self.photoView];
            
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 190;
    }else if (indexPath.section == 1) {
        return 55;
    }else if (indexPath.section == 2){
        return self.jianjie.length > 0 ? [self getHeighWithTitle:self.jianjie font:[UIFont fontWithName:@"PingFangSC-Regular" size:13] width:(ScreenWidth-36)]+32 : [self getHeighWithTitle:@"添加店铺描述，让客户对您的服务有更深的了解" font:[UIFont fontWithName:@"PingFangSC-Regular" size:13] width:ScreenWidth-36]+32;
    }
    
    if (JiuDian(Profession_New)) {
        if (indexPath.section == 3) {
            return 55;
        }else if (indexPath.section == 4){
            return 55;
        }else {
            return self.photoView.frame.size.height;
        }
    }else{
        if (indexPath.section == 3) {
            return self.photoView.frame.size.height;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (JiuDian(Profession_New)) {
        if (section == 4) {
            return 0.1;
        }
    }
    if (section == 0) {
        return 0.1;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
    if (section == 0) {
        return nil;
    }else if (section == 1) {
        label.text = @"基本信息";
    }else if (section == 2){
        label.text = @"店铺简介";
    }else if (section == 3){
        if (JiuDian(Profession_New)) {
            label.text = @"酒店信息(非必填)";
        }else{
            label.text = @"添加封面图";
        }
    }else if (section == 4){
        if (JiuDian(Profession_New)) {
            return nil;
        }else{
            label.text = @"添加封面图";
        }
    }else{
        label.text = @"添加封面图";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.remarkDelegate = self;
        
        addRemark.titleStr = @"修改简介";
        addRemark.placeHolder = @"请修改简介";
        addRemark.limitCount = 200;
        addRemark.editRemark =self.jianjie;
        [self.navigationController pushViewController:addRemark animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
            
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];

    }
    if (JiuDian(Profession_New)) {
        if (indexPath.section == 3) {
            if (self.lowestCanBiaoMarr.count > 0) {
                if (indexPath.row != self.lowestCanBiaoMarr.count) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改最低餐标" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = 2000+indexPath.row;
                    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                    UITextField *txtName = [alert textFieldAtIndex:0];
                    txtName.text = self.lowestCanBiaoMarr[indexPath.row];
                    [alert show];
                }
            }else{//没有数据时 点击第一行 添加
                if (indexPath.row == 0) {
                    [self canbiaoAddBtnClick];
                }
            }
        }
        
        if (indexPath.section == 4 && indexPath.row == 1){
            YPSupplierInfoBaseYouhuiController *base = [[YPSupplierInfoBaseYouhuiController alloc]init];
            base.baseCountBlock = ^(NSInteger recordCount) {
                self.infoModel.BasicPreferencesCount = [NSString stringWithFormat:@"%zd",recordCount];
                [self.tableView reloadRow:1 inSection:4 withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [self.navigationController pushViewController:base animated:YES];
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 1000) {//添加
        UITextField *tf = [alertView textFieldAtIndex:0];
        if (tf.text.length > 0) {
            [self.lowestCanBiaoMarr addObject:tf.text];
            [self.tableView reloadSection:3 withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [EasyShowTextView showText:@"请输入最低餐标" inView:self.tableView];
        }
    }
    if (buttonIndex == 1 && alertView.tag != 1000) {//修改
        UITextField *tf = [alertView textFieldAtIndex:0];
        if (tf.text.length > 0) {
            [self.lowestCanBiaoMarr replaceObjectAtIndex:alertView.tag-2000 withObject:tf.text];
            [self.tableView reloadSection:3 withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [EasyShowTextView showText:@"请输入最低餐标" inView:self.tableView];
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    if (self.upXCArray.count == 0) {
        [EasyShowTextView showText:@"请至少上传一张封面图" inView:self.tableView];
    }else if (self.nameTF.text.length == 0){
        [EasyShowTextView showText:@"请填写昵称" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请填写手机号" inView:self.tableView];
    }else if (self.addressTF.text.length == 0){
        [EasyShowTextView showText:@"请填写详细地址" inView:self.tableView];
    }else if (self.jianjie.length == 0){
        [EasyShowTextView showText:@"请填写简介" inView:self.tableView];
    }else if (self.headImgs.count == 0){
        [EasyShowTextView showText:@"请上传头像" inView:self.tableView];
    }else{
        [self uploadIconImgRequest];//上传头像
    }
}

- (void)canbiaoAddBtnClick{
    NSLog(@"canbiaoAddBtnClick");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加最低餐标" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    txtName.placeholder = @"请输入最低餐标";
    [alert show];
}

- (void)canbiaoDeleteBtnClick:(UIButton *)sender{
    NSLog(@"canbiaoDeleteBtnClick");
    if (self.lowestCanBiaoMarr.count > 0) {
        [self.lowestCanBiaoMarr removeObjectAtIndex:sender.tag-1000];
        [self.tableView reloadSection:3 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)addImgBtnClick:(UIButton *)sender{
    //添加图片
    [self takePhoto:sender];
}

#pragma mark - TakePhoto
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    [self.upXCArray removeAllObjects];

    __weak typeof(self) weakSelf = self;
    [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
        for (int i=0; i<imageList.count; i++) {
            [self.upXCArray addObject:imageList[i]];
        }
    } failed:^{
        
    }];
    
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {

    if (self.photoView == photoView) {

        self.photoView.frame = CGRectMake(kPhotoViewMargin,0, self.view.frame.size.width - kPhotoViewMargin * 2, self.photoView.frame.size.height);
        if (JiuDian(Profession_New)) {
            [self.tableView reloadSection:5 withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [self.tableView reloadSection:3 withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }

}

#pragma mark - 头像TakePhoto
- (void)takePhoto:(UIButton *)sender {
    
    NSLog(@"takephoto");
    UIActionSheet *actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionsheet.tag = sender.tag;
    [actionsheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        [self.headImgs removeAllObjects];
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
        [self.headImgs removeAllObjects];
        [self LocalPhotoWithTag:actionSheet.tag];
    }
    
}

- (void)openCameraWithTag:(NSInteger)tag{
    
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    
    // 拍照最多个数
    cameraVc.maxCount = 1-self.headImgs.count;
    
    cameraVc.callback = ^(NSArray *cameras){
        
        //如果之前存有照片 清空
        if (self.headImgs.count > 0) {
            [self.headImgs removeAllObjects];
        }
        
        for (int i=0; i<cameras.count; i++) {
            ZLCamera *camera  =[cameras objectAtIndex:i];
            UIImage *image = camera.thumbImage;
            [self.headImgs addObject:image];
            if (self.headImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
            [self.tableView reloadData];
        }
    };
    
    [cameraVc showPickerVc:self];
}

- (void)LocalPhotoWithTag:(NSInteger)tag{
    
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 1 - self.headImgs.count;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}

// 代理回调方法
#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //    _lastSelectedAssets=assets;
    for (int i=0; i<assets.count; i++) {
        ZLPhotoAssets *camera  =[assets objectAtIndex:i];
        UIImage *image = camera.originImage;
        [self.headImgs addObject:image];
        
        //获取图片的ID
        //        self.iconImgID = [Upload getUUID];
        
        if (self.headImgs.count > 1) {
            Alertmsg(@"不能超过1张", nil);
            break;
        }
    }
    [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//图片浏览器
-(void)showPhotoBrowser:(NSMutableArray *)imgsMarr{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 图片游览器
    
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    NSMutableArray *photos = [[NSMutableArray alloc]initWithCapacity:imgsMarr.count];
    for (int i = 0; i < imgsMarr.count; i ++) {
        ZLPhotoPickerBrowserPhoto *photo=[ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:[imgsMarr objectAtIndex:i]];
        [photos addObject:photo];
        
    }
    pickerBrowser.photos = photos;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndexPath = indexPath;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"走方法");
    if (self.headImgs.count >indexPath.row) {
        [self.headImgs removeObjectAtIndex:indexPath.row];
    }
    [self.tableView reloadData];
}

#pragma mark - YPAddRemarkDelegate
- (void)supplierPersonInfoIntro:(NSString *)intro{
    self.jianjie = intro;
    if (intro.length > 0) {
        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{

    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self selectDataBase];

}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];

    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);

    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }

}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];

    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");

    }else{
        NSLog(@"打开数据库成功");
    }

}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];

        //6-5
//        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
//        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];

    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);

}

#pragma mark - 网络请求
#pragma mark - 上传头像
-(void)uploadIconImgRequest{
    
    [EasyShowLodingView showLoding];
    
    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
    [fmdict setValue:@"2" forKey:@"os"];//0惠约、1汇码、2婚庆、3减肥
    [fmdict setValue:@"0" forKey:@"ot"];//0用户图、1公司、2平台
    [fmdict setValue:UserId_New forKey:@"oi"];
    [fmdict setValue:@"2" forKey:@"t"];//用户：1认证相关、2功能相关、3其他
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = fmdict;
    imageEntity.imageArray = self.headImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        
        NSLog(@"个人资料 返回：====%@",response);
        self.headImgID = [response objectForKey:@"Inform"];
        [self uploadSelectImageRequest];
        
    } failurBlock:^(NSError *error) {
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
    
}
#pragma mark 上传图片
-(void)uploadSelectImageRequest{

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
    imageEntity.imageArray = self.upXCArray;
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
        
        [self UpdateFacilitatorInfo];
        
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark 供应商信息
- (void)GetFacilitatorInfo{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFacilitatorInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.infoModel.Id = [object objectForKey:@"Id"];
            self.infoModel.UserId = [object objectForKey:@"UserId"];
            self.infoModel.Name = [object objectForKey:@"Name"];
            self.infoModel.Logo = [object objectForKey:@"Logo"];
            self.infoModel.Phone = [object objectForKey:@"Phone"];
            self.infoModel.Address = [object objectForKey:@"Address"];
            self.infoModel.Abstract = [object objectForKey:@"Abstract"];
            
            self.infoModel.Identity = [object objectForKey:@"Identity"];
            self.infoModel.region = [object objectForKey:@"region"];
            self.infoModel.regionname = [object objectForKey:@"regionname"];
            
            self.nameTF.text = self.infoModel.Name;
            self.areaid = self.infoModel.region;
            self.jianjie = self.infoModel.Abstract;
            self.phoneTF.text = self.infoModel.Phone;
            self.address = self.infoModel.Address;
            self.addressTF.text = self.infoModel.Address;
            
            //6-5
            self.cityInfo = self.infoModel.regionname;

            //18-11-19 图片
            self.infoModel.Data = [YPGetFacilitatorInfoImgData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            self.infoModel.BasicPreferencesCount = [object valueForKey:@"BasicPreferencesCount"];

            //18-11-16
            self.infoModel.MealMark = [object objectForKey:@"MealMark"];
            self.lowestCanBiaoMarr = [self.infoModel.MealMark componentsSeparatedByString:@","].mutableCopy;
            self.infoModel.ServiceCharge = [object objectForKey:@"ServiceCharge"];
            self.serveTF.text = self.infoModel.ServiceCharge;
            
            [self.upXCArray removeAllObjects];
            self.photoView.manager.localImageList = nil;
            self.photoManager.localImageList = nil;
            
            //头像
            if (self.infoModel.Logo.length > 0) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.infoModel.Logo]];
                UIImage *img = [UIImage imageWithData:data];
                if (img) {
                    [self.headImgs removeAllObjects];//移除前一个图片 否则保存两张
                    [self.headImgs addObject:img];
                }
            }
            
            if (self.infoModel.Data.count > 0) {//有图
                NSMutableArray *xiangcearr = [NSMutableArray array];
                
                NSArray *array = self.infoModel.Data;
                for (YPGetFacilitatorInfoImgData *data in array) {
                    NSData* imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:data.ImgUrl]];
                    UIImage* resultImage2 = [UIImage imageWithData: imageData2];
                    [xiangcearr addObject:resultImage2];
                }
                
                self.upXCArray = xiangcearr;
                //18-11-22 每次相册赋值 不能在cell中赋值
                self.photoManager.localImageList = self.upXCArray;
            }
            
            [self.tableView reloadData];
            
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

#pragma mark 完善服务商信息
- (void)UpdateFacilitatorInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdateFacilitatorInfo";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"Id"] = FacilitatorId_New;
    if (self.phoneTF.text.length > 0) {
        params[@"Phone"] = self.phoneTF.text;
    }else{
        params[@"Phone"] = @"";
    }
    if (self.areaid.length > 0) {
        params[@"AreaId"] = self.areaid;
    }else{
        params[@"AreaId"] = areaID_New;
    }
    if (self.jianjie.length > 0) {
        params[@"Abstract"] = self.jianjie;
    }else{
        params[@"Abstract"] = @"";
    }
    params[@"licenseImg"] = @"";
    if (self.addressTF.text.length > 0) {
        params[@"Address"] = self.addressTF.text;
    }else{
        params[@"Address"] = @"";
    }
    params[@"CoverMap"] = upXCString;
    
    //18-11-16 添加
    if (self.lowestCanBiaoMarr.count > 0) {
        params[@"MealMark"] = [self.lowestCanBiaoMarr.copy componentsJoinedByString:@","];
    }else{
        params[@"MealMark"] = @"";
    }
    if (self.serveTF.text.length > 0) {
        params[@"ServiceCharge"] = self.serveTF.text;
    }else{
        params[@"ServiceCharge"] = @"";
    }
    
    //18-11-30
    params[@"HeadImg"] = self.headImgID;
    params[@"Name"] = self.nameTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });

        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            [self UpUserInfo];//供应商修改 分两步 -- 9.15修改为一步
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
//            [self GetFacilitatorInfo];//重新获取数据
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //18-11-06
                if (self.backType == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else if (self.backType == 1){
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
            });
            
            
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
//- (NSMutableArray *)iconImgs{
//    if (!_iconImgs) {
//        _iconImgs = [NSMutableArray array];
//    }
//    return _iconImgs;
//}

- (NSMutableArray *)headImgs{
    if (!_headImgs) {
        _headImgs = [NSMutableArray array];
    }
    return _headImgs;
}

- (YPGetFacilitatorInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetFacilitatorInfo alloc]init];
    }
    return _infoModel;
}

-(NSString *)areaid{
    if (!_areaid) {
        self.areaid =[[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)photoManager{
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _photoManager;
}

- (NSMutableArray *)upXCArray{
    if (!_upXCArray) {
        _upXCArray =[NSMutableArray array];
    }
    return _upXCArray;
}

- (NSMutableArray *)lowestCanBiaoMarr{
    if (!_lowestCanBiaoMarr) {
        _lowestCanBiaoMarr = [NSMutableArray array];
    }
    return _lowestCanBiaoMarr;
}

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
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
