//
//  YPAddCarImgsController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddCarImgsController.h"

@interface YPAddCarImgsController ()<LQPhotoPickerViewDelegate>

//文字说明
@property(nonatomic,strong) UILabel *explainLabel;

@property (nonatomic, strong) NSMutableArray *imgsIDMarr;
@property (nonatomic, copy) NSString *imgsIDStr;

@end

@implementation YPAddCarImgsController{
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    
    /**
     *  依次设置
     */
    self.LQPhotoPicker_superView = self.view;
    
    self.LQPhotoPicker_imgMaxCount = 9;
    
    [self LQPhotoPicker_initPickerView];
    
    self.LQPhotoPicker_delegate = self;
    
    _explainLabel = [[UILabel alloc]init];
    _explainLabel.text = @"添加图片不超过9张";
    _explainLabel.textColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_explainLabel];
    
    [self updateViewsFrame];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"上传图片";
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

- (void)updateViewsFrame{
    
    //photoPicker
    [self LQPhotoPicker_updatePickerViewFrameY:NAVIGATION_BAR_HEIGHT+20];
    
    //说明文字
    _explainLabel.frame = CGRectMake(0, [self LQPhotoPicker_getPickerViewFrame].origin.y+[self LQPhotoPicker_getPickerViewFrame].size.height+10, ScreenWidth, 20);
}

#pragma mark - target
- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
//    NSMutableArray *bigImageArray = [self LQPhotoPicker_getBigImageArray];
//    //大图数据
//    NSMutableArray *bigImageDataArray = [self LQPhotoPicker_getBigImageDataArray];
//    
//    //小图数组
//    NSMutableArray *smallImageArray = [self LQPhotoPicker_getSmallImageArray];
//    
//    //小图数据
//    NSMutableArray *smallImageDataArray = [self LQPhotoPicker_getSmallDataImageArray];

//    for (UIImage *img in bigImageArray) {
//        NSString *imgID = [self getUUID];
//        [self.imgsIDMarr addObject:imgID];
//        self.imgsIDStr = [self.imgsIDMarr componentsJoinedByString:@","];
//        [self uploadImgs:imgID andImg:img];
//    }
    
}

#pragma mark -----------图片上传相关---------
-(NSString *)getUUID
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    int randomValue =arc4random() %100000;
    
    NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
    return unique;
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

- (void)LQPhotoPicker_pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark -------网络请求----------
//#pragma mark - 上传图片
//-(void)uploadIconImgRequest{
//    
//    if (!self.hud) {
//        self.hud = [MBProgressHUD wj_showActivityLoading:@"" toView:nil];
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
//        NSLog(@"添加车型图 编辑资料 返回：====%@",response);
//        
//        [self AddCarModelWithCarImgID:[response objectForKey:@"Inform"]];
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

#pragma mark 添加车型
//-(void)AddCarModel{
//    //    MBProgressHUD *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:nil];
//    NSString *url = @"/api/HQOAApi/AddCarModel";
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"CarModelID"] = @"1";//1、添加品牌 ；品牌ID添加型号
//    params[@"Name"] = [NSString stringWithFormat:@"%zd",_pageIndex];
//    params[@"CarImg"] = @"1";
//    params[@"CarColour"] = @"10000";
//    
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        
//        //        // 菊花不会自动消失，需要自己移除
//        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //            [hud removeFromSuperview];
//        //        });
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
//            [self.dataArr removeAllObjects];
//            
//            self.dataArr = [ContactModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
//            
//            _rowArr= [ContactDataHelper getFriendListDataBy:_dataArr];
//            _sectionArr= [ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
//            
//            [self.tableView reloadData];
//            
//        }else{
//            
//            
//            //            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:nil];
//            
//            
//        }
//        
//    } Failure:^(NSError *error) {
//        
//        
//        //        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toView:nil];
//    }];
//    
//    
//    
//}

#pragma mark - getter
- (NSMutableArray *)imgsIDMarr{
    if (!_imgsIDMarr) {
        _imgsIDMarr = [NSMutableArray array];
    }
    return _imgsIDMarr;
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
