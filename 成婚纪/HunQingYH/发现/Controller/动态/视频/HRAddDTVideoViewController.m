//
//  HRAddDTVideoViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRAddDTVideoViewController.h"
#import "HXPhotoView.h"
#import "BANetManager.h"
#import "HXPhotoTools.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+WJExtension.h"
static const CGFloat kPhotoViewMargin = 12.0;
static const CGFloat kPhotoViewSectionMargin = 20.0;
@interface HRAddDTVideoViewController ()<HXPhotoViewDelegate>
{
    UIView *navView;
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
    NSString *upXCString;//添加相册网络请求字段
       NSString *videoUrlString;
    NSString *upFMString;//视频封面返回
    
}
//内容占位图图符label
@property(strong,nonatomic)UILabel *noteplaceHolderTextViewLabel;
@property (strong, nonatomic) HXPhotoView *PhotoOrVideoView;
@property (strong, nonatomic) HXPhotoManager *PhotoOrVideoManager;
@property (strong, nonatomic) NSMutableArray *upXCArray;
@property(strong,nonatomic)NSMutableArray *selectImageArray;
@property (strong, nonatomic) MBProgressHUD *HUD;

@property (strong, nonatomic) NSMutableArray *upFMArray;

@end

@implementation HRAddDTVideoViewController
-(NSMutableArray *)upFMArray{
    if (!_upFMArray) {
        _upFMArray = [NSMutableArray array];
    }
    return _upFMArray;
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
- (HXPhotoManager *)PhotoOrVideoManager {
    if (!_PhotoOrVideoManager) {
        
        _PhotoOrVideoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypeVideo];
        
        
        
    }
    return _PhotoOrVideoManager;
}
-(NSMutableArray *)upXCArray{
    if (!_upXCArray) {
        _upXCArray =[NSMutableArray array];
    }
    return _upXCArray;
}
-(NSMutableArray *)selectImageArray{
    if (!_selectImageArray) {
        _selectImageArray =[NSMutableArray array];
    }
    return _selectImageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CHJ_bgColor;
    videoUrlString =@"";
    [self createNav];
    [self initViews];
}

- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"发布视频";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    //提交  设置导航栏右边
     UIButton  *_upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upBtn setTitle:@"发布" forState:UIControlStateNormal];
    [_upBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [_upBtn addTarget:self action:@selector(fabuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_upBtn];
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(navView).mas_offset(-15);
        //        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
}

- (void)initViews{
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
    
    
    // 照片或视频选择器
    self.PhotoOrVideoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, NAVIGATION_BAR_HEIGHT+50, self.view.frame.size.width - kPhotoViewMargin * 2, 0) WithManager:self.PhotoOrVideoManager];
    self.PhotoOrVideoView.tag =1;
    self.PhotoOrVideoView.delegate =self;
    //    self.PhotoOrVideoManager.localImageList =self.selectImageArray;
    self.PhotoOrVideoManager.configuration.videoMaxNum =1;
    [self.PhotoOrVideoView refreshView];
    [self.view addSubview:self.PhotoOrVideoView];
    
    
    
    //scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+150, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50)];
    _scrollView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    


    
    //公告主内容框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:14];
    _noteTextView.returnKeyType =UIReturnKeyDone;
    
    //主内容占位图图符
    self.noteplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_noteTextView placehold:self.noteplaceHolderTextViewLabel text:@"分享你的幸福..."];
    
    
 
    
    [_scrollView addSubview:_noteTextView];
    
    
    
    [self updateViewsFrame];
}

- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    
    //photoPicker
    self.PhotoOrVideoView.frame =CGRectMake(ScreenWidth/2-((ScreenWidth- 2*kPhotoViewMargin)/3)/2, NAVIGATION_BAR_HEIGHT+20, self.view.frame.size.width - kPhotoViewMargin * 2, 0);

//    self.PhotoOrVideoView.centerX =_scrollView.centerX;
    
    //公告编辑框
    _noteTextView.frame = CGRectMake(0, 20, ScreenWidth , noteTextHeight);
    
    
    

    allViewHeight =self.noteTextView.frame.size.height+300;
    _scrollView.contentSize = self.scrollView.contentSize = CGSizeMake(0,allViewHeight);
    
}
- (void)viewTapped{
    [self.view endEditing:YES];
}

#pragma mark - 添加占位图图符方法
- (void)addPlaceholdWithTextView:(UITextView *)textView placehold:(UILabel *)placehold text:(NSString *)text
{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    placehold.lineBreakMode = NSLineBreakByWordWrapping;
    placehold.font = [UIFont systemFontOfSize:15.0f];
    placehold.textColor = TextNormalColor;
    placehold.backgroundColor = [UIColor clearColor];
    placehold.alpha = 0;
    placehold.tag = 999;
    placehold.text = text;
    [textView addSubview:placehold];
    
    
    if ([[_noteTextView text] length] == 0) {
        [placehold setAlpha:1];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    //    if (_noteTextView.text.length > 300) {
    //        _textNumberLabel.textColor = [UIColor redColor];
    //    }
    //    else{
    ////        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    //    }
    
    [self textChanged];
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    //部落限1000
    //    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/1000    ",(unsigned long)_noteTextView.text.length];
    //    if (_noteTextView.text.length > 1000) {
    //        _textNumberLabel.textColor = [UIColor redColor];
    //    }
    //    else{
    //        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    //    }
    
    [self textChanged];
}

-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }
    
    if ([[_noteTextView text] length] == 0) {
        [self.noteplaceHolderTextViewLabel setAlpha:1];
    }
    else {
        [self.noteplaceHolderTextViewLabel  setAlpha:0];
    }
    [self updateViewsFrame];
}

#pragma maek - 检查输入
- (BOOL)checkInput{
    if (_noteTextView.text.length == 0) {
        //MBhudText(self.view, @"请添加记录备注", 1);
        return NO;
    }
    return YES;
}


#pragma mark ------照片选择器代理方法--------------

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    if(photoView.tag ==1){
        
        NSLog(@"%zd",videos.count);
        if (videos.count>0) {
                    HXPhotoModel *model =videos[0];
            
                    videoUrlString =model.fileURL.absoluteString;
        }
        

        
      
        
        
        
        
        
        
        
        
    }
    
    
    
}
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    if (self.PhotoOrVideoView == photoView) {
        self.PhotoOrVideoView.frame = CGRectMake(kPhotoViewMargin, CGRectGetMaxY(self.noteTextView.frame) + kPhotoViewSectionMargin, self.view.frame.size.width - kPhotoViewMargin * 2, self.PhotoOrVideoView.frame.size.height);
        
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.PhotoOrVideoView.frame) + kPhotoViewMargin);
}


#pragma mark ------target----
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fabuBtnClick{
    NSLog(@"发布");
    
    if ([videoUrlString isEqualToString:@""]) {
        [EasyShowTextView showText:@"添加一个视频再发布吧"];
    }else{
         [self uploadFMImageRequest];
    }
    
//    if ([self.noteTextView.text isEqualToString:@""]) {
//        [EasyShowTextView showText:@"写点什么吧"];
//    }else{
//        [self uploadFMImageRequest];
////        if (self.upXCArray.count ==0) {
////            upXCString  =@"";
////            [self fabuRequest];
////        }else{
////            [self uploadVideoRequest];
////        }
//
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





////上传封面
-(void)uploadFMImageRequest{

    [self.upFMArray addObject:[self getCoverImage]];


    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
    [fmdict setValue:@"2" forKey:@"os"];
    [fmdict setValue:@"0" forKey:@"ot"];
    [fmdict setValue:UserId_New forKey:@"oi"];
    [fmdict setValue:@"2" forKey:@"t"];

    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = fmdict;
    imageEntity.imageArray = self.upFMArray;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;

    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        NSLog(@"封面返回：====%@",response);
        upFMString =[response objectForKey:@"Inform"];

        [self uploadVideoRequest];
    } failurBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {

    }];



}







//上传视频
-(void)uploadVideoRequest{
    
    
    [self hudTipWillShow:YES text:@"正在上传视频..."];
    NSMutableDictionary *videoDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [videoDict setValue:@"2" forKey:@"os"];
    [videoDict setValue:@"0" forKey:@"ot"];
    [videoDict setValue:UserId_New forKey:@"oi"];
    [videoDict setValue:@"1342" forKey:@"t"];
    
    BAFileDataEntity *videoEntity = [BAFileDataEntity new];
    videoEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    videoEntity.needCache = NO;
    videoEntity.parameters = videoDict;
    videoEntity.filePath = videoUrlString;
    
    [BANetManager ba_uploadVideoWithEntity:videoEntity successBlock:^(id response) {
        NSLog(@"视频返回：====%@",response);
        upXCString =[response objectForKey:@"Inform"];
        [self fabuRequest];
    } failureBlock:^(NSError *error) {
        [self hudTipWillShow:NO text:@""];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        //
        //        NSLog(@"=============进度进度：%.2lld",100 * bytesProgress/totalBytesProgress);
        NSString *str = [NSString stringWithFormat:@"%.2lld",100 * bytesProgress/totalBytesProgress];
        float f1 =[str floatValue];
        float f2 =f1/100;
        self.HUD.progress = f2;// progress是回调进度
    }];
    
    
    
    //     ba_uploadVideoWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:videoDict videoPath:videoUrlString successBlock:^(id response) {
    //
    //    } failureBlock:^(NSError *error) {
    //
    //    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    //
    //    }];
    
    
}

//进度显示和隐藏调用方法
- (void)hudTipWillShow:(BOOL)willShow text:(NSString*)text{
    if (willShow) {
        [self resignFirstResponder];
        //        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!_HUD) {
            _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
            _HUD.labelText = text;
            _HUD.removeFromSuperViewOnHide = YES;
        }else{
            _HUD.progress = 0;
            [self.view addSubview:_HUD];
            [_HUD show:YES];
        }
    }else{
        [_HUD hide:YES];
    }
}

-(UIImage*)getCoverImage{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoUrlString] options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(2*15, 15) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}
-(void)fabuRequest{
    
    //    NSLog(@"标题：%@",_titleTextView.text);
    //    NSLog(@"内容：%@",_noteTextView.text);
    //
    //    NSLog(@"封面：%@",upFMString);
    //    NSLog(@"相册：%@",upXCString);
    //    NSLog(@"视频：%@",upVideoString);
    
    [self hudTipWillShow:NO text:@""];
    
    MBProgressHUD  *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
    
    
    
    
    NSString *url = @"/api/HQOAApi/AddDynamic";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"Title"] = @"";
    params[@"Content"] = _noteTextView.text;
    params[@"CoverImg"] =upFMString;
    params[@"FilesId"] = upXCString;
    params[@"FileType"] = @2;//1图片,2视频

    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
        NSLog(@"发布返回%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发布成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag =1000;
            [alertView show];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:self.view];
        }
        
    } Failure:^(NSError *error) {
        
        // 菊花不会自动消失，需要自己移除
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            [hud removeFromSuperview];
        //        });
        
        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toView:self.view];
        
    }];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 0 && alertView.tag == 1000) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
