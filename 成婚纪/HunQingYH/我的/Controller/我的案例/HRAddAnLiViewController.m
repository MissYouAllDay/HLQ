//
//  HRAddAnLiViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/7.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRAddAnLiViewController.h"
#import "HXPhotoView.h"
#import "BANetManager.h"
#import "HXPhotoTools.h"
#import "HXPhotoPicker.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+WJExtension.h"

static const CGFloat kPhotoViewMargin = 12.0;
static const CGFloat kPhotoViewSectionMargin = 20.0;
@interface HRAddAnLiViewController ()<HXPhotoViewDelegate>
{
    UIView *navView;
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
    //分割线
    UIView *lineView1;
    UIView *lineView2;
    UILabel *FMLab;
    NSString *videoUrlString;
    NSString *upFMString;//添加网络请求封面字段
    NSString *upXCString;//添加相册网络请求字段
    NSString *upVideoString;//添加网络请求视频字段
 
}
//标题占位图符label
@property(strong,nonatomic)UILabel *TitleplaceHolderTextViewLabel;
//内容占位图符label
@property(strong,nonatomic)UILabel *noteplaceHolderTextViewLabel;
@property (strong, nonatomic) HXPhotoView *FMPhotoView;//封面图选择器
@property (strong, nonatomic) HXPhotoManager *FMManager;
@property (strong, nonatomic) HXPhotoView *PhotoOrVideoView;
@property (strong, nonatomic) HXPhotoManager *PhotoOrVideoManager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
//@property (strong, nonatomic) NSMutableArray *upfmArray;
@property (strong, nonatomic) NSMutableArray *upFMArray;
@property (strong, nonatomic) NSMutableArray *upXCArray;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HRAddAnLiViewController
- (HXPhotoManager *)FMManager {
    if (!_FMManager) {
        
        _FMManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        
    }
    return _FMManager;
}
- (HXPhotoManager *)PhotoOrVideoManager {
    if (!_PhotoOrVideoManager) {
        if ([self.type isEqualToString:@"上传视频"]) {
            _PhotoOrVideoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypeVideo];
        }else{
            _PhotoOrVideoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        }
        
        
    }
    return _PhotoOrVideoManager;
}
- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}
//-(NSMutableArray *)upfmArray{
//    if (!_upfmArray) {
//        _upfmArray =[NSMutableArray array];
//    }
//    return _upfmArray;
//}
-(NSMutableArray *)upFMArray{
    if (!_upFMArray) {
        _upFMArray =[NSMutableArray array];
    }
    return _upFMArray;
}
-(NSMutableArray *)upXCArray{
    if (!_upXCArray) {
        _upXCArray =[NSMutableArray array];
    }
    return _upXCArray;
}
-(NSMutableArray *)fmImageArray{
    if (!_fmImageArray) {
        _fmImageArray = [NSMutableArray array];
    }
    return _fmImageArray;
}
-(NSMutableArray *)selectImageArray{
    if (!_selectImageArray) {
        _selectImageArray =[NSMutableArray array];
    }
    return _selectImageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    videoUrlString =@"";
    [self createNav];
    [self createUI];
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
    if ([self.leixingStr isEqualToString:@"1"]) {
        titleLab.text = @"上传案例";
    }else{
        titleLab.text = @"编辑案例";
    }
    
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    UIButton *fabuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
    [fabuBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [fabuBtn addTarget:self action:@selector(fabuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:fabuBtn];
    [fabuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(navView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}

- (void)createUI{
    self.view.backgroundColor =CHJ_bgColor;
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    //scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1)];
    _scrollView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    
  
    //****************************标题******************************
    //标题TextView
    _titleTextView =[[UITextView alloc]init];
    _titleTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _titleTextView.font = [UIFont boldSystemFontOfSize:14];
    _titleTextView.delegate =self;
    _titleTextView.returnKeyType =UIReturnKeyDone;
    if ([self.leixingStr isEqualToString:@"2"]) {
        _titleTextView.text =self.titleStr;
    }
    [_scrollView addSubview:_titleTextView];
     if ([self.leixingStr isEqualToString:@"1"]){
         //标题占位图符
         self.TitleplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
         
         [self addPlaceholdWithTextView:_titleTextView placehold:self.TitleplaceHolderTextViewLabel text:@"请添加标题，限20个字"];
     }
   
    //分割线
    lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor =CHJ_bgColor;
    [_scrollView addSubview:lineView1];
    
    //*************************描述*********************************
    
    //背景
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
//    [_scrollView addSubview:_noteTextBackgroudView];
    //描述内容框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:14];
    _noteTextView.returnKeyType =UIReturnKeyDone;
    if ([self.leixingStr isEqualToString:@"2"]) {
        _noteTextView.text =self.neirongStr;
    }
    [_scrollView addSubview:_noteTextView];
    //字数提示
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = @"0/800";
     [_scrollView addSubview:_textNumberLabel];
    
    if ([self.leixingStr isEqualToString:@"1"]){
        //主内容占位图符
        self.noteplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
        [self addPlaceholdWithTextView:_noteTextView placehold:self.noteplaceHolderTextViewLabel text:@"对案例进行简单的介绍会更吸引人哦..."];
        
    }
    
  
      lineView2 = [[UIView alloc]init];
      lineView2.backgroundColor =CHJ_bgColor;
    
    [_scrollView addSubview:lineView2];
        //*************************封面*********************************
    //封面描述Label
//    FMLab =[[UILabel alloc]init];
//    FMLab.textColor =GrayColor;
//    FMLab.text =@"上传封面";
//    [_scrollView addSubview:FMLab];
    
    //封面选择器
//    self.FMPhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, CGRectGetMaxY(lineView2.frame)+15, self.view.frame.size.width - kPhotoViewMargin * 2, 0) WithManager:self.FMManager];
//    self.FMManager.configuration.photoMaxNum =1;
//    self.FMPhotoView.tag =1;
//    self.FMPhotoView.delegate = self;
//    if ([self.leixingStr isEqualToString:@"2"]){
//        if (self.fmImageArray.count!=0) {
//             self.FMManager.localImageList =self.fmImageArray;
//        }
//        self.FMManager.configuration.photoMaxNum =1;
//        [self.FMPhotoView refreshView];
//    }
//    [_scrollView addSubview:self.FMPhotoView];
    
    
    //上传类型说明label
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.textColor = GrayColor;
    self.typeLabel.text = self.type;
    [_scrollView addSubview:self.typeLabel];

  // 照片或视频选择器
    self.PhotoOrVideoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, CGRectGetMaxY(self.typeLabel.frame)+15, self.view.frame.size.width - kPhotoViewMargin * 2, 0) WithManager:self.PhotoOrVideoManager];
    self.PhotoOrVideoView.tag =2;
    self.PhotoOrVideoView.delegate =self;
    if ([self.leixingStr isEqualToString:@"2"]){
        //编辑
         if ([self.type isEqualToString:@"上传视频"]) {
             self.PhotoOrVideoManager.networkPhotoUrls  = [NSMutableArray arrayWithObjects:self.editVideoUrl, nil];
             self.PhotoOrVideoManager.configuration.videoMaxNum =1;
         }else{
             self.PhotoOrVideoManager.localImageList =self.selectImageArray;
             self.PhotoOrVideoManager.configuration.photoMaxNum =9;
             [self.PhotoOrVideoView refreshView];
         }
    
    }else{//上传
        if ([self.type isEqualToString:@"上传视频"]) {
            self.PhotoOrVideoManager.configuration.videoMaxNum =1;
            self.PhotoOrVideoManager.configuration.videoMaxDuration =100000.f;
            
        }else{
            self.PhotoOrVideoManager.configuration.photoMaxNum =9;
        }
    }
    self.PhotoOrVideoView.delegate = self;
    [_scrollView addSubview:self.PhotoOrVideoView];

    
    
    [self updateViewsFrame];
    

    
    
}
- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    
    _noteTextBackgroudView.frame = CGRectMake(0, 0, ScreenWidth, noteTextHeight);
    //标题TextVie
    _titleTextView.frame =CGRectMake(15, 0, ScreenWidth-30, 49);
    //分割线
    lineView1.frame =CGRectMake(15, 49, ScreenWidth-30, 2);
    //公告编辑框
    _noteTextView.frame = CGRectMake(15, 50, ScreenWidth - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, ScreenWidth-10, 15);
    
    lineView2.frame =CGRectMake(15, _textNumberLabel.frame.origin.y+_textNumberLabel.frame.size.height+10, ScreenWidth-30, 2);
    //选择封面提示label
//    FMLab.frame = CGRectMake(15, lineView2.frame.origin.y+16, ScreenWidth-30, 30);
    
    
    //封面选择器
//    self.FMPhotoView.frame =CGRectMake(kPhotoViewMargin, FMLab.frame.origin.y+FMLab.frame.size.height+10, self.view.frame.size.width - kPhotoViewMargin * 2, 0) ;
    
    self.typeLabel.frame =CGRectMake(15, lineView2.frame.origin.y+16, ScreenWidth-30, 30);
    
    self.PhotoOrVideoView.frame =CGRectMake(kPhotoViewMargin, CGRectGetMaxY(self.typeLabel.frame)+10, self.view.frame.size.width - kPhotoViewMargin * 2, 0);
  
    allViewHeight =_titleTextView.frame.size.height+_noteTextView.frame.size.height+self.typeLabel.frame.size.height+self.PhotoOrVideoView.frame.size.height+300;
    _scrollView.contentSize = self.scrollView.contentSize = CGSizeMake(0,allViewHeight);
    
}


- (void)viewTapped{
    [self.view endEditing:YES];
}
#pragma mark - 添加占位图符方法
- (void)addPlaceholdWithTextView:(UITextView *)textView placehold:(UILabel *)placehold text:(NSString *)text
{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    placehold.lineBreakMode = NSLineBreakByWordWrapping;
    placehold.font = [UIFont systemFontOfSize:12.0f];
    placehold.textColor = TextNormalColor;
    placehold.backgroundColor = [UIColor clearColor];
    placehold.alpha = 0;
    placehold.tag = 999;
    placehold.text = text;
    [textView addSubview:placehold];
    
    if ([[_titleTextView text] length] == 0) {
        [placehold setAlpha:1];
    }
    if ([[_noteTextView text] length] == 0) {
        [placehold setAlpha:1];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/300    ",(unsigned long)_noteTextView.text.length];
    if (_noteTextView.text.length > 300) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    [self textChanged];
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/800    ",(unsigned long)_noteTextView.text.length];
    if (_noteTextView.text.length > 1000) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    [self textChanged];
}

-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }
    if ([[_titleTextView text] length] == 0) {
        [self.TitleplaceHolderTextViewLabel setAlpha:1];
    }
    else {
        [self.TitleplaceHolderTextViewLabel  setAlpha:0];
    }
    if ([[_noteTextView text] length] == 0) {
        [self.noteplaceHolderTextViewLabel setAlpha:1];
    }
    else {
        [self.noteplaceHolderTextViewLabel  setAlpha:0];
    }
    [self updateViewsFrame];
}
#pragma mark ------照片选择器代理方法--------------

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    if (photoView.tag ==1) {
        NSLog(@"封面:%@",allList);
      
        [self.fmImageArray removeAllObjects];
//        for (HXPhotoModel *model in allList) {
//            [self.fmImageArray addObject:model];
//        }
//
//        NSLog(@"封面222:%@",self.fmImageArray);
//
//

        
        if (self.upFMArray.count!=0) {
            [self.upFMArray removeAllObjects];
        }
        
        
        
        __weak typeof(self) weakSelf = self;
        [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
            for (int i=0; i<imageList.count; i++) {
                [self.upFMArray addObject:imageList[i]];
            }
        } failed:^{
            
        }];
//        for (HXPhotoModel *photoModel in self.fmImageArray) {
//
//
//            if (photoModel.type == HXPhotoModelMediaTypeCameraPhoto){
//                 [self.upFMArray addObject:photoModel.thumbPhoto];
//            }
//
//            if (photoModel.type == HXPhotoModelMediaTypePhoto){
//                CGSize size = PHImageManagerMaximumSize;
//                [HXPhotoTools getImageWithAlbumModel:photoModel size:size completion:^(UIImage *image, HXAlbumModel *model) {
//                    [self.upFMArray addObject:image];
//
//                    NSLog(@"%zd",self.upFMArray.count);
//                }];
//            }
//
//
//
//
//        }
   
        

    }else if(photoView.tag ==2){
        
        NSLog(@"内容:%@",allList);

    
        if ([self.type isEqualToString:@"上传视频"]) {
            //
            HXPhotoModel *model =videos[0];
            
            videoUrlString =model.fileURL.absoluteString;
            
        }else{
            //上传相册
            
            [self.selectImageArray removeAllObjects];
//            for (HXPhotoModel *model in allList) {
//                [self.selectImageArray addObject:model];
//            }
//
//            NSLog(@"内容222:%@",self.selectImageArray);
//
            
            
            
            
            if (self.upXCArray.count!=0) {
                [self.upXCArray removeAllObjects];
            }
            
            
            
            __weak typeof(self) weakSelf = self;
            [weakSelf.toolManager getSelectedImageList:allList requestType:0 success:^(NSArray<UIImage *> *imageList) {
                for (int i=0; i<imageList.count; i++) {
                    [self.upXCArray addObject:imageList[i]];
                }
            } failed:^{
                
            }];

//
//            for (HXPhotoModel *photoModel in self.selectImageArray) {
//
//                NSLog(@"%lf",photoModel.imageSize.height);
//                if (photoModel.type == HXPhotoModelMediaTypeCameraPhoto){
//                    [self.upXCArray addObject:photoModel.thumbPhoto];
//                }
//
//                if (photoModel.type == HXPhotoModelMediaTypePhoto){
//
//                    CGSize size = PHImageManagerMaximumSize;
//                    [HXPhotoTools getImageWithAlbumModel:photoModel size:size completion:^(UIImage *image, HXAlbumModel *model) {
//                        NSLog(@"照片啊%@",image);
//                        [self.upXCArray addObject:image];
//
//                    }];
//
//                }
//
//
//            }
////
        }

        
        
       
        

        
    }



}
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
        if (self.PhotoOrVideoView == photoView) {
            self.PhotoOrVideoView.frame = CGRectMake(kPhotoViewMargin, CGRectGetMaxY(self.typeLabel.frame) + kPhotoViewSectionMargin, self.view.frame.size.width - kPhotoViewMargin * 2, self.PhotoOrVideoView.frame.size.height);
    
        }
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.PhotoOrVideoView.frame) + kPhotoViewMargin);
}


#pragma mark ------target----
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fabuBtnClick{

//
    if (self.titleTextView.text.length == 0) {
        [MBProgressHUD wj_showPlainText:@"请添加标题!" view:self.view];
        
    }else if (self.noteTextView.text.length == 0){
        [MBProgressHUD wj_showPlainText:@"请添加内容!" view:self.view];
        
    }else{
        
        if ([self.type isEqualToString:@"上传视频"]){
            if ([videoUrlString isEqualToString:@""]) {
                [MBProgressHUD wj_showPlainText:@"请添加视频!" view:self.view];
            }else{
                [self uploadFMImageRequest];
            }
            
        }else{
            if (self.upXCArray.count==0) {
               [MBProgressHUD wj_showPlainText:@"请添加图片!" view:self.view];
            }else{
                [self uploadFMImageRequest];
            }
        }
        
       
    }
       
        
  
   
    
    
}
-(void)getfmImage{
    [EasyShowLodingView showLoding];
    
    
    for (UIImage *ima in self.upXCArray) {
        
        NSLog(@"尺寸%@",ima);
        
    }
    
    
    
    [self getxcImage];

}
-(void)getxcImage{
    NSLog(@"%@",self.upFMArray);

    
    
    
    
    
[self uploadFMImageRequest];
    
        
    
    
}


#pragma maek - 检查输入
- (BOOL)checkInput{
    if (_noteTextView.text.length == 0) {
        //MBhudText(self.view, @"请添加记录备注", 1);
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark --------------网路请求-------------
//上传封面
-(void)uploadFMImageRequest{
    NSLog(@"%@",self.upFMArray);
    if ([self.type isEqualToString:@"上传视频"]) {
        //获取视频第一帧作为封面
        
        
        [self.upFMArray addObject:[self getCoverImage]];
        
//        if ([self.leixingStr isEqualToString:@"2"]) {//编辑
//
//
//            if ([videoUrlString isEqualToString:@""]) {//没有选择视频
//                [self editanliRequest];
//            }else{
//                [self uploadVideoRequest];
//            }
//        }else{
//
//            if ([videoUrlString isEqualToString:@""]) {
//                [self fabuAnLiRequest];
//            }else{
//                [self uploadVideoRequest];
//            }
//        }
//
        
        
    }else{
        //获取图片第一张作为封面
        
        [self.upFMArray removeAllObjects];
        UIImage *fmImage = self.upXCArray[0];
        [self.upFMArray addObject:fmImage];
        
        
    }
  
    
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
        
        if ([self.type isEqualToString:@"上传视频"]) {
            if ([self.leixingStr isEqualToString:@"2"]) {//编辑
                
                
                if ([videoUrlString isEqualToString:@""]) {//没有选择视频
                    [self editanliRequest];
                }else{
                    [self uploadVideoRequest];
                }
            }else{
                
                if ([videoUrlString isEqualToString:@""]) {
                    [self fabuAnLiRequest];
                }else{
                    [self uploadVideoRequest];
                }
            }
            
            
            
            
        }else{//上传图片
            if (self.upXCArray.count==0) {//没选择图片
                if ([self.leixingStr isEqualToString:@"2"]) {//编辑
                    [self editanliRequest];
                }else{
                    [self fabuAnLiRequest];
                }
            }else{
                
                [self performSelector:@selector(uploadSelectImageRequest) withObject:self afterDelay:1];
                
                //                [self uploadSelectImageRequest];
                
            }
            
        }
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
}
//上传相册
-(void)uploadSelectImageRequest{
    
 


    MBProgressHUD  *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
    
    [self hudTipWillShow:YES text:@"正在上传图片"];


    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:@"0" forKey:@"ot"];
    [dict setValue:UserId_New forKey:@"oi"];
    [dict setValue:@"2" forKey:@"t"];
    NSLog(@"%zd",self.selectImageArray.count);
    
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
        
        
        NSLog(@"相册返回：====%@",response);
        upXCString =[response objectForKey:@"Inform"];
        if ([self.leixingStr isEqualToString:@"2"]) {//编辑
            [self editanliRequest];
        }else{
            [self fabuAnLiRequest];
        }
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSString *str = [NSString stringWithFormat:@"%.2lld",100 * bytesProgress/totalBytesProgress];
        float f1 =[str floatValue];
        float f2 =f1/100;
        self.HUD.progress = f2;// progress是回调进度
        
        if ([str integerValue]==100) {
            [self hudTipWillShow:NO text:@""];
        }
    }];
    
//    [BANetManager ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:dict imageArray:self.upXCArray fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//
//
//    } failurBlock:^(NSError *error) {
//
//
//
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//
//    }];
    
    
    
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
        upVideoString =[response objectForKey:@"Inform"];
        if ([self.leixingStr isEqualToString:@"2"]) {
            [self editanliRequest];
        }else{
            [self fabuAnLiRequest];
        }
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

-(void)fabuAnLiRequest{
    
    NSLog(@"标题：%@",_titleTextView.text);
     NSLog(@"内容：%@",_noteTextView.text);
    
    NSLog(@"封面：%@",upFMString);
    NSLog(@"相册：%@",upXCString);
    NSLog(@"视频：%@",upVideoString);
    
    [self hudTipWillShow:NO text:@""];
    
    MBProgressHUD  *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
    
    

    NSString *url = @"/api/HQOAApi/AddCaseInfoInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"CoverMap"] = upFMString;
    params[@"LogTitle"] = _titleTextView.text;
    params[@"LogContent"] = _noteTextView.text;
    
    if ([self.type isEqualToString:@"上传视频"]) {
        
        params[@"Imgs"] = @"";
        params[@"VIDeos"] = upVideoString;
        
    }else{
        
        params[@"Imgs"] = upXCString;
        params[@"VIDeos"] = @"";
        
    }
    

    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
       
            NSLog(@"发布返回%@",object);

            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发布成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag =1000;
            [alertView show];
            
        }else{
            
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

-(void)editanliRequest{
  
    
 
      MBProgressHUD  *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
        
    
    NSString *url = @"/api/HQOAApi/UpCaseInfoInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"SupplierID"] = mySupplierID;
    params[@"FacilitatorId"] = FacilitatorId_New;//18-08-10 服务商Id
    params[@"CaseID"] = self.CaseID;
    params[@"CoverMap"] = upFMString;
    params[@"LogTitle"] = _titleTextView.text;
    params[@"LogContent"] = _noteTextView.text;
    NSLog(@"%@",params);
    if ([self.type isEqualToString:@"上传视频"]) {
        
        params[@"Imgs"] = @"";
        if (!upVideoString) {
              params[@"VIDeos"] = @"";
        }else{
           params[@"VIDeos"] = upVideoString;
        }
      
        
    }else{
        if (self.upXCArray.count==0) {
             params[@"Imgs"] = @"";
        }else{
           
            params[@"Imgs"] = upXCString;
        }
        params[@"VIDeos"] = @"";
        
    }
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"发布返回%@",object);
         
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag =1001;
            [alertView show];
            
        }else{
            
            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:self.view];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toView:self.view];
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 0 && alertView.tag == 1000) {
        
        NSLog(@"发布成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if(buttonIndex == 0 && alertView.tag == 1001) {
        

        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
