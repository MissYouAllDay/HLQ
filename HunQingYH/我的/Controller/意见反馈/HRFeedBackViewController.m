//
//  HRFeedBackViewController.m
//  hunqing
//
//  Created by DiKai on 2017/10/27.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "HRFeedBackViewController.h"
#import "LPDQuoteImagesView.h"
//#import "BANetManager.h"

@interface HRFeedBackViewController ()<LQPhotoPickerViewDelegate,LPDQuoteImagesViewDelegate>
{
    UIView *_navView;
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
    //分割线
    UIView *lineView0;
    UIView *lineView1;
    UIView *lineView2;
    UIView *lineView3;

//    MBProgressHUD *hud;
}
//联系占位图符label
@property(strong,nonatomic)UILabel *connectplaceHolderTextViewLabel;
//标题占位图符label
@property(strong,nonatomic)UILabel *TitleplaceHolderTextViewLabel;
//内容占位图符label
@property(strong,nonatomic)UILabel *noteplaceHolderTextViewLabel;

@property (nonatomic, strong) NSMutableArray *imgsMarr;
@property (nonatomic, strong) NSMutableArray *imgsIDMarr;
@property (nonatomic, copy) NSString *imgsIDStr;

@property (nonatomic, copy) NSString *multiEmployeeIDs;
@property (nonatomic, strong) NSArray *multiEmployeeArr;

@end

@implementation HRFeedBackViewController

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
    self.view.backgroundColor =CHJ_bgColor;
    
    [self setupNav];
    [self initViews];

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
    titleLab.text = @"意见反馈";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
  
    
}
- (void)initViews{
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    //scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    //联系方式TextView
    _connectTextView = [[UITextView alloc]init];
    _connectTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _connectTextView.delegate = self;
    _connectTextView.keyboardType =UIKeyboardTypeNumberPad;
    _connectTextView.font = [UIFont boldSystemFontOfSize:14];
    _connectTextView.returnKeyType =UIReturnKeyDone;
    
    //分割线
    lineView0 = [[UIView alloc]init];
    lineView0.backgroundColor =CHJ_bgColor;
    //标题TextView
    _titleTextView =[[UITextView alloc]init];
    _titleTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _titleTextView.font = [UIFont boldSystemFontOfSize:14];
    _titleTextView.delegate =self;
    _titleTextView.returnKeyType =UIReturnKeyDone;
    //分割线
    lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor =CHJ_bgColor;
    
    //背景
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    //公告主内容框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:14];
    _noteTextView.returnKeyType =UIReturnKeyDone;
    //字数提示
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = @"0/800";
    
    
    /**
     *  图片选择器  依次设置
     */
    self.LQPhotoPicker_superView = _scrollView;
    self.LQPhotoPicker_imgMaxCount = 9;
    [self LQPhotoPicker_initPickerView];
    self.LQPhotoPicker_delegate = self;
    //分割线
    lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor =CHJ_bgColor;
  
    //提交按钮
    _submitBtn = [[UIButton alloc]init];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:MainColor];
    _submitBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [_submitBtn addTarget:self action:@selector(fanWeiBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    lineView3 = [[UIView alloc]init];
    lineView3.backgroundColor =CHJ_bgColor;
    //标题占位图符
    self.connectplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_connectTextView placehold:self.connectplaceHolderTextViewLabel text:@"请填写手机号(必填)"];
    
    //标题占位图符
    self.TitleplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_titleTextView placehold:self.TitleplaceHolderTextViewLabel text:@"请添加标题，限20个字"];
    //主内容占位图符
    self.noteplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_noteTextView placehold:self.noteplaceHolderTextViewLabel text:@"请填写意见反馈，限800字......"];
    
    
    [_scrollView addSubview:_noteTextBackgroudView];
    [_scrollView addSubview:_connectTextView];
    [_scrollView addSubview:_noteTextView];
    [_scrollView addSubview:_textNumberLabel];
    [_scrollView addSubview:_submitBtn];
    [_scrollView addSubview:_titleTextView];
    [_scrollView addSubview:lineView0];
    [_scrollView addSubview:lineView1];
    [_scrollView addSubview:lineView2];
    [_scrollView addSubview:lineView3];
    
    
    
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
    _connectTextView.frame =CGRectMake(15, 0, ScreenWidth-30, 49);
 
    //分割线
    lineView0.frame =CGRectMake(0, 49, ScreenWidth, 1);
    //标题TextVie
    _titleTextView.frame =CGRectMake(15, 50, ScreenWidth-30, 49);
   
    //分割线
    lineView1.frame =CGRectMake(0, 99, ScreenWidth, 1);
    //公告编辑框
    _noteTextView.frame = CGRectMake(15, 100, ScreenWidth - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, ScreenWidth-10, 15);
    //photoPicker
    [self LQPhotoPicker_updatePickerViewFrameY:_textNumberLabel.frame.origin.y +_textNumberLabel.frame.size.height];
    
    lineView2.frame =CGRectMake(15, [self LQPhotoPicker_getPickerViewFrame].origin.y+[self LQPhotoPicker_getPickerViewFrame].size.height+9, ScreenWidth-30, 1);

    //发送范围
    _submitBtn.frame = CGRectMake(15, [self LQPhotoPicker_getPickerViewFrame].origin.y+[self LQPhotoPicker_getPickerViewFrame].size.height+25, ScreenWidth-30, 50);
   
    allViewHeight =50+ noteTextHeight + [self LQPhotoPicker_getPickerViewFrame].size.height + 30 + 100;
    _scrollView.contentSize = self.scrollView.contentSize = CGSizeMake(0,allViewHeight);
    
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
- (void)viewTapped{
    [self.view endEditing:YES];
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
    //部落限1000
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/1000    ",(unsigned long)_noteTextView.text.length];
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
    
    if ([[_connectTextView text] length] == 0) {
        [self.connectplaceHolderTextViewLabel setAlpha:1];
    }
    else {
        [self.connectplaceHolderTextViewLabel  setAlpha:0];
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

#pragma maek - 检查输入
- (BOOL)checkInput{
    if (_noteTextView.text.length == 0) {
        //MBhudText(self.view, @"请添加记录备注", 1);
        return NO;
    }
    return YES;
}



- (void)LQPhotoPicker_pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fanWeiBtnClicked{
    if (self.titleTextView.text.length == 0) {
        
        [EasyShowTextView showText:@"请添加标题!"];
    }else if (self.noteTextView.text.length == 0){
        
        [EasyShowTextView showText:@"请添加内容!"];
        
    }else if (self.connectTextView.text.length == 0){
        
        [EasyShowTextView showText:@"请添加手机号!"];
    }else{
        
        //上传图片数据
        [self submitToServer];
  
    }
}

#pragma mark - 上传图片
- (void)submitToServer{
    NSMutableArray *bigImageArray = [self LQPhotoPicker_getBigImageArray];
    
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
    imageEntity.imageArray = bigImageArray;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        NSLog(@"相册返回：====%@",response);
        self.imgsIDStr =[response objectForKey:@"Inform"];
        [self AddFeedbackInfo];
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
     
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:dict imageArray:bigImageArray fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//
//    } failurBlock:^(NSError *error) {
//
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//    }];
    
}

#pragma mark - 网络请求
#pragma mark 添加反馈表
-(void)AddFeedbackInfo{
    
    NSString *url = @"/api/HQOAApi/AddFeedbackInfo";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"LogTitle"] = _titleTextView.text;
    params[@"LogContent"] = _noteTextView.text;
    params[@"Imgs"] = self.imgsIDStr;
    params[@"Name"] = UserName_New;
    params[@"ContactInformation"] = _connectTextView.text;
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"反馈成功!"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
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
