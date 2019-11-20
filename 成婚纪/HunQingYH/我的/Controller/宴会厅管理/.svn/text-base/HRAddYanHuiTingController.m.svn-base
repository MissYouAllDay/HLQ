//
//  HRAddYanHuiTingController.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRAddYanHuiTingController.h"
#import "HXPhotoView.h"
#import "HXPhotoPicker.h"
#import "BANetManager.h"
#import "HXPhotoTools.h"
static const CGFloat kPhotoViewMargin = 12.0;

//static const CGFloat kPhotoViewSectionMargin = 20.0;

@interface HRAddYanHuiTingController ()<HXPhotoViewDelegate>
{
       UIView *_navView;
    UILabel *xianceLab;
    UIButton *wanchengBtn;
    
    NSString *upFMString;//添加网络请求封面字段
    NSString *upXCString;//添加相册网络请求字段

//    MBProgressHUD *hud ;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXPhotoView *onePhotoView;
@property (strong, nonatomic) HXPhotoManager *oneManager;
@property (strong, nonatomic) HXPhotoView *twoPhotoView;
@property (strong, nonatomic) HXPhotoManager *twoManager;

@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;


@end

@implementation HRAddYanHuiTingController
- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}
- (HXPhotoManager *)oneManager {
    if (!_oneManager) {
        _oneManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _oneManager;
}

- (HXPhotoManager *)twoManager {
    if (!_twoManager) {
        _twoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _twoManager;
}

-(NSMutableArray *)upfmArray{
    if (!_upfmArray) {
        _upfmArray =[NSMutableArray array];
    }
    return _upfmArray;
}
-(NSMutableArray *)upXCArray{
    if (!_upXCArray) {
        _upXCArray =[NSMutableArray array];
    }
    return _upXCArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CHJ_bgColor;
    [self setupUI];
    [self setupNav];
    
    
}
- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backController) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    if ([self.leixingStr isEqualToString:@"1"]) {
        titleLab.text = @"添加宴会厅";
    }else{
        titleLab.text = self.tingName;
    }
    
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
 
    

    
}
-(void)setupUI{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, 150)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.scrollView addSubview:topView];
    
    UILabel *tingNameLab = [[UILabel alloc]init];
    tingNameLab.text =@"宴会厅名";
    [topView addSubview:tingNameLab];
    [tingNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(15);
        make.left.mas_equalTo(topView.mas_left).offset(15);
    }];
    self.titleTF =[[UITextField alloc]init];
    if ([self.leixingStr isEqualToString:@"2"]){
        self.titleTF.text =self.tingName;
    }else{
        self.titleTF.placeholder =@"15个字以内";
    }
    
    self.titleTF.textAlignment=NSTextAlignmentRight;
    self.titleTF.borderStyle = UITextBorderStyleRoundedRect;
    [topView addSubview:self.titleTF];
    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tingNameLab);
        make.right.mas_equalTo(topView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor=CHJ_bgColor;
    [topView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tingNameLab.mas_bottom).offset(15);
        make.left.mas_equalTo(topView);
        make.right.mas_equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel *cengGaoLab = [[UILabel alloc]init];
    cengGaoLab.text =@"最低价格";
    [topView addSubview:cengGaoLab];
    [cengGaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView1.mas_bottom).offset(15);
        make.left.mas_equalTo(topView.mas_left).offset(15);
    }];
    
    
    self.priceTF =[[UITextField alloc]init];
    if ([self.leixingStr isEqualToString:@"2"]){
        self.priceTF.text =[NSString stringWithFormat:@"%.2lf",self.lowestPrice];
    }else{
        self.priceTF.placeholder =@"请输入价格";
    }
    self.priceTF.keyboardType =UIKeyboardTypeNumberPad;
    self.priceTF.textAlignment=NSTextAlignmentRight;
    self.priceTF.borderStyle = UITextBorderStyleRoundedRect;
    [topView addSubview:self.priceTF];
    [self.priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cengGaoLab);
        make.right.mas_equalTo(topView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor=CHJ_bgColor;
    [topView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cengGaoLab.mas_bottom).offset(15);
        make.left.mas_equalTo(topView);
        make.right.mas_equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel *zhuoshuLab = [[UILabel alloc]init];
    
    
    zhuoshuLab.text =@"容纳桌数";
    [topView addSubview:zhuoshuLab];
    [zhuoshuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).offset(15);
        make.left.mas_equalTo(topView.mas_left).offset(15);
    }];
    
    self.countTF =[[UITextField alloc]init];
    if ([self.leixingStr isEqualToString:@"2"]){
        self.countTF.text =[NSString stringWithFormat:@"%zd",self.tableNum];
    }else{
        self.countTF.placeholder =@"请输入桌数";
    }
    self.countTF.keyboardType =UIKeyboardTypeNumberPad;
    self.countTF.textAlignment=NSTextAlignmentRight;
    self.countTF.borderStyle = UITextBorderStyleRoundedRect;
    [topView addSubview:self.countTF];
    [self.countTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zhuoshuLab);
        make.right.mas_equalTo(topView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    
    UILabel *fenmianLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 225, ScreenWidth, 15)];
    fenmianLab.text =@"添加封面";
    fenmianLab.textColor =[UIColor grayColor];
    fenmianLab.font =kFont(13);
    [self.scrollView addSubview:fenmianLab];
    
    self.onePhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 245, self.view.frame.size.width - kPhotoViewMargin * 2, 0) WithManager:self.oneManager];
    self.onePhotoView.backgroundColor =WhiteColor;
    self.onePhotoView.delegate = self;
    if ([self.leixingStr isEqualToString:@"2"]){
        if (self.upfmArray.count!=0) {
            self.oneManager.localImageList =self.upfmArray;
        }
      
        [self.onePhotoView refreshView];
    }
    
      self.oneManager.configuration.photoMaxNum=1;
    [self.scrollView addSubview:self.onePhotoView];
    
    
    xianceLab = [[UILabel alloc]initWithFrame:CGRectMake(5,245 + 120 , ScreenWidth, 15)];
    xianceLab.text =@"添加宴会厅图片";
    xianceLab.textColor =[UIColor grayColor];
    xianceLab.font =kFont(13);
    [self.scrollView addSubview:xianceLab];
    
    wanchengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wanchengBtn.frame =CGRectMake(15, 500, ScreenWidth-30, 50);
    
    
    
    wanchengBtn.clipsToBounds =YES;
    wanchengBtn.layer.cornerRadius =5;
    [wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    [wanchengBtn addTarget:self action:@selector(wangchengClick) forControlEvents:UIControlEventTouchUpInside];
    [wanchengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [wanchengBtn setBackgroundColor:NavBarColor];
    
    self.twoPhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 0, self.view.frame.size.width - kPhotoViewMargin * 2, 0) WithManager:self.twoManager];
    self.twoPhotoView.delegate = self;
    self.twoPhotoView.backgroundColor =WhiteColor;
    self.twoManager.configuration.photoMaxNum =9;
    
    if ([self.leixingStr isEqualToString:@"2"]){
        //编辑
        self.twoManager.localImageList =self.upXCArray;
        [self.twoPhotoView refreshView];
    }
    
    
    [self.scrollView addSubview:self.twoPhotoView];
    
  
    [self.scrollView addSubview:wanchengBtn];
    

    
    
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    if (self.onePhotoView == photoView) {//封面选择器
       
            [self.upfmArray removeAllObjects];
        

        __weak typeof(self) weakSelf = self;
        [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
            for (int i=0; i<imageList.count; i++) {
                [self.upfmArray addObject:imageList[i]];
            }
        } failed:^{
            
        }];
        
    }else if (self.twoPhotoView == photoView) {//相册选择器
      
            [self.upXCArray removeAllObjects];
        
        
        __weak typeof(self) weakSelf = self;
        [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
            for (int i=0; i<imageList.count; i++) {
                [self.upXCArray addObject:imageList[i]];
            }
        } failed:^{
            
        }];

    }
}
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {

    
   
        if (self.twoPhotoView == photoView) {
          
     
         self.twoPhotoView.frame = CGRectMake(kPhotoViewMargin,390, self.view.frame.size.width - kPhotoViewMargin * 2, self.twoPhotoView.frame.size.height);
    }

  wanchengBtn.center = CGPointMake(ScreenWidth/2, CGRectGetMaxY(self.twoPhotoView.frame)+50);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.twoPhotoView.frame) + kPhotoViewMargin+70);
}


#pragma mark ------target------

-(void)backController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//完成按钮
-(void)wangchengClick{
    
    if ([self.titleTF.text isEqualToString:@""]) {
        [EasyShowTextView showText:@"请输入宴会厅名"];
   
    }else if ([self.priceTF.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请输入价格"];
    }else if ([self.countTF.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请输入桌数"];

    }else if (self.upfmArray.count ==0){
        
        [EasyShowTextView showText:@"请添加封面!"];
    }else {
        
        [self uploadFMImageRequest];

    }
}

#pragma mark --------------网路请求-------------
//上传封面
-(void)uploadFMImageRequest{
    NSLog(@"%@",self.upfmArray);
    
    [EasyShowLodingView showLoding];
    
    
    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
    [fmdict setValue:@"2" forKey:@"os"];
    [fmdict setValue:@"0" forKey:@"ot"];
    [fmdict setValue:UserId_New forKey:@"oi"];
    [fmdict setValue:@"2" forKey:@"t"];
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = fmdict;
    imageEntity.imageArray = self.upfmArray;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        NSLog(@"封面返回：====%@",response);
        upFMString =[response objectForKey:@"Inform"];
        
        if (self.upXCArray.count==0) {//没选择图片
            if ([self.leixingStr isEqualToString:@"2"]) {//编辑
                [self editanliRequest];
            }else{
                [self AddBanquetHallInfo];
            }
        }else{
            
            [self performSelector:@selector(uploadSelectImageRequest) withObject:self afterDelay:1];
            
            //                [self uploadSelectImageRequest];
            
        }
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

    
    
}
//上传相册
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
        if ([self.leixingStr isEqualToString:@"2"]) {//编辑
            [self editanliRequest];
        }else{
            [self AddBanquetHallInfo];
        }
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     

    
    
}

#pragma mark - 网络请求
#pragma mark 添加厅信息
- (void)AddBanquetHallInfo{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddBanquetHallInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"BanquetHallName"] = self.titleTF.text;
    params[@"MaxTableCount"] = self.countTF.text;
    params[@"FloorPrice"] = self.priceTF.text;
    params[@"HotelLogo"] = upFMString;//图片
    params[@"TypeQuestion"] = upXCString;//图片
    NSLog(@"添加宴会厅参数：%@",params);
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发布成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            alertView.tag =1000;
//            [alertView show];
            
            [EasyShowTextView showText:@"发布成功!" inView:self.view];
            [self performSelector:@selector(backController) withObject:nil afterDelay:1];
            
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

-(void)editanliRequest{
    
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/UpBanquetHallInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BanquetHallName"] = _titleTF.text;
    params[@"FloorPrice"] = _priceTF.text;
    params[@"MaxTableCount"] =_countTF.text;
    params[@"HotelLogo"] = upFMString;
    params[@"TypeQuestion"] = upXCString;
    params[@"BanquetID"] =self.BanquetID;


    NSLog(@"修改相册个数：%lu",(unsigned long)self.upXCArray.count);

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
      
            [EasyShowTextView showText:@"修改成功!" inView:self.view];
            [self performSelector:@selector(backController) withObject:nil afterDelay:1];
            
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


#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
