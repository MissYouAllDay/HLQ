//
//  YPRegistStep2Controller.m
//  hunqing
//
//  Created by YanpengLee on 2017/5/12.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegistStep2Controller.h"
#import "YPRegisterInputCell.h"
#import "YPRegisterImgCell.h"
#import "YPRegisterProtocolCell.h"
#import "YPRegisterSelectCell.h"
#import "YPRegisterStep3Controller.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
#import <BANetManager.h>

@interface YPRegistStep2Controller ()<UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *currentIndex;//选取图片的cell索引

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger  parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;

/**组织结构代码*/
@property (nonatomic, strong) UITextField *origIDTF;
/**公司名称*/
@property (nonatomic, strong) UITextField *comNameTF;
/**公司别名*/
@property (nonatomic, strong) UITextField *comAliasTF;
/**负责人姓名*/
@property (nonatomic, strong) UITextField *manNameTF;
/**负责人电话*/
@property (nonatomic, strong) UITextField *manPhoneTF;
/**用户名*/
@property (nonatomic, strong) UITextField *userNameTF;
/**详细地址*/
@property (nonatomic, strong) UITextField *addressTF;

@end

@implementation YPRegistStep2Controller{
//    NSMutableString *_nameString;//上传的图片字符串
    //数据库
    FMDatabase *dataBase;
    UIView *_navView;
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
    
    self.title = @"注册信息";
    
    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"注册";
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

- (UIView *)addFooterView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    [self.view addSubview:view];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(view).mas_offset(50);
        make.height.mas_equalTo(45);
    }];
    
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPRegisterInputCell *cell = [YPRegisterInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"营业执照号:";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入18位营业执照代码" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.origIDTF = cell.inputTF;
        
    }else if (indexPath.row == 1) {
        cell.nameLabel.text = @"公司名称:";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"如青岛唯爱牵手文化传播有限公司" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.comNameTF = cell.inputTF;
        
    }else if (indexPath.row == 2) {
        cell.nameLabel.text = @"公司别名:";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"如牵手婚庆(选填)" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.comAliasTF = cell.inputTF;
        
    }else if (indexPath.row == 3) {
        cell.nameLabel.text = @"负责人姓名:";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入负责人姓名" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.manNameTF = cell.inputTF;
        
    }else if (indexPath.row == 4) {
        cell.nameLabel.text = @"负责人电话:";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入负责人电话" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.manPhoneTF = cell.inputTF;
        
    }else if (indexPath.row == 5) {
        cell.nameLabel.text = @"用户名";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"汉字、字母、数字组合" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.userNameTF = cell.inputTF;
        
    }else if (indexPath.row == 6) {
        cell.nameLabel.text = @"详细地址";
        cell.inputTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入详细地址" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        self.userNameTF = cell.inputTF;
        self.addressTF = cell.inputTF;
        
    }else if (indexPath.row == 7) {
        //地址ID
        YPRegisterSelectCell *cell = [YPRegisterSelectCell cellWithTableView:tableView];
        if (self.cityInfo.length == 0) {
            cell.selectLabel.text = @"青岛市黄岛区";
        }else{
            cell.selectLabel.text = self.cityInfo;
        }
        return cell;
        
    }else if (indexPath.row == 8) {
        
        YPRegisterImgCell *cell = [YPRegisterImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ImgBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        //保存当前indexpath
        self.currentIndex = indexPath;
        
        if (self.iconImgs.count > 0) {
            [cell.ImgBtn setImage:self.iconImgs[0] forState:UIControlStateNormal];
            cell.ImgBtn.selected = YES;
        }else{
            [cell.ImgBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.ImgBtn.selected = NO;
        }
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 8) {
        return 130;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 100;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [self addFooterView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 7) {
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
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

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addImgBtnClick:(UIButton *)sender{
    if (sender.selected) {
        //展示图片
        [self showPhotoBrowser:self.iconImgs];
    }else{
        //添加图片
        [self takePhoto:sender];
    }
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.iconImgs.count == 0) {
        Alertmsg(@"请添加图片", nil)
    }else if (self.origIDTF.text.length == 0 || self.comNameTF.text.length == 0 || self.manNameTF.text.length == 0 || self.manPhoneTF.text.length == 0 || self.addressTF.text.length == 0) {
        Alertmsg(@"请填写完整注册信息", nil)
    }else{
        //上传图片
//        [self uploadImgs:self.iconImgID andImg:self.iconImgs[0]];

         [EasyShowLodingView showLoding];


        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
        [dict setValue:@"2" forKey:@"os"];
        [dict setValue:@"0" forKey:@"ot"];
        if (UserId_New) {
            [dict setValue:UserId_New forKey:@"oi"];
        }else{
            [dict setValue:@"0" forKey:@"oi"];
        }
        [dict setValue:@"2" forKey:@"t"];

        BAImageDataEntity *imageEntity = [BAImageDataEntity new];
        imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
        imageEntity.needCache = NO;
        imageEntity.parameters = dict;
        imageEntity.imageArray = self.iconImgs;
        imageEntity.imageType = @"png";
        imageEntity.imageScale = 0;
        imageEntity.fileNames = nil;

        [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {

            self.iconImgID = [response objectForKey:@"Inform"];

            YPRegisterStep3Controller *step3 = [[YPRegisterStep3Controller alloc]init];
            step3.origID        = self.origIDTF.text;
            step3.comName       = self.comNameTF.text;
            step3.comAlias      = self.comAliasTF.text;
            step3.manName       = self.manNameTF.text;
            step3.manPhone      = self.manPhoneTF.text;
            step3.userName      = self.userNameTF.text;
            step3.address       = self.addressTF.text;
            if (self.areaid.length == 0) {
                step3.areaId    = @"1740";
            }else{
                step3.areaId    = self.areaid;
            }
            step3.licenseID     = self.iconImgID;
            step3.phone         = self.phone;
            step3.AuthCodeID    = self.AuthCodeID;
            [self.navigationController pushViewController:step3 animated:YES];

        } failurBlock:^(NSError *error) {
            // 菊花不会自动消失，需要自己移除
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            // 菊花不会自动消失，需要自己移除
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
        }];
    }
    
//    YPRegisterStep3Controller *step3 = [[YPRegisterStep3Controller alloc]init];
//    [self.navigationController pushViewController:step3 animated:YES];
}

//#pragma mark 上传图片相关
//-(void)uploadImgs:(NSString *)name andImg:(UIImage *)image{
//    _nameString=[[NSMutableString alloc]initWithString:@""];
//    
//    NSString *name2 =[NSString stringWithFormat:@"%@.jpg",name];
//    [Upload upload:image GUID:name2 type:@"1"];
//    NSLog(@"%@",name);
//    [_nameString appendString:[name stringByAppendingString:@","]];
//    
//}

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
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
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
            [self.tableView reloadRowsAtIndexPaths:@[self.currentIndex] withRowAnimation:UITableViewRowAnimationNone];
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
    [self.tableView reloadRowsAtIndexPaths:@[self.currentIndex] withRowAnimation:UITableViewRowAnimationNone];
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
    [self.tableView reloadRowsAtIndexPaths:@[self.currentIndex] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

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
