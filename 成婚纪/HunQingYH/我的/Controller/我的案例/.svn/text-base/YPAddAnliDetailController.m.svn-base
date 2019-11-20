//
//  YPAddAnliDetailController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddAnliDetailController.h"

@interface YPAddAnliDetailController ()<LQPhotoPickerViewDelegate>
{
    UIView *navView;
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
    //分割线
    UIView *lineView1;
    UIView *lineView2;
    
}
//标题占位图符label
@property(strong,nonatomic)UILabel *TitleplaceHolderTextViewLabel;
//内容占位图符label
@property(strong,nonatomic)UILabel *noteplaceHolderTextViewLabel;

@property (nonatomic, strong) NSMutableArray *imgsMarr;
@property (nonatomic, strong) NSMutableArray *imgsIDMarr;
@property (nonatomic, copy) NSString *imgsIDStr;

@end

@implementation YPAddAnliDetailController{
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
    self.view.backgroundColor = WhiteColor;
    
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
    titleLab.text = @"上传案例";
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

- (void)initViews{
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    //scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1)];
    _scrollView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_scrollView];
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
    
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.textColor = GrayColor;
    self.typeLabel.text = self.type;
    
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
    
    //标题占位图符
    self.TitleplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_titleTextView placehold:self.TitleplaceHolderTextViewLabel text:@"请添加标题，限20个字"];
    //主内容占位图符
    self.noteplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 400/2, 20)];
    [self addPlaceholdWithTextView:_noteTextView placehold:self.noteplaceHolderTextViewLabel text:@"对案例进行简单的介绍会更吸引人哦..."];
    
    [_scrollView addSubview:_noteTextBackgroudView];
    [_scrollView addSubview:_titleTextView];
    [_scrollView addSubview:_noteTextView];
    [_scrollView addSubview:_textNumberLabel];
    [_scrollView addSubview:self.typeLabel];
    [_scrollView addSubview:lineView1];
    [_scrollView addSubview:lineView2];
    
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
    lineView1.frame =CGRectMake(0, 49, ScreenWidth, 1);
    //公告编辑框
    _noteTextView.frame = CGRectMake(15, 50, ScreenWidth - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, ScreenWidth-10, 15);
    
    lineView2.frame =CGRectMake(15, _textNumberLabel.frame.origin.y+_textNumberLabel.frame.size.height+10, ScreenWidth-30, 1);
    
    self.typeLabel.frame = CGRectMake(15, lineView2.frame.origin.y+16, ScreenWidth-30, 30);
    
    //photoPicker
    [self LQPhotoPicker_updatePickerViewFrameY:self.typeLabel.frame.origin.y +self.typeLabel.frame.size.height];
    
    allViewHeight = noteTextHeight + [self LQPhotoPicker_getPickerViewFrame].size.height + 30 + 100;
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


#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    NSMutableArray *bigImageArray = [self LQPhotoPicker_getBigImageArray];
    //    //大图数据
    //    NSMutableArray *bigImageDataArray = [self LQPhotoPicker_getBigImageDataArray];
    
    //小图数组
    //    NSMutableArray *smallImageArray = [self LQPhotoPicker_getSmallImageArray];
    
    //    //小图数据
    //    NSMutableArray *smallImageDataArray = [self LQPhotoPicker_getSmallDataImageArray];
    
    for (UIImage *img in bigImageArray) {
        NSString *imgID = [self getUUID];
        [self.imgsIDMarr addObject:imgID];
        self.imgsIDStr = [self.imgsIDMarr componentsJoinedByString:@","];
        [self uploadImgs:imgID andImg:img];
    }
    
    
}

- (void)LQPhotoPicker_pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark ------target----
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fabuBtnClick{
    NSLog(@"发布");
    
//    if (self.titleTextView.text.length == 0) {
//        [MBProgressHUD wj_showPlainText:@"请添加标题!" view:self.view];
//        
//    }else if (self.noteTextView.text.length == 0){
//        [MBProgressHUD wj_showPlainText:@"请添加内容!" view:self.view];
//        
//        
//    }else if (self.multiEmployeeArr.count == 0){
//        [MBProgressHUD wj_showPlainText:@"请添加成员!" view:self.view];
//        
//    }else{
//        
//        //上传图片数据
//        [self submitToServer];
    
        //上传案例
//        [self AddLogWorkInfo];
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

#pragma mark 上传图片相关
-(void)uploadImgs:(NSString *)name andImg:(UIImage *)image{
    _nameString=[[NSMutableString alloc]initWithString:@""];
    
    NSString *name2 =[NSString stringWithFormat:@"%@.jpg",name];
    [Upload upload:image GUID:name2 type:@"1"];
    NSLog(@"%@",name);
    [_nameString appendString:[name stringByAppendingString:@","]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
