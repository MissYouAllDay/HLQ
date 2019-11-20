//
//  YPMemberCarTeamController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMemberCarTeamController.h"
#import "YPMyCarJianJieImgCell.h"
#import "YPMyCarTextCell.h"
#import "YPMyCarAnLiCell.h"
#import "YPMemberCarTeamCaptainCell.h"
#import "YPGetSupplierInfo.h"
#import "HRAnLiModel.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
#import "YPMyAnliDetailController.h"

@interface YPMemberCarTeamController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetSupplierInfo *supplierInfo;
@property (nonatomic, strong) NSMutableArray<HRAnLiModel *> *anliMarr;

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

@end

@implementation YPMemberCarTeamController{
    UIView *_navView;
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
    
    [self GetSupplierInfo];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    

    //设置导航栏左边通知
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
    titleLab.text = @"我的车队";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"退队" forState:UIControlStateNormal];
    [moreBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.anliMarr.count > 0) {
        return 5 + self.anliMarr.count;
    }else{
        return 5 + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPMyCarJianJieImgCell *cell = [YPMyCarJianJieImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.supplierInfo.Headportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
        return cell;
    }else{
        YPMyCarTextCell *cell = [YPMyCarTextCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"名字";
            if (self.supplierInfo.Name.length > 0) {
                cell.descLabel.text = self.supplierInfo.Name;
            }else{
                cell.descLabel.text = @"当前没有名称";
            }
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"简介";
            if (self.supplierInfo.BriefinTroduction.length > 0) {
                cell.descLabel.text = self.supplierInfo.BriefinTroduction;
            }else{
                cell.descLabel.text = @"当前无简介";
            }
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"地区";
            if (self.cityInfo.length > 0 && self.areaid.length > 0) {
                cell.descLabel.text = self.cityInfo;
            }else{
                cell.descLabel.text = @"当前没有地区";
            }
        }else if (indexPath.row == 4) {
        
            YPMemberCarTeamCaptainCell *cell = [YPMemberCarTeamCaptainCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.supplierInfo.TrueName.length > 0) {
                cell.nameLabel.text = self.supplierInfo.TrueName;
            }else{
                cell.nameLabel.text = @"无姓名";
            }
            if (self.supplierInfo.PhoneNo.length > 0) {
                cell.phone.text = self.supplierInfo.PhoneNo;
            }else{
                cell.phone.text = @"无电话";
            }
            [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else{
            
            if (self.anliMarr.count > 0) {
                HRAnLiModel *model = self.anliMarr[indexPath.row - 5];
                
                YPMyCarAnLiCell *cell = [YPMyCarAnLiCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (indexPath.row == 5) {
                    
                    cell.titleLabel.hidden = NO;
                    cell.numLabel.hidden = NO;
                    cell.numLabel.text = [NSString stringWithFormat:@"%zd",self.anliMarr.count];
                    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.CoverMap] placeholderImage:[UIImage imageNamed:@"占位图"]];
                    cell.descLabel.text = model.LogTitle;
                    
                }else{
                    
                    cell.titleLabel.hidden = YES;
                    cell.numLabel.hidden = YES;
                    
                    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.CoverMap] placeholderImage:[UIImage imageNamed:@"占位图"]];
                    cell.descLabel.text = model.LogTitle;
                    
                }
                
                return cell;
            }else{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.textLabel.text = @"当前无案例";
                return cell;
            }
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        
    }else{
        
        HRAnLiModel *model = self.anliMarr[indexPath.row - 5];
        
        YPMyAnliDetailController *detail = [[YPMyAnliDetailController alloc]init];
        detail.CaseID = model.CaseID;
        detail.SupplierID = self.captainID;
        detail.IsCheShouMyTeam = @"1";
        [self.navigationController yp_pushViewController:detail animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"退队");
    
    [self DirverPull];
    
}

- (void)phoneBtnClick{
    NSLog(@"phoneBtnClick");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.supplierInfo.PhoneNo]]];
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
//        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - 网络请求
#pragma mark 获取供应商详细信息
- (void)GetSupplierInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSupplierInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = self.captainID;//车手查询车队 传队长ID
    params[@"UserID"] = UserId_New;
    params[@"Type"] = @"0";//0、用户获取供应商1、供应商获取自己
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.supplierInfo.ProfessionID = [object valueForKey:@"ProfessionID"];
            self.supplierInfo.Region = [object valueForKey:@"Region"];
            self.supplierInfo.BriefinTroduction = [object valueForKey:@"BriefinTroduction"];
            self.supplierInfo.PhoneNo = [object valueForKey:@"PhoneNo"];
            self.supplierInfo.Name = [object valueForKey:@"Name"];
            self.supplierInfo.Headportrait = [object valueForKey:@"Headportrait"];
            self.supplierInfo.SupplierID = [object valueForKey:@"SupplierID"];
            
            self.supplierInfo.Adress = [object valueForKey:@"Adress"];
            self.supplierInfo.CreateTime = [object valueForKey:@"CreateTime"];
            self.supplierInfo.TrueName = [object valueForKey:@"TrueName"];
            self.supplierInfo.IsCollection = [object valueForKey:@"IsCollection"];
            self.supplierInfo.IsSearch = [object valueForKey:@"IsSearch"];
            
            self.areaid = self.supplierInfo.Region;
            if ([self.supplierInfo.Region integerValue] != 0) {
                self.parentID = [self.supplierInfo.Region integerValue];
                NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
                self.cityInfo = huanCun;
            }
            
            self.anliMarr = [HRAnLiModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self selectDataBase];
            
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

#pragma mark 车手退出车队
- (void)DirverPull{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DirverPull";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = self.captainID;//车手查询车队 传队长ID
    params[@"UserID"] = UserId_New;
    params[@"Start"] = @"0";//0车手退出、1队长解散
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"退队成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
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
- (YPGetSupplierInfo *)supplierInfo{
    if (!_supplierInfo) {
        _supplierInfo = [[YPGetSupplierInfo alloc]init];
    }
    return _supplierInfo;
}

- (NSMutableArray<HRAnLiModel *> *)anliMarr{
    if (!_anliMarr) {
        _anliMarr = [NSMutableArray array];
    }
    return _anliMarr;
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
