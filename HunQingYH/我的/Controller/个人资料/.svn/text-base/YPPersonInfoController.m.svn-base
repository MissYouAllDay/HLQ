//
//  YPPersonInfoController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//
/** 用户/车手  非供应商  只显示 昵称 头像 */

#import "YPPersonInfoController.h"
#import "YPHotelInfoIconCell.h"
#import "YPNormalTextCell.h"
#import "YPAddRemarkController.h"
#import "YPGetUserInfo.h"

@interface YPPersonInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YPAddRemarkDelegate,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextView *inputView;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

@property (nonatomic, strong) YPGetUserInfo *userInfo;

@end

@implementation YPPersonInfoController{
    UIView *_navView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
 
    [self GetUserFacilitatorInfo];
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
    titleLab.text = @"个人资料";
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
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (YongHu(Profession_New)) {
        return 3;
    }else{
        return 2;
    }
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
        
    }else if (indexPath.row == 1 || indexPath.row == 2){
        
        YPNormalTextCell *cell = [YPNormalTextCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            if (self.titleName.length > 0) {
                cell.content.text = self.titleName;
                cell.content.textColor = BlackColor;
            }else{
                cell.content.text = @"请填写昵称";
                cell.content.textColor = GrayColor;
            }
        }else if (indexPath.row == 2) {//18-11-02 用户添加婚期
            cell.titleLabel.text = @"婚期";
            if (self.dateStr.length > 0) {
                cell.content.text = self.dateStr;
            }else{
                NSString *str = Wedding_New;
                if (str.length > 0) {
                    cell.content.text = Wedding_New;
                }else{
                    cell.content.text = @"请选择婚期";
                }
            }
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1 || indexPath.row == 2){
        
        return 50;
    }else{
        return 190;
    }
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
        addRemark.editRemark = self.titleName;
        addRemark.limitCount = 20;
        
        [self.navigationController pushViewController:addRemark animated:YES];
    }
    else if (indexPath.row == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (!self.datePicker) {
            self.datePicker = [[UIDatePicker alloc]init];
        }
        //设置地区: zh-中国
        self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [self.datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最小时间（此处为当前时间）
        [self.datePicker setMinimumDate:[NSDate date]];
        [alert.view addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(alert.view);
        }];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            //实例化一个NSDateFormatter对象
            [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
            NSString *dateString = [dateFormat stringFromDate:self.datePicker.date];
            //求出当天的时间字符串
            NSLog(@"%@",dateString);
            self.dateStr = dateString;
            
            [self.tableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    
    [self uploadIconImgRequest];
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

#pragma mark - YPAddRemarkDelegate
- (void)hotelInfoName:(NSString *)title{
    NSLog(@"YPAddRemarkDelegate %@",title);
    
    self.titleName = title;
    if (title.length > 0) {
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
        
        NSLog(@"个人资料 返回：====%@",response);
        
        [self UpdateUserInfoWithIconID:[response objectForKey:@"Inform"]];
        
    } failurBlock:^(NSError *error) {
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];

//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.iconImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//        
//        NSLog(@"个人资料 返回：====%@",response);
//        
//        [self UpUserInfoWithIconID:[response objectForKey:@"Inform"]];
//        
//    } failurBlock:^(NSError *error) {
//        
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        
//    }];
    
}

#pragma mark 用户获取自己详细信息
- (void)GetUserFacilitatorInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserFacilitatorInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = UserId_New;//18-08-11 用户ID-徐
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.userInfo.UserId = [object valueForKey:@"UserId"];
            self.userInfo.Phone = [object valueForKey:@"Phone"];
            self.userInfo.Name = [object valueForKey:@"Name"];
            self.userInfo.Profession = [object valueForKey:@"Profession"];
            self.userInfo.Headportrait = [object valueForKey:@"Headportrait"];
            self.userInfo.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            self.userInfo.ModelID = [object valueForKey:@"ModelID"];
            self.userInfo.Address = [object valueForKey:@"Address"];
            
            self.userInfo.IsMotorcade = [object valueForKey:@"IsMotorcade"];
            self.userInfo.CaptainID = [object valueForKey:@"CaptainID"];
            self.userInfo.IsNews = [object valueForKey:@"IsNews"];
            
            self.userInfo.Abstract = [object valueForKey:@"Abstract"];
            
            //5-29
            self.userInfo.FollowNumber = [[object valueForKey:@"FollowNumber"] integerValue];
            self.userInfo.FansNumber = [[object valueForKey:@"FansNumber"] integerValue];
            
            self.userInfo.region = [object valueForKey:@"region"];
            self.userInfo.regionname = [object valueForKey:@"regionname"];
            self.userInfo.StatusType = [object valueForKey:@"StatusType"];
            
            //18-11-02 婚期
            self.userInfo.Wedding = [object valueForKey:@"Wedding"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.userInfo.Headportrait]];
            UIImage *img = [UIImage imageWithData:data];
            if (img) {
                [self.iconImgs removeAllObjects];//移除前一个图片 否则保存两张
                [self.iconImgs addObject:img];
            }
            
            self.titleName = self.userInfo.Name;
            self.dateStr = self.userInfo.Wedding;
            
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

#pragma mark 修改个人资料
- (void)UpdateUserInfoWithIconID:(NSString *)iconID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdateUserInfo";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"Name"] = self.titleName;
    params[@"Headportrait"] = iconID;
    //18-11-02 婚期
    params[@"Wedding"] = self.dateStr;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
//            [self GetUserFacilitatorInfo];//重新获取数据
            //18-11-06
            if (self.backType == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if (self.backType == 1){
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

- (YPGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPGetUserInfo alloc]init];
    }
    return _userInfo;
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
