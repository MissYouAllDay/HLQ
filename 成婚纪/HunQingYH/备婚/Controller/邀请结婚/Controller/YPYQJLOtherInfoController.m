//
//  YPYQJLOtherInfoController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPYQJLOtherInfoController.h"
#import "YPFreeWeddingTitleCell.h"
#import "YPFreeWeddingInputCell.h"
#import "YPFreeWeddingRemarkCell.h"
#import "BRDatePickerView.h"
#import "CJAreaPicker.h"//地址选择
#import "YPAddRemarkController.h"//添加备注
#import "YPFreeWeddingProtocolCell.h"

@interface YPYQJLOtherInfoController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,YPAddRemarkDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**姓名*/
@property (nonatomic, copy) NSString *nameStr;
/**手机*/
@property (nonatomic, copy) NSString *phoneStr;
///**新娘姓名*/
//@property (nonatomic, copy) NSString *womanNameStr;
///**新娘手机*/
//@property (nonatomic, copy) NSString *womanPhoneStr;
/**预算*/
@property (nonatomic, copy) NSString *yusuanStr;
/**酒店*/
@property (nonatomic, copy) NSString *hotelStr;
/**地点*/
@property (nonatomic, copy) NSString *addressStr;

/**3-5 添加 好友身份 1.新郎 2.新娘*/
@property (nonatomic, copy) NSString *friendType;
/**3-5 添加 是否酒店预定 1.未预定 2.预定*/
@property (nonatomic, copy) NSString *isAddHotel;
/**3-5 添加 桌数*/
@property (nonatomic, copy) NSString *tableCount;
/**3-5 添加 餐标*/
@property (nonatomic, copy) NSString *mealStandard;
/**3-5 添加 邀请人手机号*/
@property (nonatomic, copy) NSString *inviterPhone;

/**备注*/
@property (nonatomic, copy) NSString *remarkStr;
/**婚期*/
@property (nonatomic, copy) NSString *selectTime;

/**协议按钮*/
@property (nonatomic, strong) UIButton *selectBtn;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPYQJLOtherInfoController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    UIButton *_upBtn;
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

    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"邀请结婚";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //提交  设置导航栏右边
    _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_upBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [_upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_upBtn];
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        //        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.isAddHotel integerValue] == 1) {//未预定
        return 14;
    }else if ([self.isAddHotel integerValue] == 2){//已预订
        return 13;
    }else{
        return 11;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YPFreeWeddingTitleCell *cell = [YPFreeWeddingTitleCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"填写好友信息";
//        cell.descLabel.text = @"新郎、新娘的姓名手机，至少填写一人";
//        cell.descLabel.hidden = YES;
        [cell.descLabel removeFromSuperview];
        return cell;
    }else{
        YPFreeWeddingInputCell *cell = [YPFreeWeddingInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.inputTF.delegate = self;
        cell.inputTF.tag = indexPath.row + 1000;
        
        switch (indexPath.row) {
            case 1:
                cell.inputTF.enabled = NO;
                
                cell.titleLabel.text = @"好友身份";
                cell.inputTF.placeholder = @"请选择好友身份";
                
                if ([self.friendType integerValue] == 2) {//1.新郎 2.新娘
                    cell.inputTF.text = @"新娘";
                }else if([self.friendType integerValue] == 1){
                   cell.inputTF.text = @"新郎";
                }else if ([self.friendType integerValue] == 0){
                    cell.inputTF.text = @"";
                }
                
                break;
            case 2:
                
                cell.inputTF.enabled = YES;

                cell.titleLabel.text = @"好友姓名";
                cell.inputTF.placeholder = @"输入好友姓名";
                
//                if ([self.friendType integerValue] == 2) {//1.新郎 2.新娘
//                    cell.titleLabel.text = @"新娘姓名";
//                    cell.inputTF.placeholder = @"输入新娘姓名";
//                }else if ([self.friendType integerValue] == 1) {
//                    cell.titleLabel.text = @"新郎姓名";
//                    cell.inputTF.placeholder = @"输入新郎姓名";
//                }else{
//                    cell.titleLabel.text = @"新郎/新娘姓名";
//                    cell.inputTF.placeholder = @"输入新郎/新娘姓名";
//                }
                
                if (self.nameStr.length > 0) {
                    cell.inputTF.text = self.nameStr;
                }else{
                    cell.inputTF.text = @"";
                }
                
                break;
                
            case 3:
                
                cell.inputTF.enabled = YES;
                
                cell.titleLabel.text = @"好友手机";
                cell.inputTF.placeholder = @"输入好友手机";
                
//                if ([self.friendType integerValue] == 2) {//1.新郎 2.新娘
//                    cell.titleLabel.text = @"新娘手机";
//                    cell.inputTF.placeholder = @"输入新娘手机";
//                }else if ([self.friendType integerValue] == 1) {
//                    cell.titleLabel.text = @"新郎手机";
//                    cell.inputTF.placeholder = @"输入新郎手机";
//                }else{
//                    cell.titleLabel.text = @"新郎/新娘手机";
//                    cell.inputTF.placeholder = @"输入新郎/新娘手机";
//                }
                
                if (self.phoneStr.length > 0) {
                    cell.inputTF.text = self.phoneStr;
                }else{
                    cell.inputTF.text = @"";
                }
                
                break;
            case 4:
                
                //地区
                cell.titleLabel.text = @"地区";
                cell.inputTF.enabled = NO;
                cell.inputTF.placeholder = @"选择所在地";
                if (self.cityInfo.length > 0 && self.areaid.length > 0) {
                    cell.inputTF.text = self.cityInfo;
                }else{
                    cell.inputTF.text = @"";
                }
                break;
            case 5:
                //婚期
                cell.titleLabel.text = @"婚期 (非必填)";
                cell.inputTF.enabled = NO;
                cell.inputTF.placeholder = @"选择婚期";
                if (self.selectTime.length > 0) {
                    cell.inputTF.text = self.selectTime;
                }else{
                    cell.inputTF.text = @"";
                }
                break;
            case 6:
                cell.titleLabel.text = @"预算 (非必填)";
                cell.inputTF.placeholder = @"输入预算";
                cell.inputTF.enabled = YES;
                cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
                
                if (self.yusuanStr.length > 0) {
                    cell.inputTF.text = self.yusuanStr;
                }else{
                    cell.inputTF.text = @"";
                }
                break;
            case 7:
                cell.titleLabel.text = @"酒店预定 (非必填)";
                cell.inputTF.placeholder = @"是否预定酒店";
                cell.inputTF.enabled = NO;
                
                if ([self.isAddHotel integerValue] == 1) {
                    cell.inputTF.text = @"未预定";
                }else if ([self.isAddHotel integerValue] == 2) {
                    cell.inputTF.text = @"已预订";
                }else{
                    cell.inputTF.text = @"";
                }
                break;
                
            case 8:
                
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    cell.titleLabel.text = @"大概桌数 (非必填)";
                    cell.inputTF.placeholder = @"输入婚宴大概桌数";
                    cell.inputTF.enabled = YES;
                    
                    if (self.tableCount.length > 0) {
                        cell.inputTF.text = self.tableCount;
                    }else{
                        cell.inputTF.text = @"";
                    }
                    
                }else if ([self.isAddHotel integerValue] == 2){//已预订
                    
                    cell.titleLabel.text = @"酒店名称 (非必填)";
                    cell.inputTF.placeholder = @"输入预定酒店名称";
                    cell.inputTF.enabled = YES;
                    
                    if (self.hotelStr.length > 0) {
                        cell.inputTF.text = self.hotelStr;
                    }else{
                        cell.inputTF.text = @"";
                    }
                    
                }else{
                    
                    YPFreeWeddingRemarkCell *cell = [YPFreeWeddingRemarkCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.titleLabel.text = @"备注 (非必填)";
                    [cell.editBtn addTarget:self action:@selector(remarkEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    if (self.remarkStr.length > 0) {
                        cell.contentLabel.text = self.remarkStr;
                        cell.contentLabel.textColor = GrayColor;
                    }else{
                        cell.contentLabel.text = @"输入备注";
                        cell.contentLabel.textColor = LightGrayColor;
                    }
                    return cell;
                }
                break;
                    
            case 9:
                
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    cell.titleLabel.text = @"每桌餐标 (非必填)";
                    cell.inputTF.placeholder = @"输入婚宴每桌消费标准";
                    cell.inputTF.enabled = YES;
                    
                    if (self.tableCount.length > 0) {
                        cell.inputTF.text = self.tableCount;
                    }else{
                        cell.inputTF.text = @"";
                    }
                    
                }else if ([self.isAddHotel integerValue] == 2){//已预订
                    
                    cell.titleLabel.text = @"酒店地址 (非必填)";
                    cell.inputTF.placeholder = @"输入预定酒店地址";
                    cell.inputTF.enabled = YES;
                    
                    if (self.addressStr.length > 0) {
                        cell.inputTF.text = self.addressStr;
                    }else{
                        cell.inputTF.text = @"";
                    }
                    
                }else{
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.textLabel.text = @"请描述新人的爱好, 预算, 性格等等, 您填写的越详细, 就越有助于我们成功签单, 只要签单, 就会获得10%的现金奖励. ";
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.textColor = LightGrayColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }
                
                break;
            case 10:
                    
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.textLabel.text = @"婚礼桥跟各大酒店形成亲密合作伙伴，通过婚礼桥定酒店，不仅优惠更多，而且新娘即可获得来自德国的维可莎美体内衣，打造出最美的新娘。\n1. 凡是宴会满十桌或者婚宴费用满20000元即送德国维可莎vacshaper价值2580元的美体内衣一私人定制版。\n2. 凡是宴会满二十五桌或者费用满50000元即送德国维可莎vacshaper价值6000元的美体内衣一私人定制版。\n3. 凡是宴会满四十桌或者费用满100000元即送德国维可莎vacshaper价值12980元的美体内衣一私人定制版。";
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.textColor = LightGrayColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }else if ([self.isAddHotel integerValue] == 2){//已预订
                    
                    YPFreeWeddingRemarkCell *cell = [YPFreeWeddingRemarkCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.titleLabel.text = @"备注 (非必填)";
                    [cell.editBtn addTarget:self action:@selector(remarkEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    if (self.remarkStr.length > 0) {
                        cell.contentLabel.text = self.remarkStr;
                        cell.contentLabel.textColor = GrayColor;
                    }else{
                        cell.contentLabel.text = @"输入备注";
                        cell.contentLabel.textColor = LightGrayColor;
                    }
                    return cell;
                    
                }else{
                    
                    YPFreeWeddingProtocolCell *cell = [YPFreeWeddingProtocolCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.selectBtn.selected = YES;
                    self.selectBtn = cell.selectBtn;
                    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }
                
                break;
                    
            case 11:
                    
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    YPFreeWeddingRemarkCell *cell = [YPFreeWeddingRemarkCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.titleLabel.text = @"备注 (非必填)";
                    [cell.editBtn addTarget:self action:@selector(remarkEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    if (self.remarkStr.length > 0) {
                        cell.contentLabel.text = self.remarkStr;
                        cell.contentLabel.textColor = GrayColor;
                    }else{
                        cell.contentLabel.text = @"输入备注";
                        cell.contentLabel.textColor = LightGrayColor;
                    }
                    return cell;
                    
                }else if ([self.isAddHotel integerValue] == 2){//已预订
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.textLabel.text = @"请描述新人的爱好, 预算, 性格等等, 您填写的越详细, 就越有助于我们成功签单, 只要签单, 就会获得10%的现金奖励. ";
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.textColor = LightGrayColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }
                break;
                
            case 12:
                    
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]init];
                    }
                    cell.textLabel.text = @"请简要描述您们的爱情故事，爱好，预算，性格等等，您填写的越详细，就越有助于我们我们为您做出更好的策划方案以及婚礼预算，想得到更好的婚礼策划方案，请到“我要出方案”进行填写您的相关资料，完全是免费的哦。";
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.textColor = LightGrayColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }else if ([self.isAddHotel integerValue] == 2){//已预订
                    
                    YPFreeWeddingProtocolCell *cell = [YPFreeWeddingProtocolCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.selectBtn.selected = YES;
                    self.selectBtn = cell.selectBtn;
                    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }
                break;
            case 13:
                    
                if ([self.isAddHotel integerValue] == 1) {//未预定
                    
                    YPFreeWeddingProtocolCell *cell = [YPFreeWeddingProtocolCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.selectBtn.selected = YES;
                    self.selectBtn = cell.selectBtn;
                    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }
                break;
                
            default:
                break;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        //身份
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择好友身份" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新郎",@"新娘", nil];
        sheet.tag = indexPath.row + 1000;
        [sheet showInView:self.view];
        
    }else if (indexPath.row == 5) {
        //婚期
        //3-9 修改
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.selectTime = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
//        [BRDatePickerView showDatePickerWithTitle: dateType: defaultSelValue: minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
//            //[[NSDate currentDateString] substringToIndex:10]
//            self.selectTime = selectValue;
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }];
    }else if (indexPath.row == 4){
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
        
    }else if (indexPath.row == 7){
        //3-5 添加 酒店预定
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择是否已预定酒店" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"已预订",@"未预定", nil];
        sheet.tag = indexPath.row + 1000;
        [sheet showInView:self.view];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)upBtnClick{
    NSLog(@"提交");
    
    if ([self.friendType integerValue] == 0) {
        [EasyShowTextView showText:@"请选择好友身份"];
    }else if (self.nameStr.length == 0){
        [EasyShowTextView showText:@"请输入姓名"];
    }else if (self.phoneStr.length == 0){
        [EasyShowTextView showText:@"请输入手机号"];
    }
//    else if (self.selectTime.length == 0){
//        [EasyShowTextView showText:@"请选择婚期"];
//    }
//    else if (self.yusuanStr.length == 0){
//        [EasyShowTextView showText:@"请输入预算"];
//    }
    else if (self.areaid.length == 0 && self.cityInfo.length == 0){
        [EasyShowTextView showText:@"请选择所在地"];
    }
//    else if (self.hotelStr.length == 0){
//        [EasyShowTextView showText:@"请输入酒店"];
//    }
//    else if (self.addressStr.length == 0){
//        [EasyShowTextView showText:@"请输入酒店地点"];
//    }
    else if (self.selectBtn.isSelected == NO){
        [EasyShowTextView showText:@"同意备婚协议后才可申请"];
    }else{
        [self AddNewInformation];
    }
    
}

- (void)remarkEditBtnClick{
    NSLog(@"remarkEditBtnClick");
    
    YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
    addRemark.remarkDelegate = self;
    addRemark.titleStr = @"添加备注";
    addRemark.placeHolder = @"请添加备注";
    if (self.remarkStr.length > 0) {
        addRemark.editRemark = self.remarkStr;
    }
    addRemark.limitCount = 60;
    [self.navigationController pushViewController:addRemark animated:YES];
}

- (void)selectBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
//    if (!sender.isSelected) {
//        _upBtn.enabled = NO;
//    }else{
//        _upBtn.enabled = YES;
//    }
}

- (void)protocolBtnClick{
    NSLog(@"protocolBtnClick");
    HRWebViewController *webVC =[HRWebViewController new];
    webVC.webUrl =@"http://www.chenghunji.com/Redbag/xieyi";
    webVC.isShareBtn =NO;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1002){//姓名
        if ([self.friendType integerValue] == 0) {
            [EasyShowTextView showText:@"请选择好友身份" inView:self.tableView];
        }else{
            self.nameStr = textField.text;
        }
    }else if (textField.tag == 1003){//手机
        if ([self.friendType integerValue] == 0) {
            [EasyShowTextView showText:@"请选择好友身份" inView:self.tableView];
        }else{
            self.phoneStr = textField.text;
        }
    }else if (textField.tag == 1006){//预算
        self.yusuanStr = textField.text;
    }else if (textField.tag == 1008){
        
        if ([self.isAddHotel integerValue] == 1) {//未预定
            self.tableCount = textField.text;//桌数
        }else if ([self.isAddHotel integerValue] == 2){//已预订
            self.hotelStr = textField.text;//酒店名
        }else{
            self.inviterPhone = textField.text;//邀请人
        }
        
    }else if (textField.tag == 1009){
        
        if ([self.isAddHotel integerValue] == 1) {//未预定
            self.mealStandard = textField.text;//餐标
        }else if ([self.isAddHotel integerValue] == 2){//已预订
            self.addressStr = textField.text;//酒店地址
        }
        
    }else if (textField.tag == 1010){
        
        if ([self.isAddHotel integerValue] == 2){//已预订
            self.inviterPhone = textField.text;//邀请人
        }
        
    }else if (textField.tag == 1011){
        
        if ([self.isAddHotel integerValue] == 1) {//未预定
            self.inviterPhone = textField.text;//邀请人
        }
        
    }
    NSLog(@"nameStr:%@,phoneStr:%@,friendType:%@,selectTime:%@,yusuanStr:%@,hotelStr:%@,addressStr:%@,tableCount:%@,mealStandard:%@",self.nameStr,self.phoneStr,self.friendType,self.selectTime,self.yusuanStr,self.hotelStr,self.addressStr,self.tableCount,self.mealStandard);
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1001) {
        
        if (buttonIndex == 0) {
            NSLog(@"新郎");
            self.friendType = @"1";
            [self.tableView reloadData];
        }else if (buttonIndex == 1){
            NSLog(@"新娘");
            self.friendType = @"2";
            [self.tableView reloadData];
        }
        
    }else if (actionSheet.tag == 1007){
        
        if (buttonIndex == 0) {
            NSLog(@"已预订");
            self.isAddHotel = @"2";
            [self.tableView reloadData];
        }else if (buttonIndex == 1){
            NSLog(@"未预定");
            self.isAddHotel = @"1";
            [self.tableView reloadData];
        }
        
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - YPAddRemarkDelegate
- (void)addRemark:(NSString *)remark{
    self.remarkStr = remark;
    if ([self.isAddHotel integerValue] == 1) {//未预定
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }else if ([self.isAddHotel integerValue] == 2){//已预订
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:8 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - 网络请求
#pragma mark 添加新人资料
- (void)AddNewInformation{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddNewInformation";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SubmittingID"] = UserId_New;
    params[@"ObjectTypes"] = @"1";//0提交自己(我要结婚), 1提交朋友(朋友结婚)
    
    params[@"SubmittingPhone"] = @"";//提交者手机号 3-5 改为邀请人手机号 -- 邀请结婚 无
    
    /**
     3-6 添加
     终端类型
     0网页分享、1扫码、2手机APP
     */
    params[@"TerminalTypes"] = @"2";
    
    if ([self.friendType integerValue] == 1) {//1.新郎 2.新娘
        params[@"GroomName"] = self.nameStr;
        params[@"GroomPhone"] = self.phoneStr;
        params[@"BrideName"] = @"";
        params[@"BridePhone"] = @"";
    }else if ([self.friendType integerValue] == 2){
        params[@"GroomName"] = @"";
        params[@"GroomPhone"] = @"";
        params[@"BrideName"] = self.nameStr;
        params[@"BridePhone"] = self.phoneStr;
    }
    
    params[@"AreaID"] = self.areaid;
    params[@"Address"] = @"";//详细地址
    
    if (self.selectTime.length == 0) {
        params[@"WeddingDay"] = @"";
    }else{
        params[@"WeddingDay"] = self.selectTime;
    }
    if (self.yusuanStr.length == 0) {
        params[@"Budget"] = @0;
    }else{
        params[@"Budget"] = self.yusuanStr;
    }
    if (self.hotelStr.length == 0) {
        params[@"HotelName"] = @"";
    }else{
        params[@"HotelName"] = self.hotelStr;
    }
    if (self.addressStr.length == 0) {
        params[@"HotelAddress"] = @"";
    }else{
        params[@"HotelAddress"] = self.addressStr;
    }
    if (self.remarkStr.length == 0) {
        params[@"Remarks"] = @"";
    }else{
        params[@"Remarks"] = self.remarkStr;
    }
    
    //3-6 添加
    if (self.tableCount.length == 0) {//桌数
        params[@"TablesNumber"] = @0;
    }else{
        params[@"TablesNumber"] = self.tableCount;
    }
    if (self.mealStandard.length == 0) {//每桌餐标
        params[@"MealMark"] = @0;
    }else{
        params[@"MealMark"] = self.mealStandard;
    }
    if ([self.isAddHotel integerValue] == 2) {//是否预定酒店 1.未预定 2.预定
        params[@"IsReservationTotel"] = @"1";//0未预定,1已预订
    }else{
        params[@"IsReservationTotel"] = @0;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您的申请已成功提交,请静候佳音!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
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
