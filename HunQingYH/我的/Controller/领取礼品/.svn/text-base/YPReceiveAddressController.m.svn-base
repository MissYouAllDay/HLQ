//
//  YPReceiveAddressController.m
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPReceiveAddressController.h"
#import "BATextView.h"
#import "YPReceiveAddressSucController.h"
#import "YPSelectNormalCell.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
@interface YPReceiveAddressController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JVFloatLabeledTextField *nameTF;
@property (nonatomic, strong) JVFloatLabeledTextField *phoneTF;
@property (nonatomic, strong) JVFloatLabeledTextField *postCodeTF;
@property (nonatomic, strong) UITextView *inputView;

/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger  parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;

@end

@implementation YPReceiveAddressController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    
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
    self.view.backgroundColor = CHJ_bgColor;
    

//    [self selectDataBase];
    
    [self setupNav];
    [self setupUI];
}

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
    titleLab.text = @"详细规则";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [addBtn setBackgroundColor:NavBarColor];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    addBtn.layer.cornerRadius = 5;
    addBtn.clipsToBounds = YES;
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 4) {
        
        [cell.contentView addSubview:self.inputView];
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(cell.contentView).mas_offset(10);
            make.right.mas_equalTo(cell.contentView).mas_offset(-10);
            make.height.mas_equalTo(100);
        }];


    
        
    }else if(indexPath.row == 3){
        
        YPSelectNormalCell *cell = [YPSelectNormalCell cellWithTableView:tableView];
        cell.titleLabel.font = kNormalFont;
        cell.descLabel.font = kNormalFont;
        cell.titleLabel.text = @"地区";
        if (self.cityInfo.length > 0) {
            cell.descLabel.text = self.cityInfo;
        }else{
            cell.descLabel.text = @"请选择地区";
        }
        return cell;
        
    }else {

        if (indexPath.row == 0) {
            if (!self.nameTF) {
                self.nameTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
            }
            self.nameTF.font = kNormalFont;
            //    self.phoneTF.backgroundColor = WhiteColor;
            self.nameTF.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"收件人姓名", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
            self.nameTF.floatingLabelFont = kMostSmallFont;
            self.nameTF.floatingLabelTextColor = [UIColor brownColor];
            self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            [cell.contentView addSubview:self.nameTF];
            self.nameTF.translatesAutoresizingMaskIntoConstraints = NO;
            self.nameTF.keepBaseline = YES;
            [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(13);
                make.top.mas_equalTo(cell.contentView);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(43);
            }];
            
        }else if (indexPath.row == 1){
            
            if (!self.phoneTF) {
                self.phoneTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
            }
            self.phoneTF.font = kNormalFont;
            //    self.phoneTF.backgroundColor = WhiteColor;
            self.phoneTF.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"手机号码", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
            self.phoneTF.floatingLabelFont = kMostSmallFont;
            self.phoneTF.floatingLabelTextColor = [UIColor brownColor];
            self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            [cell.contentView addSubview:self.phoneTF];
            self.phoneTF.translatesAutoresizingMaskIntoConstraints = NO;
            self.phoneTF.keepBaseline = YES;
            self.phoneTF.keyboardType =UIKeyboardTypeNumberPad;
            [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(13);
                make.top.mas_equalTo(cell.contentView);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(43);
            }];
        }else if (indexPath.row == 2){
            
            if (!self.postCodeTF) {
                self.postCodeTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
            }
            self.postCodeTF.font = kNormalFont;
            //    self.phoneTF.backgroundColor = WhiteColor;
            self.postCodeTF.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"邮编", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
            self.postCodeTF.floatingLabelFont = kMostSmallFont;
            self.postCodeTF.floatingLabelTextColor = [UIColor brownColor];
            self.postCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.postCodeTF.keyboardType =UIKeyboardTypeNumberPad;
            [cell.contentView addSubview:self.postCodeTF];
            self.postCodeTF.translatesAutoresizingMaskIntoConstraints = NO;
            self.postCodeTF.keepBaseline = YES;
            [self.postCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(13);
                make.top.mas_equalTo(cell.contentView);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(43);
            }];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        return 100;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
    }
    
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    self.cityInfo = address;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
}


-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
//    self.parentID =parentID;
//   
//    //    self.cityInfo =huanCun;
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
//    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
//    [self selectDataBase];
}
#pragma mark --------数据库-------

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
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - target
- (void)backVC{
//    [[NSNotificationCenter defaultCenter]removeObserver:_inputView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick{
    
//    if ([self.sucDelegate respondsToSelector:@selector(receiveAddressSuc)]) {
//        [self.sucDelegate receiveAddressSuc];
//    }
    
    if (self.nameTF.text.length == 0) {
        
        [EasyShowTextView showText:@"请输入收件人姓名"];
    }else if (self.phoneTF.text.length == 0){
        
        [EasyShowTextView showText:@"请输入收件人电话"];
    }else if (self.postCodeTF.text.length == 0){
        
        [EasyShowTextView showText:@"请输入邮编"];
    }else if (self.areaid.length == 0){
        
        [EasyShowTextView showText:@"请选择地区"];
    }else if (self.inputView.text.length == 0){
        
        [EasyShowTextView showText:@"请输入详细地址"];
    }else{
        
        [self AddDeliveryAddress];//添加地址
    }
 
}

#pragma mark -------网络请求----------
#pragma mark 添加快递地址
-(void)AddDeliveryAddress{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/AddDeliveryAddress";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ObjectTypes"]      = [NSString stringWithFormat:@"%zd",self.ObjectTypes];//0公司加入供应商、1供应商邀请供应、2微信投票、3邀请备婚、4新人出方案 5 爆米花抽奖 6酒店新人出方案
    if (self.ObjectTypes ==5) {
        //爆米花抽奖
          params[@"ObjectID"]         = [NSString stringWithFormat:@"%zd",self.ActivityPrizesID];//相关对象ID
    }else{
           params[@"ObjectID"]         = UserId_New;//相关对象ID
    }
 
    params[@"AreaID"]           = self.areaid;
    params[@"Address"]          = self.inputView.text;
    params[@"Consignee"]        = self.nameTF.text;
    params[@"ConsigneePhone"]   = self.phoneTF.text;
    params[@"PostCode"]         = self.postCodeTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *addressID = [object valueForKey:@"DeliveryAddressID"];
            
            if (self.ObjectTypes ==5) {
                //爆米花抽奖
                YPReceiveAddressSucController *suc = [[YPReceiveAddressSucController alloc]init];
                [self.navigationController presentViewController:suc animated:YES completion:nil];
                UIViewController *controller = self.navigationController.viewControllers[2];
                [self.navigationController popToViewController:controller animated:YES];
            }else if (self.ObjectTypes ==6){
                //酒店新人方案
                YPReceiveAddressSucController *suc = [[YPReceiveAddressSucController alloc]init];
                [self.navigationController presentViewController:suc animated:YES completion:nil];
                UIViewController *controller = self.navigationController.viewControllers[0];
                [self.navigationController popToViewController:controller animated:YES];
            }
            else{
                  [self AddAcquiringPrizesWithDeliveryId:addressID];
            }
          
            
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

#pragma mark 添加奖品领取
-(void)AddAcquiringPrizesWithDeliveryId:(NSString *)deliveryId{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/AddAcquiringPrizes";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ObjectTypes"]  = [NSString stringWithFormat:@"%zd",self.ObjectTypes];//0公司加入供应商、1供应商邀请供应、2微信投票、3邀请备婚、4新人出方案
    params[@"ObjectID"]     = UserId_New;//相关对象ID
    params[@"PrizesCode"]   = self.ActivityID;//活动ID
    params[@"DeliveryId"]   = deliveryId;//发货地址ID
    params[@"Grade"]        = self.grade;//
  
 
    if (self.ObjectTypes==3||self.ObjectTypes==4) {
       params[@"ActivityPrizesID"]        =[NSString stringWithFormat:@"%zd", self.ActivityPrizesID];//穿入3/4的时候如果满足自选就传入活动id、则传0
    }else{
          params[@"ActivityPrizesID"]        = @0;//穿入3/4的时候如果满足自选就传入活动id、则传0
    }
    if (self.ObjectTypes ==2) {
        
          params[@"CargoCode"]=self.weiCode;
    
    }else{
           params[@"CargoCode"]=@"";
       
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            YPReceiveAddressSucController *suc = [[YPReceiveAddressSucController alloc]init];
            [self.navigationController presentViewController:suc animated:YES completion:nil];
            UIViewController *controller = self.navigationController.viewControllers[0];
            [self.navigationController popToViewController:controller animated:YES];
            
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
- (UITextView *)inputView{
    if (!_inputView) {
        _inputView = [[UITextView alloc]init];
        // 设置文本框占位图文字
        _inputView.ba_placeholder = @"详细地址";
        _inputView.ba_placeholderColor = LightGrayColor;
        _inputView.ba_placeholderFont = kNormalFont;
        _inputView.ba_minHeight = 100;
    

    }

    return _inputView;
    
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
