//
//  YPEditMyCarController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPEditMyCarController.h"
#import "YPEditMyCarTextCell.h"
#import "YPEditMyCarImgCell.h"
#import "YPCarBrandController.h"//车辆品牌
#import "YPCarTypeController.h"//车系
#import "YPSelectNormalCell.h"
#import "YPMyCarJianJieImgCell.h"//车图不能修改 9.15

@interface YPEditMyCarController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,YPCarBrandDelegate,YPCarTypeDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation YPEditMyCarController{
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
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的车辆";
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
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"完成" forState:UIControlStateNormal];
    [moreBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
//        YPEditMyCarImgCell *cell = [YPEditMyCarImgCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.titleLabel.text = @"展示";
//        
//        [cell.addImgBtn addTarget:self action:@selector(addImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        if (self.iconImgs.count > 0) {
//            [cell.addImgBtn setImage:self.iconImgs[0] forState:UIControlStateNormal];
//            cell.addImgBtn.selected = YES;
//        }else{
//            [cell.addImgBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
//            cell.addImgBtn.selected = NO;
//        }
//        return cell;
        
        YPMyCarJianJieImgCell *cell = [YPMyCarJianJieImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"展示";
        
        if (self.iconImgs.count > 0) {
            cell.iconImgV.image = self.iconImgs[0];
        }else{
            cell.iconImgV.image = [UIImage imageNamed:@"占位图"];
        }
        
        return cell;
        
    }else{
        
        YPSelectNormalCell *cell = [YPSelectNormalCell cellWithTableView:tableView];
        
        cell.titleLabel.textColor = BlackColor;
        
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"品牌";
            
            if (self.carBrand.length > 0) {
                cell.descLabel.text = self.carBrand;
            }
            
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"型号";
            
            if (self.carType.length > 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"%@ - %@",self.carType,self.carColor];
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
    
    if (indexPath.row == 1) {
        
        YPCarBrandController *carBrand = [[YPCarBrandController alloc]init];
        carBrand.brandDelegate = self;
        [self.navigationController pushViewController:carBrand animated:YES];
        
    }else if (indexPath.row == 2) {
        
        if (self.carBrand.length > 0) {
            YPCarTypeController *carType = [[YPCarTypeController alloc]init];
            carType.carTypeDelegate = self;
            carType.titleStr = self.carBrand;
            carType.carModelID = self.carBrandID;
            [self.navigationController pushViewController:carType animated:YES];
        }else{
            Alertmsg(@"请先选择品牌", nil)
        }
        
    }
}

#pragma mark - target
//- (void)addImgBtnClick:(UIButton *)sender{
//    if (sender.selected) {
//        //展示图片
//        [self showPhotoBrowser:self.iconImgs];
//    }else{
//        //添加图片
//        [self takePhoto:sender];
//    }
//}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"完成");
    
    [self UpUserInfo];
}

//#pragma mark - TakePhoto
//- (void)takePhoto:(UIButton *)sender {
//    
//    NSLog(@"takephoto");
//    UIActionSheet *actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//    actionsheet.tag = sender.tag;
//    [actionsheet showInView:self.view];
//    
//}
//
//#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    if (buttonIndex==0) {
//        [self openCameraWithTag:actionSheet.tag];
//    }else if (buttonIndex==1)
//    {
//        [self LocalPhotoWithTag:actionSheet.tag];
//    }
//    
//}
//
//- (void)openCameraWithTag:(NSInteger)tag{
//    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
//    
//    // 拍照最多个数
//    cameraVc.maxCount = 1-self.iconImgs.count;
//    
//    cameraVc.callback = ^(NSArray *cameras){
//        
//        //如果之前存有照片 清空
//        if (self.iconImgs.count > 0) {
//            [self.iconImgs removeAllObjects];
//        }
//        
//        for (int i=0; i<cameras.count; i++) {
//            ZLCamera *camera  =[cameras objectAtIndex:i];
//            UIImage *image = camera.thumbImage;
//            [self.iconImgs addObject:image];
//            if (self.iconImgs.count > 1) {
//                Alertmsg(@"不能超过1张", nil);
//                break;
//            }
//            [self.tableView reloadData];
//        }
//    };
//    
//    [cameraVc showPickerVc:self];
//}
//
//- (void)LocalPhotoWithTag:(NSInteger)tag{
//    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
//    // 默认显示相册里面的内容SavePhotos
//    pickerVc.status = PickerViewShowStatusCameraRoll;
//    pickerVc.maxCount = 1 - self.iconImgs.count;
//    pickerVc.delegate = self;
//    [pickerVc showPickerVc:self];
//}
//
//// 代理回调方法
//#pragma mark - 相册回调
//- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
//    //    _lastSelectedAssets=assets;
//    for (int i=0; i<assets.count; i++) {
//        ZLPhotoAssets *camera  =[assets objectAtIndex:i];
//        UIImage *image = camera.originImage;
//        [self.iconImgs addObject:image];
//        
//        //获取图片的ID
////        self.iconImgID = [Upload getUUID];
//        
//        if (self.iconImgs.count > 1) {
//            Alertmsg(@"不能超过1张", nil);
//            break;
//        }
//    }
//    [self.tableView reloadData];
//}
//
////图片浏览器
//-(void)showPhotoBrowser:(NSMutableArray *)imgsMarr{
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    // 图片游览器
//    
//    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
//    // 淡入淡出效果
//    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
//    // 数据源/delegate
//    pickerBrowser.editing = YES;
//    NSMutableArray *photos = [[NSMutableArray alloc]initWithCapacity:imgsMarr.count];
//    for (int i = 0; i < imgsMarr.count; i ++) {
//        ZLPhotoPickerBrowserPhoto *photo=[ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:[imgsMarr objectAtIndex:i]];
//        [photos addObject:photo];
//        
//    }
//    pickerBrowser.photos = photos;
//    // 能够删除
//    pickerBrowser.delegate = self;
//    // 当前选中的值
//    pickerBrowser.currentIndexPath = indexPath;
//    // 展示控制器
//    [pickerBrowser showPickerVc:self];
//}
//
//- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"走方法");
//    if (self.iconImgs.count >indexPath.row) {
//        [self.iconImgs removeObjectAtIndex:indexPath.row];
//    }
//    [self.tableView reloadData];
//}

#pragma mark - YPCarBrandDelegate
- (void)carBrand:(NSString *)carBrand andCarModelID:(NSString *)carID{
    self.carBrand = carBrand;
    self.carBrandID = carID;
    
    [self.tableView reloadData];
}

#pragma mark - YPCarTypeDelegate
- (void)carType:(NSString *)carType andCarModelID:(NSString *)carID andCarColor:(NSString *)carColor{
    self.carType = carType;
    self.carTypeID = carID;
    self.carColor = carColor;
    
    [self.tableView reloadData];
}

#pragma mark - 网络请求
//#pragma mark - 上传图片 -- 不能修改车型图片
//-(void)uploadIconImgRequest{
//    
//    if (!self.hud) {
//        self.hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
//    }
//
//    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
//    [fmdict setValue:@"2" forKey:@"os"];//0惠约、1汇码、2婚庆、3减肥
//    [fmdict setValue:@"0" forKey:@"ot"];//0用户图、1公司、2平台
//    [fmdict setValue:UserId_New forKey:@"oi"];
//    [fmdict setValue:@"2" forKey:@"t"];//用户：1认证相关、2功能相关、3其他
//    
//    [BANetManager ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.iconImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//        
//        NSLog(@"我的车辆 编辑资料 返回：====%@",response);
//        
//        [self UpUserInfoWithIconID:[response objectForKey:@"Inform"]];
//        
//    } failurBlock:^(NSError *error) {
//        
//        [self.hud hide:YES];
//        
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.hud removeFromSuperview];
//        });
//        
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        
//    }];
//    
//}

#pragma mark 用户修改自己详细信息
- (void)UpUserInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"TrueName"] = @"";
    params[@"Headportrait"] = @"";
    params[@"Age"] = @"0";
    params[@"ModelID"] = self.carTypeID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
//        [self.hud hide:YES];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
            if ([self.editDelegate respondsToSelector:@selector(editMyCarWithCarModelID:)]) {
                [self.editDelegate editMyCarWithCarModelID:self.carTypeID];
            }
            
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

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
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
