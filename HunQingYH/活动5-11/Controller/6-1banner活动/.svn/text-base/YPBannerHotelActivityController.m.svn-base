//
//  YPBannerHotelActivityController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/1.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPBannerHotelActivityController.h"
#import "YPBannerHotelActivityCell.h"
#import "FL_Button.h"
#import "CJAreaPicker.h"//城市选择
//#import "YPGetWebSupplierList.h"
#import "YPEDuRulesController.h"//规则
#import "HRHotelViewController.h"//酒店详情
#import "YPSupplierHomePage181119Controller.h"//商家主页
//18-09-12
#import "YPHunJJSponsorImgCell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "YPGetActivityHotelList.h"

@interface YPBannerHotelActivityController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**供应商数组*/
@property (nonatomic, strong) NSMutableArray<YPGetActivityHotelList *> *GYSArr;

@property(nonatomic,assign)NSInteger parentID;
@property (nonatomic, copy) NSString *cityInfo;

/**活动规则*/
@property (nonatomic, copy) NSString *ruleStr;
/**6-4 添加 活动背景图*/
@property (nonatomic, copy) NSString *HeadImg;

/** 18-09-12 多图*/
@property (nonatomic, strong) NSMutableArray *startImgMarr;
@property (nonatomic, strong) NSMutableArray *endImgMarr;

@end

@implementation YPBannerHotelActivityController{
    UIView *_navView;
    FL_Button *_addressBtn;
    FMDatabase *dataBase;
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetActivityHotelList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    _pageIndex = 1;

    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
    [self setupUI];
    [self setupNav];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"设置";
//    titleLab.textColor = BlackColor;
//    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBA(91, 198, 250, 1);
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetActivityHotelList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetActivityHotelList];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.startImgMarr.count;
    }else if (section == 1) {
        return self.GYSArr.count == 0 ? 1 : self.GYSArr.count;
    }else if (section == 2) {
        return self.endImgMarr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *dict = self.startImgMarr[indexPath.row];
        
        NSString *str = dict[@"StartImgUrl"];
        
        cell.imgStr =str;
        
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
        
    }else if (indexPath.section == 1) {
        
        if (self.GYSArr.count == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.textLabel.text = @"555, 本地还未参与, 玩儿命申请中!";
            cell.textLabel.textColor = WhiteColor;
            cell.backgroundColor = RGB(239, 27, 5);
            
            return cell;
            
        }else{
            YPGetActivityHotelList *gysModel = self.GYSArr[indexPath.row];
            
            YPBannerHotelActivityCell *cell = [YPBannerHotelActivityCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.gysModel = gysModel;
            return cell;
        }
    }else if (indexPath.section == 2) {
        
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *dict = self.endImgMarr[indexPath.row];
        
        NSString *str = dict[@"EndImgUrl"];
        
        cell.imgStr =str;
        
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
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSDictionary *dict = self.startImgMarr[indexPath.row];
        NSString *str = dict[@"StartImgUrl"];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        
    }else if (indexPath.section == 1) {
        return 135;
    }else if (indexPath.section == 2){
        
        NSDictionary *dict = self.endImgMarr[indexPath.row];
        NSString *str = dict[@"EndImgUrl"];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 60;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;

        UIImageView *imgV = [[UIImageView alloc]init];
        [imgV sd_setImageWithURL:[NSURL URLWithString:self.HeadImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        [view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
        }];

        //导航栏地址选择按钮
        _addressBtn = [FL_Button fl_shareButton];
        [_addressBtn setBackgroundColor:[UIColor whiteColor]];
        [_addressBtn setImage:[UIImage imageNamed:@"下拉_white-1"] forState:UIControlStateNormal];

        //6-5 修改
        if (self.cityInfo.length == 0) {
            [_addressBtn setTitle:@"黄岛区" forState:UIControlStateNormal];
        }else{
            [_addressBtn setTitle:self.cityInfo forState:UIControlStateNormal];
        }

        [_addressBtn setTitleColor:WhiteColor forState:UIControlStateNormal];//2-9 修改
        [_addressBtn setBackgroundColor:ClearColor];
        [_addressBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _addressBtn.status = FLAlignmentStatusCenter;
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _addressBtn.layer.cornerRadius = 3;
        _addressBtn.clipsToBounds = YES;
        _addressBtn.layer.borderColor = WhiteColor.CGColor;
        _addressBtn.layer.borderWidth = 1;
        [view addSubview:_addressBtn];
//        [_addressBtn.titleLabel sizeToFit];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(view.mas_left).offset(15);
            make.bottom.mas_equalTo(-5);
//            make.size.mas_equalTo(CGSizeMake(75, 35));
            make.height.mas_equalTo(35);
            make.width.mas_greaterThanOrEqualTo(75);
        }];

        UIButton *ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ruleBtn setTitle:@"活动规则" forState:UIControlStateNormal];
        [ruleBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        ruleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        ruleBtn.layer.cornerRadius = 3;
        ruleBtn.clipsToBounds = YES;
        ruleBtn.layer.borderColor = WhiteColor.CGColor;
        ruleBtn.layer.borderWidth = 1;
        [ruleBtn addTarget:self action:@selector(ruleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ruleBtn];
        [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(75, 35));
        }];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (self.GYSArr.count > 0) {
            
            //登录判断
            if (!UserId_New) {
                YPReLoginController *first = [[YPReLoginController alloc]init];
                UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                [self presentViewController:firstNav animated:YES completion:nil];
            }else{
                
                YPGetActivityHotelList *model = _GYSArr[indexPath.row];
                
                YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
                hotelVC.FacilitatorID = model.FacilitatorId;
                hotelVC.profession = JiuDian_New;
                [self.navigationController pushViewController:hotelVC animated:YES];
            }
        }
    }
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)ruleBtnClick{
    NSLog(@"ruleBtnClick");
    
    YPEDuRulesController *rule = [[YPEDuRulesController alloc]init];
    rule.ruleStr = self.ruleStr;
    [self.navigationController pushViewController:rule animated:YES];
}

#pragma mark - CJAreaPickerDelegate----
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;

    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    [self dismissViewControllerAnimated:YES completion:nil];
    [_addressBtn setTitle:address forState:UIControlStateNormal];
    [self selectDataBase];
    
}
-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;

    NSLog(@"缓存城市设置为%@",address);
    
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [_addressBtn setTitle:address  forState:UIControlStateNormal];
    [self selectDataBase];
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
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
    
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
//        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
//        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"AreaID"];
        self.parentID = ID;
    }
    
    [self closeDataBase];
    
    //5-14 更新nav位置btn
    [_addressBtn setTitle:self.cityInfo forState:UIControlStateNormal];
    
    //网络请求数据
    [self GetActivityHotelList];
}

#pragma mark - 网络请求
#pragma mark 获取活动酒店列表
- (void)GetActivityHotelList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetActivityHotelList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"AreaID"] = areaID_New;
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    params[@"Name"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.GYSArr removeAllObjects];
                self.GYSArr  = [YPGetActivityHotelList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetActivityHotelList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.GYSArr addObjectsFromArray:newArray];
                }
                
            }
            
            self.ruleStr = [object valueForKey:@"RulesActivity"];
            self.HeadImg = [object valueForKey:@"HeadImg"];
            
            //18-09-12
            self.startImgMarr = [object objectForKey:@"StartImgData"];
            self.endImgMarr = [object objectForKey:@"EndImgListData"];
            
            NSLog(@"列表：%@",object);
            [self.tableView reloadData];
            [self endRefresh];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        //        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark - 缺省
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetActivityHotelList];
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetActivityHotelList *> *)GYSArr{
    if (!_GYSArr) {
        _GYSArr = [NSMutableArray array];
    }
    return _GYSArr;
}

- (NSMutableArray *)startImgMarr{
    if (!_startImgMarr) {
        _startImgMarr = [NSMutableArray array];
    }
    return _startImgMarr;
}

- (NSMutableArray *)endImgMarr{
    if (!_endImgMarr) {
        _endImgMarr = [NSMutableArray array];
    }
    return _endImgMarr;
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
