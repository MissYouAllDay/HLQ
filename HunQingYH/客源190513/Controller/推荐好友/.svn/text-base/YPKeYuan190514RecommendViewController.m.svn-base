//
//  YPKeYuan190514RecommendViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190514RecommendViewController.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"
#import "CJAreaPicker.h"//地址选择
#import "BRDatePickerView.h"
#import "UIImage+YPGradientImage.h"
#import "YPKeYuan190514RecommendInviteController.h"
#import "YPGetInvitationProfit.h"//18-10-18 邀请结婚
#import "YPInviteFriendsWedNormalController.h"
#import "YPInviteFriendsWedVIPController.h"
#import "YPInviteFriendsWedNormalSucController.h"

@interface YPKeYuan190514RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**新人姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**桌数*/
@property (nonatomic, strong) UITextField *zhuoshuTF;
/**餐标*/
@property (nonatomic, strong) UITextField *canbiaoTF;
/**新人婚期*/
@property (nonatomic, copy) NSString *dateStr;
/**桌数*/
@property (nonatomic, copy) NSString *zhuoshu;
/**餐标*/
@property (nonatomic, copy) NSString *canbiao;

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *phoneStr;

///18-10-18 邀请结婚模型
@property (nonatomic, strong) YPGetInvitationProfit *profitModel;

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

@implementation YPKeYuan190514RecommendViewController{
    //数据库
    FMDatabase *dataBase;
    NSInteger _select;//0:勾选 1:未勾选
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _select = 0;
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, ScreenWidth, ScreenHeight-1-TabBarHeight) style:UITableViewStyleGrouped];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"keyuan_recommendBanner"]];
        [cell.contentView addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(cell.contentView);
        }];
        return cell;
    }else {
        YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"姓名";
            cell.inputTF.placeholder = @"请输入姓名";
            cell.inputTF.keyboardType = UIKeyboardTypeDefault;
            cell.inputTF.enabled = YES;
            self.nameTF = cell.inputTF;
            if (self.nameStr.length > 0) {
                self.nameTF.text = self.nameStr;
            }else{
                self.nameTF.text = @"";
            }
            [cell.addressBook setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            cell.addressBook.layer.borderColor = CHJ_RedColor.CGColor;
            [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"电话";
            cell.inputTF.placeholder = @"请输入手机";
            cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
            cell.inputTF.enabled = YES;
            self.phoneTF = cell.inputTF;
            if (self.phoneStr.length > 0) {
                self.phoneTF.text = self.phoneStr;
            }else{
                self.phoneTF.text = @"";
            }
        }else if (indexPath.row == 3){
            cell.titleLabel.text = @"婚期";
            cell.inputTF.placeholder = @"请选择新人婚期";
            cell.inputTF.enabled = NO;
            if (self.dateStr.length > 0) {
                cell.inputTF.text = self.dateStr;
            }else{
                cell.inputTF.text = @"";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 4){
            cell.titleLabel.text = @"桌数";
            cell.inputTF.placeholder = @"请输入桌数";
            cell.inputTF.enabled = YES;
            self.zhuoshuTF = cell.inputTF;
            if (self.zhuoshu.length > 0) {
                self.zhuoshuTF.text = self.zhuoshu;
            }else{
                self.zhuoshuTF.text = @"";
            }
        }else if (indexPath.row == 5){
            cell.titleLabel.text = @"餐标";
            cell.inputTF.placeholder = @"请输入大概的餐标预算";
            cell.inputTF.enabled = YES;
            self.canbiaoTF = cell.inputTF;
            if (self.canbiao.length > 0) {
                self.canbiaoTF.text = self.canbiao;
            }else{
                self.canbiaoTF.text = @"";
            }
        }else if (indexPath.row == 6){
            cell.titleLabel.text = @"区域";
            cell.inputTF.text = @"请选择区域";
            cell.inputTF.enabled = NO;
            cell.inputTF.text = self.cityInfo;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 7){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *select = [[UIButton alloc]init];
            if (_select == 0) {
                [select setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
            }else{
                [select setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
            }
            [select addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:select];
            [select mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(18);
                make.size.mas_equalTo(CGSizeMake(17, 17));
            }];
            //用户协议
            UILabel *xyDesLab  = [[UILabel alloc]init];
            xyDesLab.text = @"点击提交即视为同意";
            xyDesLab.font =kFont(11);
            xyDesLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            [cell.contentView addSubview:xyDesLab];
            [xyDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(select.mas_right).mas_offset(7);
            }];
            UILabel *xieyiLab = [[UILabel alloc]init];
            NSString *textStr = @"《推荐声明》和《隐私协议》";
            xieyiLab.font =kFont(11);
            xieyiLab.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSUnderlineColorAttributeName : [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
            xieyiLab.attributedText =attribtStr;
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xiyilabelClick)];
            
            [xieyiLab addGestureRecognizer:gestureRecognizer];
            xieyiLab.userInteractionEnabled = YES;
            [cell.contentView addSubview:xieyiLab];
            
            [xieyiLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(xyDesLab.mas_right);
                make.centerY.mas_equalTo(xyDesLab);
            }];
            return cell;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenWidth*0.4;
    }else if (indexPath.row == 7){
        return 40;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.bottom.mas_equalTo(view);
        make.height.mas_equalTo(40);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 6){
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

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
        self.nameStr = object[@"name"];
        self.phoneStr = phone.copy;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathWithIndex:1],[NSIndexPath indexPathWithIndex:2]] withRowAnimation:UITableViewRowAnimationNone];
    };
}

- (void)submitBtnClick{
    if (_select == 0) {
         [self CeaterInvitationRecord];
    }else{
        [EasyShowTextView showText:@"请同意并勾选协议" inView:self.tableView];
    }
}

- (void)selectClick:(UIButton *)sender{
    if (_select == 0) {
        _select = 1;
    }else{
        _select = 0;
    }
    [self.tableView reloadRow:7 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

-(void)xiyilabelClick{
    HRWebViewController *weBVC = [[HRWebViewController alloc]init];
    weBVC.webUrl =@"http://www.chenghunji.com/capital/useragreement";
    weBVC.isShareBtn =NO;
    [self.navigationController pushViewController:weBVC animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取邀请收益 18-10-18 邀请结婚
- (void)GetInvitationProfit{
    
    NSString *url = @"/api/HQOAApi/GetInvitationProfit";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.profitModel.RefereeStatus = [object objectForKey:@"RefereeStatus"];
            self.profitModel.TopBanner = [object objectForKey:@"TopBanner"];
            self.profitModel.EndBanner = [object objectForKey:@"EndBanner"];
            self.profitModel.Money = [object objectForKey:@"Money"];
            
            if (self.profitModel.RefereeStatus.integerValue == 0) {//0普通用户,1VIP
                //普通
                YPInviteFriendsWedNormalController *yqjh = [[YPInviteFriendsWedNormalController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
                
            }else if (self.profitModel.RefereeStatus.integerValue == 1){
                //VIP
                YPInviteFriendsWedVIPController *yqjh = [[YPInviteFriendsWedVIPController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 提交邀请
- (void)CeaterInvitationRecord{
    
    NSString *url = @"/api/HQOAApi/CeaterInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Name"] = self.nameTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"MarriagePeriod"] = self.dateStr;
    params[@"AreaId"] = self.areaid;
    params[@"PredefinedType"] = @"";//0婚庆,1酒店,2其他
    params[@"RefereeStatus"] = @"0";//0普通用户,1VIP
    params[@"RecommendId"] = UserId_New;
    params[@"MealMark"] = self.canbiaoTF.text;
    params[@"TableNumber"] = self.zhuoshuTF.text;
    params[@"Budget"] = @"";
    params[@"WeddingCeremony"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *rank = [object valueForKey:@"Ranking"];
            
            self.nameTF.text = @"";
            self.phoneTF.text = @"";
            self.dateStr = @"";
            
            YPInviteFriendsWedNormalSucController *suc = [[YPInviteFriendsWedNormalSucController alloc]init];
            suc.rankStr = rank;
            [self.navigationController pushViewController:suc animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
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

- (YPGetInvitationProfit *)profitModel{
    if (!_profitModel) {
        _profitModel = [[YPGetInvitationProfit alloc]init];
    }
    return _profitModel;
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
    //    [self GetWeddingPlanning];
    
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
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadRow:7 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    
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
