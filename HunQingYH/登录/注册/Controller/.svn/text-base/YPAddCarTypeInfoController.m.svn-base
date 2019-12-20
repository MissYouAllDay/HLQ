//
//  YPAddCarTypeInfoController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddCarTypeInfoController.h"
#import "YPInputNormalCell.h"
#import "YPRegisterImgCell.h"
#import "YPCheckInCarController.h"

@interface YPAddCarTypeInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *pinpaiTF;
@property (nonatomic, strong) UITextField *xinghaoTF;
@property (nonatomic, strong) UITextField *colorTF;

@property (nonatomic, copy) NSString *xinghao;
@property (nonatomic, copy) NSString *color;

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

//@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation YPAddCarTypeInfoController{
    UIView *_navView;
    NSMutableString *_nameString;//上传的图片字符串
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
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
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
    titleLab.text = @"添加车辆";
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPInputNormalCell *cell = [YPInputNormalCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        YPRegisterImgCell *cell = [YPRegisterImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ImgBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.nameLabel.text = @"上传车图";
        cell.nameLabel.textColor = GrayColor;
        
        if (self.iconImgs.count > 0) {
            [cell.ImgBtn setImage:self.iconImgs[0] forState:UIControlStateNormal];
            cell.ImgBtn.selected = YES;
        }else{
            [cell.ImgBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.ImgBtn.selected = NO;
        }
        return cell;
        
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"品牌";
        cell.inputTF.text = self.carBrand;
        cell.inputTF.enabled = NO;
        self.pinpaiTF = cell.inputTF;
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"型号";
        if (self.xinghao.length > 0) {
            cell.inputTF.text = self.xinghao;
        }else{
            cell.inputTF.placeholder = @"请输入型号";
        }
        cell.inputTF.delegate = self;
        self.xinghaoTF = cell.inputTF;
    }else if (indexPath.row == 3) {
        cell.titleLabel.text = @"颜色";
        
        if (self.color.length > 0) {
            cell.inputTF.text = self.color;
        }else{
            cell.inputTF.placeholder = @"请输入颜色";
        }
        cell.inputTF.delegate = self;
        self.colorTF = cell.inputTF;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 130;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        //确定按钮
        UIButton *sureBtn = [[UIButton alloc] init];
        [sureBtn setBackgroundColor:NavBarColor];
        [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
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
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");

    [self uploadIconImgRequest];
    
//    UIViewController *mineVC = nil;
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        //遍历
//        if([controller isKindOfClass:[YPCheckInCarController class]]){
//            //这里判断是否为你想要跳转的页面
//            mineVC = controller;
//            break;
//        }
//    }
//    [self.navigationController popToViewController:mineVC  animated:YES];
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
//        self.iconImgID = [Upload getUUID];
        
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

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.xinghaoTF || textField == self.colorTF) {
        if (self.pinpaiTF.text.length > 0 || self.carBrand.length > 0) {
            
        }else{
            [self.pinpaiTF becomeFirstResponder];
            Alertmsg(@"请先填写品牌", nil)
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.xinghaoTF) {
        self.xinghao = textField.text;
    }else if (textField == self.colorTF){
        self.color = textField.text;
    }
}

#pragma mark -------网络请求----------
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
        NSLog(@"添加车型图 编辑资料 返回：====%@",response);
        
        [self AddCarModelWithCarImgID:[response objectForKey:@"Inform"]];
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

#pragma mark 添加车型
-(void)AddCarModelWithCarImgID:(NSString *)imgID{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddCarModel";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CarModelID"] = self.carBrandID;//1、添加品牌 ；品牌ID添加型号
    params[@"Name"] = self.xinghaoTF.text;
    params[@"CarImg"] = imgID;
    params[@"CarColour"] = self.colorTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"AddCarModel ---- success");
            
//            UIViewController *mineVC = nil;
//            for (UIViewController * controller in self.navigationController.viewControllers) {
//                //遍历
//                if([controller isKindOfClass:[YPCheckInCarController class]]){
//                    //这里判断是否为你想要跳转的页面
//                    mineVC = controller;
//                    break;
//                }
//            }
//            [self.navigationController popToViewController:mineVC  animated:YES];
            
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
