//
//  YPRegistLicenceController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPRegistLicenceController.h"
#import "YPIDCardImgCell.h"
#import "YPLicenceImgCell.h"
#import "YPCheckInCarController.h"//登记车辆
#import "YPNewPassWordController.h"//设置新密码

@interface YPRegistLicenceController ()<UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

///身份证正面照
@property (nonatomic, strong) NSMutableArray *idZhengImgs;
@property (nonatomic, copy) NSString *idZhengImgID;
///身份证反面照
@property (nonatomic, strong) NSMutableArray *idFanImgs;
@property (nonatomic, copy) NSString *idFanImgID;
///手持身份证照
@property (nonatomic, strong) NSMutableArray *handImgs;
@property (nonatomic, copy) NSString *handImgID;
///驾照
@property (nonatomic, strong) NSMutableArray *licenceImgs;
@property (nonatomic, copy) NSString *licenceImgID;

//记录点击的是哪个按钮
@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation YPRegistLicenceController{
    UIView *_navView;
    NSMutableString *_nameString;//上传的图片字符串
//    MBProgressHUD *hud;
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
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    [self.view addSubview:self.tableView];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"身份验证";
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
    
    //确定按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 10;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (CheShou(self.profession) || JiuDian(self.profession)){
        return 2;//婚车-驾照+身份证  酒店-身份证+执照
    }else{
        return 1;//其他-只有身份证
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (CheShou(self.profession) || JiuDian(self.profession)) {
        if (indexPath.row == 0) {
            YPIDCardImgCell *cell = [YPIDCardImgCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.zhengBtn.tag = 1000;
            cell.fanBtn.tag   = 1001;
            cell.handBtn.tag  = 1002;
            
            [cell.zhengBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.fanBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.handBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.idZhengImgs.count > 0) {
                [cell.zhengBtn setImage:self.idZhengImgs[0] forState:UIControlStateNormal];
                cell.zhengBtn.selected = YES;
            }else{
                [cell.zhengBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
                cell.zhengBtn.selected = NO;
            }
            
            if (self.idFanImgs.count > 0) {
                [cell.fanBtn setImage:self.idFanImgs[0] forState:UIControlStateNormal];
                cell.fanBtn.selected = YES;
            }else{
                [cell.fanBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
                cell.fanBtn.selected = NO;
            }
            
            if (self.handImgs.count > 0) {
                [cell.handBtn setImage:self.handImgs[0] forState:UIControlStateNormal];
                cell.handBtn.selected = YES;
            }else{
                [cell.handBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
                cell.handBtn.selected = NO;
            }
            return cell;
            
        }else if (indexPath.row == 1) {
            
            YPLicenceImgCell *cell = [YPLicenceImgCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (CheShou(self.profession)) {
                cell.titleLabel.text = @"上传驾照(必填)";
            }else if (JiuDian(self.profession)){
                cell.titleLabel.text = @"上传营业执照(必填)";
            }
            
            cell.licenceBtn.tag = 2000;
            
            [cell.licenceBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.licenceImgs.count > 0) {
                [cell.licenceBtn setImage:self.licenceImgs[0] forState:UIControlStateNormal];
                cell.licenceBtn.selected = YES;
            }else{
                if (CheShou(self.profession)) {
                    [cell.licenceBtn setImage:[UIImage imageNamed:@"驾照"] forState:UIControlStateNormal];
                }else if (JiuDian(self.profession)){
                    [cell.licenceBtn setImage:[UIImage imageNamed:@"执照"] forState:UIControlStateNormal];
                }
                cell.licenceBtn.selected = NO;
            }
            return cell;
        }
    }else{
        
        YPIDCardImgCell *cell = [YPIDCardImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.zhengBtn.tag = 4000;
        cell.fanBtn.tag   = 4001;
        cell.handBtn.tag  = 4002;
        
        [cell.zhengBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fanBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.handBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.idZhengImgs.count > 0) {
            [cell.zhengBtn setImage:self.idZhengImgs[0] forState:UIControlStateNormal];
            cell.zhengBtn.selected = YES;
        }else{
            [cell.zhengBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.zhengBtn.selected = NO;
        }
        
        if (self.idFanImgs.count > 0) {
            [cell.fanBtn setImage:self.idFanImgs[0] forState:UIControlStateNormal];
            cell.fanBtn.selected = YES;
        }else{
            [cell.fanBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.fanBtn.selected = NO;
        }
        
        if (self.handImgs.count > 0) {
            [cell.handBtn setImage:self.handImgs[0] forState:UIControlStateNormal];
            cell.handBtn.selected = YES;
        }else{
            [cell.handBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.handBtn.selected = NO;
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
}

#pragma mark - 按钮点击事件
- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
//    if (!self.idZhengImgs[0]) {
//        Alertmsg(@"请上传身份证正面照", nil)
//    }else if (!self.idFanImgs[0]) {
//        Alertmsg(@"请上传身份证反面照", nil)
//    }else if (!self.handImgs[0]){
//        Alertmsg(@"请上传手持身份证照", nil)
//    }else{
    
        //上传身份证照
        [self uploadZhengImageRequest];

//    }
}

- (void)addImgBtnClick:(UIButton *)sender{
    
    self.currentTag = sender.tag;
    
    if (sender.tag == 1000 || sender.tag == 4000) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.idZhengImgs];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }else if (sender.tag == 1001 || sender.tag == 4001) {
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.idFanImgs];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }else if (sender.tag == 1002 || sender.tag == 4002) {
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.handImgs];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }else if (sender.tag == 2000) {//2000:婚车
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.licenceImgs];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
        [self LocalPhotoWithTag:actionSheet.tag];
    }
    
}

- (void)openCameraWithTag:(NSInteger)tag{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    
    if (tag == 1000 || tag == 4000) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        // 拍照最多个数
        cameraVc.maxCount = 1-self.idZhengImgs.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.idZhengImgs.count > 0) {
                [self.idZhengImgs removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.idZhengImgs addObject:image];
                if (self.idZhengImgs.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }else if (tag == 1001 || tag == 4001) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        // 拍照最多个数
        cameraVc.maxCount = 1-self.idFanImgs.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.idFanImgs.count > 0) {
                [self.idFanImgs removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.idFanImgs addObject:image];
                if (self.idFanImgs.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }else if (tag == 1002 || tag == 4002) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        // 拍照最多个数
        cameraVc.maxCount = 1-self.handImgs.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.handImgs.count > 0) {
                [self.handImgs removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.handImgs addObject:image];
                if (self.handImgs.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }else if (tag == 2000) {//2000:婚车
        // 拍照最多个数
        cameraVc.maxCount = 1-self.licenceImgs.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.licenceImgs.count > 0) {
                [self.licenceImgs removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.licenceImgs addObject:image];
                if (self.licenceImgs.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }
    
    [cameraVc showPickerVc:self];
}

- (void)LocalPhotoWithTag:(NSInteger)tag{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    if (tag == 1000 || tag == 4000) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        pickerVc.maxCount = 1 - self.idZhengImgs.count;
    }else if (tag == 1001 || tag == 4001) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        pickerVc.maxCount = 1 - self.idFanImgs.count;
    }else if (tag == 1002 || tag == 4002) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        pickerVc.maxCount = 1 - self.handImgs.count;
    }else if (tag == 2000) {//2000:婚车
        pickerVc.maxCount = 1 - self.licenceImgs.count;
    }
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
        
        if (self.currentTag == 1000 || self.currentTag == 4000) {// 1000/1/2:婚车/酒店  4000/1/2:其他
            [self.idZhengImgs addObject:image];
            
            //获取图片的ID
//            self.idZhengImgID = [Upload getUUID];
            
            if (self.idZhengImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }else if (self.currentTag == 1001 || self.currentTag == 4001) {// 1000/1/2:婚车/酒店  4000/1/2:其他
            [self.idFanImgs addObject:image];
            
            //获取图片的ID
//            self.idFanImgID = [Upload getUUID];
            
            if (self.idFanImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }else if (self.currentTag == 1002 || self.currentTag == 4002) {// 1000/1/2:婚车/酒店  4000/1/2:其他
            [self.handImgs addObject:image];
            
            //获取图片的ID
//            self.handImgID = [Upload getUUID];
            
            if (self.handImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }else if (self.currentTag == 2000) {//2000:婚车
            [self.licenceImgs addObject:image];
            
            //获取图片的ID
//            self.licenceImgID = [Upload getUUID];
            
            if (self.licenceImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
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
    
    if (self.currentTag == 1000 || self.currentTag == 4000) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        if (self.idZhengImgs.count >indexPath.row) {
            [self.idZhengImgs removeObjectAtIndex:indexPath.row];
        }
    }else if (self.currentTag == 1001 || self.currentTag == 4001) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        if (self.idFanImgs.count >indexPath.row) {
            [self.idFanImgs removeObjectAtIndex:indexPath.row];
        }
    }else if (self.currentTag == 1002 || self.currentTag == 4002) {// 1000/1/2:婚车/酒店  4000/1/2:其他
        if (self.handImgs.count >indexPath.row) {
            [self.handImgs removeObjectAtIndex:indexPath.row];
        }
    }else if (self.currentTag == 2000) {//2000:婚车
        if (self.licenceImgs.count >indexPath.row) {
            [self.licenceImgs removeObjectAtIndex:indexPath.row];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 上传图片
#pragma mark 上传正面照
-(void)uploadZhengImageRequest{
    
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
    imageEntity.imageArray = self.idZhengImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"正面照返回：====%@",response);
            self.idZhengImgID = [response objectForKey:@"Inform"];
            
            [self uploadFanImageRequest];//上传反面照
            
        });
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.idZhengImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//
//
//
//    } failurBlock:^(NSError *error) {
//
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
}

#pragma mark 上传反面照
-(void)uploadFanImageRequest{

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
    imageEntity.imageArray = self.idFanImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"反面照返回：====%@",response);
            self.idFanImgID = [response objectForKey:@"Inform"];
            
            [self uploadHandImageRequest];//上传手持照
        });
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.idFanImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//
//
//
//    } failurBlock:^(NSError *error) {
//
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
}

#pragma mark 上传手持照
-(void)uploadHandImageRequest{
    
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
    imageEntity.imageArray = self.handImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"手持照返回：====%@",response);
        self.handImgID = [response objectForKey:@"Inform"];
        
        if (CheShou(self.profession) || JiuDian(self.profession)) {//车手 - 驾照  /  酒店 - 身份证 + 执照
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //上传其他照
                [self uploadOtherImageRequest];//上传其他照
            });
            
            
            
        }else{//其他职业 不需要其他照片  直接设置密码
            
            YPNewPassWordController *newPWD = [[YPNewPassWordController alloc]init];
            newPWD.titleStr = @"设置密码";
            newPWD.setType = @"2";//1-忘记密码 , 2-注册
            
            newPWD.phoneNo = self.phoneNo;
            newPWD.authCodeID = self.authCodeID;
            newPWD.profession = self.profession;
            newPWD.iconID = self.iconID;
            newPWD.shopName = self.shopName;
            newPWD.addressID = self.addressID;
            
            newPWD.address = self.address;//只有酒店有
            
            newPWD.idCardFrontID = self.idZhengImgID;
            newPWD.idCardFanID = self.idFanImgID;
            newPWD.handIDCardID = self.handImgID;
            
            [self.navigationController pushViewController:newPWD animated:YES];
        }
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.handImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
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

#pragma mark 上传其他照
-(void)uploadOtherImageRequest{
    
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
    imageEntity.imageArray = self.licenceImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"其他照返回：====%@",response);
        self.licenceImgID = [response objectForKey:@"Inform"];
        
        if (JiuDian(self.profession)) {//酒店
            YPNewPassWordController *newPWD = [[YPNewPassWordController alloc]init];
            newPWD.titleStr = @"设置密码";
            newPWD.setType = @"2";//1-忘记密码 , 2-注册
            
            newPWD.phoneNo = self.phoneNo;
            newPWD.authCodeID = self.authCodeID;
            newPWD.profession = self.profession;
            newPWD.iconID = self.iconID;
            newPWD.shopName = self.shopName;
            newPWD.addressID = self.addressID;
            
            newPWD.address = self.address;//只有酒店有
            
            newPWD.idCardFrontID = self.idZhengImgID;
            newPWD.idCardFanID = self.idFanImgID;
            newPWD.handIDCardID = self.handImgID;
            newPWD.otherCardID = self.licenceImgID;
            
            [self.navigationController pushViewController:newPWD animated:YES];
        }else if (CheShou(self.profession)){//车手
            
            YPCheckInCarController *check = [[YPCheckInCarController alloc]init];
            check.profession = self.profession;
            check.phoneNo = self.phoneNo;
            check.authCodeID = self.authCodeID;
            check.iconID = self.iconID;
            check.shopName = self.shopName;
            check.addressID = self.addressID;
            
            check.idCardFrontID = self.idZhengImgID;
            check.idCardFanID = self.idFanImgID;
            check.handIDCardID = self.handImgID;
            check.otherCardID = self.licenceImgID;
            
            [self.navigationController pushViewController:check animated:YES];
        }
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.licenceImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
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
- (NSMutableArray *)idZhengImgs{
    if (!_idZhengImgs) {
        _idZhengImgs = [NSMutableArray array];
    }
    return _idZhengImgs;
}

- (NSMutableArray *)idFanImgs{
    if (!_idFanImgs) {
        _idFanImgs = [NSMutableArray array];
    }
    return _idFanImgs;
}

- (NSMutableArray *)handImgs{
    if (!_handImgs) {
        _handImgs = [NSMutableArray array];
    }
    return _handImgs;
}

- (NSMutableArray *)licenceImgs{
    if (!_licenceImgs) {
        _licenceImgs = [NSMutableArray array];
    }
    return _licenceImgs;
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
