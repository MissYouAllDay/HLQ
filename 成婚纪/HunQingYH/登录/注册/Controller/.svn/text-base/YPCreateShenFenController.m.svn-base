//
//  YPCreateShenFenController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCreateShenFenController.h"
#import "YPCreateIconCell.h"
#import "YPInputNormalCell.h"
#import "YPSelectNormalCell.h"
//#import "YPProfessionController.h"//职业
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
#import "YPAddIconController.h"//头像
#import "YPRegistLicenceController.h"//身份验证

@interface YPCreateShenFenController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,YPAddIconDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YPCreateIconCell *iconCell;
@property (nonatomic, strong) YPInputNormalCell *inputCell;
@property (nonatomic, strong) YPSelectNormalCell *fanweiCell;
@property (nonatomic, strong) YPSelectNormalCell *areaCell;

//@property (nonatomic, copy)   NSString *profession;//经营范围 编号
//@property (nonatomic, copy)   NSString *professionName;
@property (nonatomic, strong) UITextField *nameTF;//店铺名称
@property (nonatomic, strong) UITextField *addressTF;//地址 -- 只有酒店才有

@property (nonatomic, strong) UIImage *icon;

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

//@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation YPCreateShenFenController{
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

    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"创建身份";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (JiuDian(self.professionID)) {
            return 4;
        }else{
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.iconCell = [YPCreateIconCell cellWithTableView:tableView];
        
        if (JiuDian(self.professionID)) {
            self.iconCell.titleLabel.text = @"酒店Logo";
        }else{
            self.iconCell.titleLabel.text = @"个人Logo";
        }
        if (self.icon) {
            self.iconCell.iconImgV.image = self.icon;
        }
        return self.iconCell;
    }else{
        if (indexPath.row == 0) {
            self.inputCell = [YPInputNormalCell cellWithTableView:tableView];
            if (JiuDian(self.professionID)) {
                self.inputCell.titleLabel.text = @"酒店名称";
            }else{
                self.inputCell.titleLabel.text = @"个人昵称";
            }
            self.nameTF = self.inputCell.inputTF;
            self.inputCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return self.inputCell;
        }else if (indexPath.row == 1) {
            self.fanweiCell = [YPSelectNormalCell cellWithTableView:tableView];
            self.fanweiCell.titleLabel.text = @"经营范围";
            if (self.professionID.length > 0 && self.professionName.length > 0) {
                self.fanweiCell.descLabel.text = self.professionName;
                self.fanweiCell.descLabel.textColor = BlackColor;
            }
            return self.fanweiCell;
        }else if (indexPath.row == 2) {
            self.areaCell = [YPSelectNormalCell cellWithTableView:tableView];
            self.areaCell.titleLabel.text = @"所在地区";
            if (self.cityInfo.length > 0 && self.areaid.length > 0) {
                self.areaCell.descLabel.text = self.cityInfo;
                self.areaCell.descLabel.textColor = BlackColor;
            }
            return self.areaCell;
        }
        if (JiuDian(self.professionID)) {
            if (indexPath.row == 3) {
                self.inputCell = [YPInputNormalCell cellWithTableView:tableView];
                self.addressTF = self.inputCell.inputTF;
                self.inputCell.titleLabel.text = @"详细地址";
                self.addressTF.placeholder = @"请输入详细地址";
                self.inputCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return self.inputCell;
            }
        }
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 45;
    }else{
        return 75;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        UILabel *label = [[UILabel alloc]init];
        if (JiuDian(self.professionID)) {
            label.text = @"酒店LOGO是酒店在婚礼桥中的图片标识,最佳尺寸为400*400";
        }else{
            label.text = @"个人LOGO是用户在婚礼桥中的图片标识,最佳尺寸为400*400";
        }
        label.textColor = GrayColor;
        label.font = kNormalFont;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(15);
            make.bottom.mas_greaterThanOrEqualTo(-10);
            make.right.mas_greaterThanOrEqualTo(-15);
            make.width.mas_lessThanOrEqualTo(ScreenWidth-30);
        }];

        return view;
    }else if (section == 1) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        //确定按钮
        UIButton *sureBtn = [[UIButton alloc] init];
        [sureBtn setBackgroundColor:NavBarColor];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sureBtn];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.clipsToBounds = YES;
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(45);
        }];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        YPAddIconController *addIcon = [[YPAddIconController alloc]init];
        addIcon.iconDelegate = self;
        [self.navigationController pushViewController:addIcon animated:YES];
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {//9.23 修改 职业在上级界面修改 此处不能点击
//            if (self.profession.length == 0) {
//                YPProfessionController *pro = [[YPProfessionController alloc]init];
//                pro.professionDelegate = self;
//                [self.navigationController pushViewController:pro animated:YES];
//            }
        }else if (indexPath.row == 2) {
            CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
            picker.delegate = self;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
            [self presentViewController:navc animated:YES completion:nil];
        }
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

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (!self.icon) {
        Alertmsg(@"请上传Logo", nil)
    }else if (self.nameTF.text.length == 0) {
        Alertmsg(@"请填写店铺名称", nil)
    }else if (self.cityInfo.length == 0 || self.areaid.length == 0){
        Alertmsg(@"请选择所在地区", nil)
    }else{
    
        [self uploadIconImgRequest];//上传图片
    }
}

//#pragma mark - YPProfessionDelegate
//- (void)returnProfession:(NSString *)profession AndProfessionName:(NSString *)professionName{
//    NSLog(@"%@",profession);
//    self.profession = profession;
//    self.professionName = professionName;
//    
//    [self.tableView reloadData];
//}

#pragma mark - YPAddIconDelegate
- (void)returnIconImg:(UIImage *)image{
    self.icon = image;
//    self.iconID = imgID;
    
    [self.tableView reloadData];
}

#pragma mark - 上传图片
-(void)uploadIconImgRequest{
    
    [EasyShowLodingView showLoding];
    
    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
    [fmdict setValue:@"2" forKey:@"os"];//0惠约、1汇码、2婚庆、3减肥
    [fmdict setValue:@"0" forKey:@"ot"];//0用户图、1公司、2平台
    if (UserId_New) {
        [fmdict setValue:UserId_New forKey:@"oi"];
    }else{
        [fmdict setValue:@"0" forKey:@"oi"];//注册时 id为空 此时传0
    }
    [fmdict setValue:@"1" forKey:@"t"];//用户：1认证相关、2功能相关、3其他
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = fmdict;
    imageEntity.imageArray = @[self.icon];
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"创建身份 返回：====%@",response);
        
        YPRegistLicenceController *licence = [[YPRegistLicenceController alloc]init];
        if (JiuDian(self.professionID)) {
            
            licence.profession = self.professionID;
            licence.phoneNo = self.phoneNo;
            licence.authCodeID = self.authCodeID;
            licence.iconID = [response objectForKey:@"Inform"];
            licence.shopName = self.nameTF.text;
            licence.addressID = self.areaid;
            licence.address = self.addressTF.text;//只有酒店才有
            
        }else{
            
            licence.profession = self.professionID;
            licence.phoneNo = self.phoneNo;
            licence.authCodeID = self.authCodeID;
            licence.iconID = [response objectForKey:@"Inform"];
            licence.shopName = self.nameTF.text;
            licence.addressID = self.areaid;
            
        }
        [self.navigationController pushViewController:licence animated:YES];
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:@[self.icon] fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//
//
//
//    } failurBlock:^(NSError *error) {
//
//
//
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
    
}

#pragma mark - getter
-(NSString *)areaid{
    if (!_areaid) {
        self.areaid =[[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    }
    return _cityInfo;
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
