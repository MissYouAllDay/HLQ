//
//  YPSupplierPersonInfoController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//
/** 除 车手/用户 外的供应商 */

#import "YPSupplierPersonInfoController.h"
#import "YPHotelInfoIconCell.h"
#import "YPNormalTextCell.h"
#import "YPTextNormalCell.h"//自适应
#import "YPAddRemarkController.h"
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

@interface YPSupplierPersonInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YPAddRemarkDelegate,UIActionSheetDelegate,CJAreaPickerDelegate,HXPhotoViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *titleName;
//@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *professionID;
@property (nonatomic, copy) NSString *jianjie;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

//@property (nonatomic, strong) YPGetSupplierInfo *supplierInfo;

@property (nonatomic, strong) YPGetFacilitatorInfo *infoModel;

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

    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
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
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"供应商个人资料";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
   
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"保存" forState:UIControlStateNormal];
    [moreBtn setTitleColor:GrayColor forState:UIControlStateNormal];
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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
            
            YPNormalTextCell *cell = [YPNormalTextCell cellWithTableView:tableView];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"手机";
                if (self.phone.length > 0) {
                    cell.content.text = self.phone;
                    cell.content.textColor = BlackColor;
                }else{
                    cell.content.text = @"请输入联系人手机号";
                    cell.content.textColor = GrayColor;
                }
            }else if (indexPath.row == 1) {
                cell.titleLabel.text = @"地区";
                if (self.cityInfo.length > 0) {
                    cell.content.text = self.cityInfo;
                    cell.content.textColor = BlackColor;
                }else{
                    cell.content.text = @"选择所在地区";
                    cell.content.textColor = GrayColor;
                }
                
            }else if (indexPath.row == 2) {
                cell.titleLabel.text = @"地址";
                if (self.address.length > 0) {
                    cell.content.text = self.address;
                    cell.content.textColor = BlackColor;
                }else{
                    cell.content.text = @"请输入具体地址";
                    cell.content.textColor = GrayColor;
                }
            }
            return cell;
        }else if (indexPath.row == 3) {
            
            //简介
            YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @"简介";
            cell.content.font = kBigFont;
            [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
            }];
            if (self.jianjie.length > 0) {
                cell.content.text = self.jianjie;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请输入简介";
                cell.content.textColor = GrayColor;
            }
            
            return cell;
            
        }
    }else{
        
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
        self.photoManager.configuration.photoMaxNum = 20;
        
        self.photoManager.localImageList = self.upXCArray;
        
        [self.photoView refreshView];

        [cell.contentView addSubview:self.photoView];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return self.photoView.frame.size.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [UIView new];
        view.backgroundColor = CHJ_bgColor;
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"添加封面图";
        label.textColor = GrayColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
            make.left.mas_equalTo(15);
        }];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.remarkDelegate = self;
        
        if (indexPath.row == 0) {
            
            addRemark.titleStr = @"修改手机号";
            addRemark.placeHolder = @"请修改手机号";
            addRemark.limitCount = 11;
            
            [self.navigationController pushViewController:addRemark animated:YES];
        }else if (indexPath.row == 2) {
            
            addRemark.titleStr = @"修改地址";
            addRemark.placeHolder = @"请修改地址";
            addRemark.limitCount = 150;
            
            [self.navigationController pushViewController:addRemark animated:YES];
        }else if (indexPath.row == 3) {
            
            addRemark.titleStr = @"修改简介";
            addRemark.placeHolder = @"请修改简介";
            addRemark.limitCount = 150;
            addRemark.editRemark =self.jianjie;
            [self.navigationController pushViewController:addRemark animated:YES];
        }else if (indexPath.row == 1) {
            
            CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
            picker.delegate = self;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
            [self presentViewController:navc animated:YES completion:nil];
            
        }
    }else{
        
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    
//    [self uploadIconImgRequest];
//    [self UpdateFacilitatorInfo];
    [self uploadSelectImageRequest];//上传封面图
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
    }

}

#pragma mark - YPAddRemarkDelegate
- (void)supplierPersonInfoName:(NSString *)name{
    self.titleName = name;
    if (name.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)supplierPersonInfoPhone:(NSString *)phone{
    self.phone = phone;
    if (phone.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)supplierPersonInfoIntro:(NSString *)intro{
    self.jianjie = intro;
    if (intro.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)hotelInfoAddress:(NSString *)address{
    self.address = address;
    if (address.length > 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{

    self.parentID = parentID;
    
    //6-5 除首页 其他选择地址不保存到本地
    //    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"locationOfSubcity"];
    //    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
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
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,_parentID];
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
            
            self.titleName = self.infoModel.Name;
            
            self.professionID = self.infoModel.Identity;
            self.areaid = self.infoModel.region;
            self.jianjie = self.infoModel.Abstract;
            self.phone = self.infoModel.Phone;
            self.address = self.infoModel.Address;
            
            //6-5
            self.cityInfo = self.infoModel.regionname;
            
            //18-08-30 封面
            self.infoModel.CoverMap = [object objectForKey:@"CoverMap"];

            [self.upXCArray removeAllObjects];
            self.photoManager.localImageList = nil;
            
            if (![self.infoModel.CoverMap isEqualToString:@""]) {//有图
                NSMutableArray *xiangcearr = [NSMutableArray array];
                
                NSArray *array = [self.infoModel.CoverMap componentsSeparatedByString:@","];
                for (NSString *str in array) {
                    NSData* imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                    UIImage* resultImage2 = [UIImage imageWithData: imageData2];
                    [xiangcearr addObject:resultImage2];
                }
                
                self.upXCArray = xiangcearr;
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
    if (self.phone.length > 0) {
        params[@"Phone"] = self.phone;
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
    if (self.address.length > 0) {
        params[@"Address"] = self.address;
    }else{
        params[@"Address"] = @"";
    }
    params[@"CoverMap"] = upXCString;
    
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

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

- (YPGetFacilitatorInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetFacilitatorInfo alloc]init];
    }
    return _infoModel;
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
        self.cityInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
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
