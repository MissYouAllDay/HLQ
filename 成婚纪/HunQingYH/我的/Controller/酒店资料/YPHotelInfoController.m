//
//  YPHotelInfoController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPHotelInfoController.h"
#import "UITextView+WZB.h"
#import "YPHotelInfoIconCell.h"
#import "YPTextNormalCell.h"//自适应
#import "YPAddRemarkController.h"
#import "YPGetRummeryInfo.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择

@interface YPHotelInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YPAddRemarkDelegate,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextView *inputView;

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *jianjie;

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

@property (nonatomic, strong) YPGetRummeryInfo *hotelInfo;

//@property (nonatomic, strong) MBProgressHUD *hud;

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

@implementation YPHotelInfoController{
    UIView *_navView;
    CGFloat _cellHeight;
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
    
    [self GetRummeryInfo];//获取酒店资料
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
    titleLab.text = @"酒店资料";
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        YPHotelInfoIconCell *cell = [YPHotelInfoIconCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.changeBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.iconImgs.count > 0) {
            [cell.iconImgV setImage:self.iconImgs[0]];
        }else{
            [cell.iconImgV setImage:[UIImage imageNamed:@"占位图"]];
        }
        return cell;
        
    }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        
        YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.content.font = kBigFont;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"名称";
            if (self.titleName.length > 0) {
                cell.content.text = self.titleName;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请填写名称";
                cell.content.textColor = GrayColor;
            }
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"电话";
            if (self.phone.length > 0) {
                cell.content.text = self.phone;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请填写手机号";
                cell.content.textColor = GrayColor;
            }
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"地址";
            if (self.address.length > 0) {
                cell.content.text = self.address;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请填写地址";
                cell.content.textColor = GrayColor;
            }
        }else if (indexPath.row == 4) {
            cell.titleLabel.text = @"地区";
            if (self.cityInfo.length > 0) {
                cell.content.text = self.cityInfo;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请选择地区";
                cell.content.textColor = GrayColor;
            }
        }
        return cell;
    }else if (indexPath.row == 5){
        
        //简介
        YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = @"简介";
        cell.content.font = kBigFont;
        if (self.jianjie.length > 0) {
            cell.content.text = self.jianjie;
            cell.content.textColor = BlackColor;
        }else{
            cell.content.text = @"请输入简介";
            cell.content.textColor = GrayColor;
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
    
    YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
    addRemark.remarkDelegate = self;
    
    if (indexPath.row == 1) {
        
        addRemark.titleStr = @"修改名称";
        addRemark.placeHolder = @"请修改名称";
        addRemark.limitCount = 20;
        
        [self.navigationController pushViewController:addRemark animated:YES];
    }else if (indexPath.row == 2) {
        
        addRemark.titleStr = @"修改手机号";
        addRemark.placeHolder = @"请修改手机号";
        addRemark.limitCount = 11;
        
        [self.navigationController pushViewController:addRemark animated:YES];
    }else if (indexPath.row == 3) {
        
        addRemark.titleStr = @"修改地址";
        addRemark.placeHolder = @"请修改地址";
        addRemark.limitCount = 150;
        
        [self.navigationController pushViewController:addRemark animated:YES];
    }else if (indexPath.row == 4){
        
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
        
    }else if (indexPath.row == 5) {
        
        addRemark.titleStr = @"修改简介";
        addRemark.placeHolder = @"请修改简介";
        addRemark.limitCount = 150;
        
        [self.navigationController pushViewController:addRemark animated:YES];
        
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    
    [self uploadIconImgRequest];//先上传图片
}

- (void)addImgBtnClick:(UIButton *)sender{
    //添加图片
    [self takePhoto:sender];
}

#pragma mark - TakePhoto
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
        [self.iconImgs removeAllObjects];
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
        [self.iconImgs removeAllObjects];
        [self LocalPhotoWithTag:actionSheet.tag];
    }
    
}

- (void)openCameraWithTag:(NSInteger)tag{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    
    // 拍照最多个数
    cameraVc.maxCount = 1-self.iconImgs.count;
    
    cameraVc.callback = ^(NSArray *cameras){
        
        //如果之前存有照片 清空
        if (self.iconImgs.count > 0) {
            [self.iconImgs removeAllObjects];
        }
        
        for (int i=0; i<cameras.count; i++) {
            ZLCamera *camera  =[cameras objectAtIndex:i];
            UIImage *image = camera.thumbImage;
            [self.iconImgs addObject:image];
            if (self.iconImgs.count > 1) {
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
    pickerVc.maxCount = 1 - self.iconImgs.count;
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
        [self.iconImgs addObject:image];
        
        //获取图片的ID
        self.iconImgID = [Upload getUUID];
        
        if (self.iconImgs.count > 1) {
            Alertmsg(@"不能超过1张", nil);
            break;
        }
    }
    [self.tableView reloadData];
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
    if (self.iconImgs.count >indexPath.row) {
        [self.iconImgs removeObjectAtIndex:indexPath.row];
    }
    [self.tableView reloadData];
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
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region.db"ofType:@"db"];
    
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

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 150) {
        textView.textColor = [UIColor redColor];
        Alertmsg(@"您输入的字数超出已限制", nil)
    }else{
        textView.textColor = BlackColor;
    }
}

#pragma mark - YPAddRemarkDelegate
- (void)hotelInfoName:(NSString *)title{
    NSLog(@"YPAddRemarkDelegate %@",title);
    
    self.titleName = title;
    if (title.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)supplierPersonInfoPhone:(NSString *)phone{
    self.phone = phone;
    if (phone.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)hotelInfoAddress:(NSString *)address{
    NSLog(@"YPAddRemarkDelegate %@",address);
    
    self.address = address;
    if (address.length > 0) {
        [self.tableView reloadData];
    }
}

- (void)supplierPersonInfoIntro:(NSString *)intro{
    self.jianjie = intro;
    if (intro.length > 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - 网络请求
#pragma mark - 上传图片
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
    imageEntity.imageArray = self.iconImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        NSLog(@"酒店资料 返回：====%@",response);
        
        [self UpRummeryInfoWithIconID:[response objectForKey:@"Inform"]];
    } failurBlock:^(NSError *error) {
//        [self.hud hide:YES];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.iconImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
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

#pragma mark 获取酒店信息
- (void)GetRummeryInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetRummeryInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"RummeryID"] = myRummeryID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
//        [self.hud hide:YES];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.hotelInfo.RummeryID = [object valueForKey:@"RummeryID"];
            self.hotelInfo.Abbreviation = [object valueForKey:@"Abbreviation"];
            self.hotelInfo.RummeryName = [object valueForKey:@"RummeryName"];
            self.hotelInfo.HotelLogo = [object valueForKey:@"HotelLogo"];
            self.hotelInfo.HotelImgs = [object valueForKey:@"HotelImgs"];
            self.hotelInfo.ContactName = [object valueForKey:@"ContactName"];
            self.hotelInfo.ContactPhone = [object valueForKey:@"ContactPhone"];
            self.hotelInfo.Address = [object valueForKey:@"Address"];
            self.hotelInfo.LowestPrice = [object valueForKey:@"LowestPrice"];
            self.hotelInfo.IsStatus = [object valueForKey:@"IsStatus"];
            self.hotelInfo.BriefinTroduction = [object valueForKey:@"BriefinTroduction"];
            self.hotelInfo.Region = [object valueForKey:@"Region"];

            //6-5 添加
            self.hotelInfo.RegionName = [object valueForKey:@"RegionName"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.hotelInfo.HotelLogo]];
            UIImage *img = [UIImage imageWithData:data];
            if (img) {
                [self.iconImgs removeAllObjects];//移除前一个图片 否则保存两张
                [self.iconImgs addObject:img];
            }
            
            self.titleName = self.hotelInfo.RummeryName;
            self.phone = self.hotelInfo.ContactPhone;
            self.address = self.hotelInfo.Address;
            self.jianjie = self.hotelInfo.BriefinTroduction;
            self.areaid = self.hotelInfo.Region;
            
            //6-5
            self.cityInfo = self.hotelInfo.RegionName;
            
//            [self selectDataBase];
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

#pragma mark 修改酒店信息
- (void)UpRummeryInfoWithIconID:(NSString *)iconID{

    NSString *url = @"/api/HQOAApi/UpRummeryInfo";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"RummeryID"] = myRummeryID;
    params[@"Abbreviation"] = @"";
    params[@"RummeryName"] = self.titleName;
    params[@"HotelLogo"] = iconID;
    params[@"HotelImgs"] = @"";
    params[@"ContactName"] = @"";
    params[@"ContactPhone"] = self.phone;
    params[@"Address"] = self.address;
    params[@"LowestPrice"] = @"0";
    params[@"BriefinTroduction"] = self.jianjie;
    params[@"Region"] = self.areaid;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
//        [self.hud hide:YES];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
            [self GetRummeryInfo];//重新获取数据
            
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
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

- (UITextView *)inputView{
    if (!_inputView) {
        _inputView = [[UITextView alloc]init];
        // 设置文本框占位图文字
        _inputView.wzb_placeholder = @"请输入简介(不超过150字)";
        _inputView.wzb_placeholderColor = LightGrayColor;
        _inputView.font = kBigFont;
        _inputView.wzb_minHeight = 50;
        _inputView.delegate = self;
    }
    return _inputView;
}

- (YPGetRummeryInfo *)hotelInfo{
    if (!_hotelInfo) {
        _hotelInfo = [[YPGetRummeryInfo alloc]init];
    }
    return _hotelInfo;
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

//- (MBProgressHUD *)hud{
//    if (!_hud) {
//        _hud = [[MBProgressHUD alloc]init];
//    }
//    return _hud;
//}

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
