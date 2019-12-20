//
//  YPInviteFriendsWedVIPController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedVIPController.h"
#import "YPHunJJSponsorImgCell.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"//18-11-12 改手机号
#import "YPInviteFriendsWedNormalThreeBtnCell.h"
#import "YPInviteFriendsWedShouYiCell.h"
#import "YPInviteFriendsWedVIPYuDingTypeCell.h"
#import "YPInviteFriendsWedVIPRecordController.h"
#import "YPInviteFriendsWedVIPSucController.h"

#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "BRDatePickerView.h"
#import "CJAreaPicker.h"//地址选择
#import <ASGradientLabel.h>

@interface YPInviteFriendsWedVIPController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**新人姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**新人婚期*/
@property (nonatomic, copy) NSString *dateStr;

/**预算-婚礼*/
@property (nonatomic, strong) UITextField *hl_yusaunTF;
/**预算-婚礼*/
@property (nonatomic, copy) NSString *hl_yusaun;

/**预定-婚宴餐桌*/
@property (nonatomic, strong) UITextField *canzhuoTF;
/**预定-婚宴餐桌*/
@property (nonatomic, copy) NSString *canzhuo;
/**预定-婚宴餐标*/
@property (nonatomic, strong) UITextField *canbiaoTF;
/**预定-婚宴餐标*/
@property (nonatomic, copy) NSString *canbiao;

/**预定-其他*/
@property (nonatomic, strong) UITextField *qt_yusuanTF;
/**预算-其他*/
@property (nonatomic, copy) NSString *qt_yusuan;
/**婚礼项目-其他*/
@property (nonatomic, strong) UITextField *wedProjectTF;
/**婚礼项目-其他*/
@property (nonatomic, copy) NSString *wedProject;
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

@implementation YPInviteFriendsWedVIPController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    //预定
    NSInteger _selectTag;//1: 婚宴 2: 婚礼 3: 其他 18-10-25 婚宴/婚礼换位
    
    UIButton *_submitBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //    [self GetWeChatActivityList];
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
    self.view.backgroundColor = WhiteColor;
    
    _selectTag = 1;
    
    [self setupUI];
    [self setupNav];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    backBtn.layer.cornerRadius = 16;
    backBtn.clipsToBounds = YES;
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UIButton *recordBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBtn setTitle:@"邀请记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    recordBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    recordBtn.layer.cornerRadius = 16;
    recordBtn.clipsToBounds = YES;
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88, 32));
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else if (section == 1){
        if (_selectTag == 1) {//1: 婚宴 2: 婚礼 3: 其他
            return 3;
        }else if (_selectTag == 3){//其他
            return 3;
        }else if (_selectTag == 2){//婚礼
            return 2;
        }
    }else{
        if (self.profitModel.EndBanner.length == 0) {
            return 2;
        }else{
            NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
            return 2+arr.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSString *str = self.profitModel.TopBanner;
            
            cell.imgStr = str;
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                /**
                 *  缓存image size
                 */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    
                    //reload row
                    if(result && (self.isViewLoaded && self.view.window))  {
                        
                        [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                    }else{
                        
                    }
                    
                }];
            }];
            
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            
            YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.hidden = NO;
            if (indexPath.row == 1) {
                
                YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"新人姓名";
                cell.inputTF.placeholder = @"请输入新人姓名";
                cell.inputTF.keyboardType = UIKeyboardTypeDefault;
                cell.inputTF.enabled = YES;
                self.nameTF = cell.inputTF;
                [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
                return cell;
                
            }else if (indexPath.row == 2){
                
                cell.titleLabel.hidden = NO;
                cell.titleLabel.text = @"新人手机";
                cell.inputTF.placeholder = @"请输入新人手机";
                cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
                cell.inputTF.enabled = YES;
                self.phoneTF = cell.inputTF;
                
            }else if (indexPath.row == 3){
                cell.titleLabel.text = @"新人婚期";
                cell.inputTF.placeholder = @"请输入选择新人婚期";
                cell.inputTF.enabled = NO;
                if (self.dateStr.length > 0) {
                    cell.inputTF.text = self.dateStr;
                }else{
                    cell.inputTF.text = @"";
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.row == 4){
                cell.titleLabel.text = @"所在区域";
                cell.inputTF.placeholder = @"请输入选择所在区域";
                cell.inputTF.enabled = NO;
                if (self.cityInfo.length > 0) {
                    cell.inputTF.text = self.cityInfo;
                }else{
                    cell.inputTF.text = @"";
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            YPInviteFriendsWedVIPYuDingTypeCell *cell = [YPInviteFriendsWedVIPYuDingTypeCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            _btn1 = cell.btn1;
//            _btn2 = cell.btn2;
//            _btn3 = cell.btn3;
            cell.btn1.tag = 1001;
            cell.btn2.tag = 1002;
            cell.btn3.tag = 1003;
            if (_selectTag == 1) {//1: 婚宴 2: 婚礼 3: 其他
                cell.btn1.selected = YES;
                cell.btn2.selected = NO;
                cell.btn3.selected = NO;
            }else if (_selectTag == 2){
                cell.btn1.selected = NO;
                cell.btn2.selected = YES;
                cell.btn3.selected = NO;
            }else if (_selectTag == 3){
                cell.btn1.selected = NO;
                cell.btn2.selected = NO;
                cell.btn3.selected = YES;
            }
            [cell.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            if (_selectTag == 1) {//1: 婚宴 2: 婚礼 3: 其他
                
                if (indexPath.row == 1) {
                    cell.titleLabel.hidden = NO;
                    cell.titleLabel.text = @"桌    数";
                    cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
                    cell.inputTF.enabled = YES;
                    cell.inputTF.placeholder = @"请输入餐桌数";
                    cell.inputTF.delegate = self;
                    self.canzhuoTF = cell.inputTF;
                    if (self.canzhuo.length > 0) {
                        cell.inputTF.text = self.canzhuo;
                    }else{
                        cell.inputTF.text = @"";
                    }
                }else if (indexPath.row == 2){
                    cell.titleLabel.hidden = NO;
                    cell.titleLabel.text = @"餐    标";
                    cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
                    cell.inputTF.enabled = YES;
                    cell.inputTF.placeholder = @"请输入每桌消费标准";
                    cell.inputTF.delegate = self;
                    self.canbiaoTF = cell.inputTF;
                    if (self.canbiao.length > 0) {
                        cell.inputTF.text = self.canbiao;
                    }else{
                        cell.inputTF.text = @"";
                    }
                }
                
            }else if (_selectTag == 3){//其他
                
                if (indexPath.row == 1) {
                    cell.titleLabel.hidden = NO;
                    cell.titleLabel.text = @"预    算";
                    cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
                    cell.inputTF.placeholder = @"请输入预算";
                    cell.inputTF.enabled = YES;
                    self.qt_yusuanTF = cell.inputTF;
                    cell.inputTF.delegate = self;
                    if (self.qt_yusuan.length > 0) {
                        cell.inputTF.text = self.qt_yusuan;
                    }else{
                        cell.inputTF.text = @"";
                    }
                }else if (indexPath.row == 2){
                    cell.titleLabel.hidden = NO;
                    cell.titleLabel.text = @"婚礼项目";
                    cell.inputTF.placeholder = @"请输入婚礼项目";
                    cell.inputTF.keyboardType = UIKeyboardTypeDefault;
                    cell.inputTF.enabled = YES;
                    self.wedProjectTF = cell.inputTF;
                    cell.inputTF.delegate = self;
                    if (self.wedProject.length > 0) {
                        cell.inputTF.text = self.wedProject;
                    }else{
                        cell.inputTF.text = @"";
                    }
                }
            }else if (_selectTag == 2){//婚礼
                cell.titleLabel.hidden = NO;
                cell.titleLabel.text = @"预    算";
                cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
                cell.inputTF.placeholder = @"请输入预算";
                cell.inputTF.enabled = YES;
                self.hl_yusaunTF = cell.inputTF;
                cell.inputTF.delegate = self;
                if (self.hl_yusaun.length > 0) {
                    cell.inputTF.text = self.hl_yusaun;
                }else{
                    cell.inputTF.text = @"";
                }
            }
            return cell;
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _submitBtn = [[UIButton alloc]init];
            [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
            [_submitBtn setBackgroundImage:[self gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth-36, 48) andColors:@[RGBA(87, 169, 255, 1),RGBA(143, 121, 255, 1)] andGradientType:1] forState:UIControlStateNormal];
            [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
            _submitBtn.layer.cornerRadius = 4;
            _submitBtn.clipsToBounds = YES;
            [cell.contentView addSubview:_submitBtn];
            [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(18);
                make.right.mas_equalTo(-18);
                make.bottom.mas_equalTo(-12);
                make.height.mas_equalTo(48);
            }];
            return cell;
        }else if (indexPath.row == 1){
            
            YPInviteFriendsWedShouYiCell *cell = [YPInviteFriendsWedShouYiCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            ASGradientLabel *priceLabel = [[ASGradientLabel alloc]init];
            priceLabel.text = [NSString stringWithFormat:@"%zd",self.profitModel.Money.integerValue];
            priceLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
            priceLabel.colors = @[(id)RGBA(255, 163, 89, 1).CGColor, (id)RGBA(255, 93, 118, 1).CGColor];
            priceLabel.startPoint = CGPointMake(0, 0);
            priceLabel.endPoint = CGPointMake(1, 0);
            priceLabel.locations = @[@0 ,@1];
            [cell.contentView addSubview:priceLabel];
            [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(48);
                make.left.mas_equalTo(18);
            }];
            ASGradientLabel *rmbLabel = [[ASGradientLabel alloc]init];
            rmbLabel.text = @"¥";
            rmbLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightHeavy];
            rmbLabel.colors = @[(id)RGBA(255, 163, 89, 1).CGColor, (id)RGBA(255, 93, 118, 1).CGColor];
            rmbLabel.startPoint = CGPointMake(0, 0);
            rmbLabel.endPoint = CGPointMake(1, 0);
            rmbLabel.locations = @[@0 ,@1];
            [cell.contentView addSubview:rmbLabel];
            [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(priceLabel);
                make.left.mas_equalTo(priceLabel.mas_right).mas_offset(3);
            }];
            [cell.showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else {
            YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
            
            NSString *str = arr[indexPath.row-2];
            
            cell.imgStr = str;
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                /**
                 *  缓存image size
                 */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    
                    //reload row
                    if(result && (self.isViewLoaded && self.view.window))  {
                        
                        [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                    }else{
                        
                    }
                    
                }];
            }];
            
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //        NSDictionary *dict = self.imgMarr[indexPath.row];
            NSString *str = self.profitModel.TopBanner;
            /**
             *  参数1:图片URL
             *  参数2:imageView 宽度
             *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
             */
            
            return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        }else{
            return 54;
        }
    }else if (indexPath.section == 1){
        return 54;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            return 72;
        }else if (indexPath.row == 1){
            return 92;
        }else {
            NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
            NSString *str = arr[indexPath.row-2];
            /**
             *  参数1:图片URL
             *  参数2:imageView 宽度
             *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
             */
            
            return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {//婚期
            
            [BRDatePickerView showDatePickerWithTitle:@"请选择新人婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
                self.dateStr = selectValue;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
        }else if (indexPath.row == 4) {//区域
            //地区
            CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
            picker.delegate = self;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
            [self presentViewController:navc animated:YES completion:nil];
            
        }
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.canzhuoTF) {
        self.canzhuo = self.canzhuoTF.text;
    }else if (textField == self.canbiaoTF){
        self.canbiao = self.canbiaoTF.text;
    }
    if (textField == self.qt_yusuanTF) {
        self.qt_yusuan = self.qt_yusuanTF.text;
    }else if (textField == self.wedProjectTF){
        self.wedProject = self.wedProjectTF.text;
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)recordBtnClick{
    NSLog(@"recordBtnClick");
    
    YPInviteFriendsWedVIPRecordController *record = [[YPInviteFriendsWedVIPRecordController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    if (self.nameTF.text.length == 0) {
        [EasyShowTextView showText:@"请输入新人姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入新人手机号" inView:self.tableView];
    }else if (self.dateStr.length == 0){
        [EasyShowTextView showText:@"请选择新人婚期" inView:self.tableView];
    }else{
        if (_selectTag == 2) {//1: 婚宴 2: 婚礼 3: 其他
            if (self.hl_yusaunTF.text == 0) {
                [EasyShowTextView showText:@"请输入预算" inView:self.tableView];
            }else{
                [self CeaterInvitationRecord];
            }
        }else if (_selectTag == 1){
            if (self.canzhuoTF.text == 0) {
                [EasyShowTextView showText:@"请输入餐桌数" inView:self.tableView];
            }
            //18-11-12 餐标非必填
//            else if (self.canbiaoTF.text == 0) {
//                [EasyShowTextView showText:@"请输入每桌消费标准" inView:self.tableView];
//            }
            else{
                [self CeaterInvitationRecord];
            }
        }else if (_selectTag == 3){
            if (self.qt_yusuanTF.text == 0) {
                [EasyShowTextView showText:@"请输入预算" inView:self.tableView];
            }else if (self.wedProjectTF.text == 0) {
                [EasyShowTextView showText:@"请输入婚礼项目" inView:self.tableView];
            }else{
                
                _submitBtn.enabled = NO;
                [self CeaterInvitationRecord];
            }
        }
    }
}

- (void)showBtnClick{
    NSLog(@"showBtnClick");
    
    [self showShareSDKWithURL:[NSString stringWithFormat:@"http://www.chenghunji.com/Capital/WeddInvitation?UserId=%@",UserId_New] Title:[NSString stringWithFormat:@"赚钱也太快了，我已经赚了%@元！你也来试试？",self.profitModel.Money] Text:@"邀新人用婚礼桥，赚80-10000元现金，可提现！"];
}

- (void)btnClick:(UIButton *)sender{
    _selectTag = sender.tag-1000;
    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 通讯录
- (void)addressBookClick{
    YPAddressBookTool *tool = [YPAddressBookTool yp_shareAddressBookTool];
    tool.vc = self;
    [tool JudgeAddressBookPower];
    tool.successBlock = ^(NSDictionary * _Nonnull object) {
        NSLog(@"[YPAddressBookTool yp_shareAddressBookTool] -- %@--%@",object[@"name"],object[@"phone"]);
        NSMutableString *phone = [object[@"phone"] stringByReplacingOccurrencesOfString:@"-" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""].mutableCopy;
        self.nameTF.text = object[@"name"];
        self.phoneTF.text = phone.copy;
    };
}

#pragma mark - shareSDK
- (void)showShareSDKWithURL:(NSString *)url Title:(NSString *)title Text:(NSString *)text{
    
    [HRShareView showShareViewWithPublishContent:@{@"title":title,
                                                   @"text" :text,
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :url}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
    
}

#pragma mark - 网络请求
#pragma mark 提交邀请
- (void)CeaterInvitationRecord{
    
    NSString *url = @"/api/HQOAApi/CeaterInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Name"] = self.nameTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"MarriagePeriod"] = self.dateStr;
    params[@"AreaId"] = self.areaid;
    
    if (_selectTag == 1) {//1: 婚宴 2: 婚礼 3: 其他
        params[@"PredefinedType"] = @"1";//0婚庆,1酒店,2其他
    }else if (_selectTag == 2) {//1: 婚宴 2: 婚礼 3: 其他
        params[@"PredefinedType"] = @"0";//0婚庆,1酒店,2其他
    }else if (_selectTag == 3) {//1: 婚宴 2: 婚礼 3: 其他
        params[@"PredefinedType"] = @"2";//0婚庆,1酒店,2其他
    }
    params[@"RefereeStatus"] = @"1";//0普通用户,1VIP
    params[@"RecommendId"] = UserId_New;
    if (self.canbiaoTF.text.length > 0) {
        params[@"MealMark"] = self.canbiaoTF.text;
    }else{
        params[@"MealMark"] = @"";
    }
    if (self.canbiaoTF.text.length > 0) {
        params[@"TableNumber"] = self.canzhuoTF.text;
    }else{
        params[@"TableNumber"] = @"";
    }
    if (_selectTag == 1) {//婚礼
        if (self.hl_yusaunTF.text.length > 0) {
            params[@"Budget"] = self.hl_yusaunTF.text;
        }else{
            params[@"Budget"] = @"";
        }
    }else if (_selectTag == 3){//其他
        if (self.qt_yusuanTF.text.length > 0) {
            params[@"Budget"] = self.qt_yusuanTF.text;
        }else{
            params[@"Budget"] = @"";
        }
    }else{//婚宴无预算
        params[@"Budget"] = @"";
    }
    
    params[@"WeddingCeremony"] = self.wedProjectTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        _submitBtn.enabled = YES;
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.nameTF.text = @"";
            self.phoneTF.text = @"";
            self.dateStr = @"";
            self.hl_yusaunTF.text = @"";
            self.hl_yusaun = @"";
            self.canzhuoTF.text = @"";
            self.canzhuo = @"";
            self.canbiaoTF.text = @"";
            self.canbiao = @"";
            self.qt_yusuanTF.text = @"";
            self.qt_yusuan = @"";
            self.wedProjectTF.text = @"";
            self.wedProject = @"";
            
            YPInviteFriendsWedVIPSucController *suc = [[YPInviteFriendsWedVIPSucController alloc]init];
            [self.navigationController pushViewController:suc animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        _submitBtn.enabled = YES;
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
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
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - 渐变色Image
- (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0://纵向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1://横向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default:
            start = CGPointZero;
            end = CGPointZero;
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - getter
-(NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
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
