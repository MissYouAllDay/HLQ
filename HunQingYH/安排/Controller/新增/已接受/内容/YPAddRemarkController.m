//
//  YPAddRemarkController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddRemarkController.h"

@interface YPAddRemarkController ()<UITextViewDelegate>

//内容
@property(nonatomic,strong) UITextView *noteTextView;
//内容占位图图符label
@property(strong,nonatomic)UILabel *noteplaceHolderTextViewLabel;

//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;

@end

@implementation YPAddRemarkController{
    UIView *_navView;
    
    //备注文本View高度
    float noteTextHeight;
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
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    

    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:RGB(45, 175, 57) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    //公告主内容框
    _noteTextView = [[UITextView alloc]init];
    if (self.editRemark.length > 0) {
        _noteTextView.text = self.editRemark;
    }
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:14];
    _noteTextView.returnKeyType =UIReturnKeyDone;
    //字数提示
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
//    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%zd",self.limitCount];
    
    //主内容占位图图符
    self.noteplaceHolderTextViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10+20+NAVIGATION_BAR_HEIGHT, 400/2, 20)];
    [self addPlaceholdWithTextView:_noteTextView placehold:self.noteplaceHolderTextViewLabel text:self.placeHolder];
    
    [self.view addSubview:_noteTextView];
    [self.view addSubview:_textNumberLabel];
    [self.view addSubview:_noteplaceHolderTextViewLabel];
    
    [self updateViewsFrame];
}

- (void)updateViewsFrame{
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    _noteTextView.frame = CGRectMake(0, 20+NAVIGATION_BAR_HEIGHT, ScreenWidth, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, ScreenWidth-10, 15);
}

#pragma mark - 添加占位图图符方法
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
    
    if ([[_noteTextView text] length] == 0) {
        [placehold setAlpha:1];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%zd    ",(unsigned long)_noteTextView.text.length,self.limitCount];
    if (_noteTextView.text.length > 60) {
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
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%zd    ",(unsigned long)_noteTextView.text.length,self.limitCount];
    if (_noteTextView.text.length > self.limitCount) {
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

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if (self.yp_AddBlock) {
        if (self.noteTextView.text.length > self.limitCount) {
            Alertmsg(@"您输入的字数超限,请修改", nil)
        }else{
            self.yp_AddBlock(self.titleStr, _noteTextView.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if ([self.titleStr isEqualToString:@"修改名称"]) {
        if ([self.remarkDelegate respondsToSelector:@selector(hotelInfoName:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate hotelInfoName:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }else if ([self.titleStr isEqualToString:@"修改地址"]) {
        if ([self.remarkDelegate respondsToSelector:@selector(hotelInfoAddress:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate hotelInfoAddress:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }else if ([self.titleStr isEqualToString:@"修改昵称"]) {
        if ([self.remarkDelegate respondsToSelector:@selector(supplierPersonInfoName:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate supplierPersonInfoName:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }else if ([self.titleStr isEqualToString:@"修改手机号"]) {
        if ([self.remarkDelegate respondsToSelector:@selector(supplierPersonInfoPhone:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate supplierPersonInfoPhone:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }else if ([self.titleStr isEqualToString:@"修改简介"]) {
        if (self.noteTextView.text.length > self.limitCount) {
            Alertmsg(@"您输入的字数超限,请修改", nil)
        }else{
            if ([self.remarkDelegate respondsToSelector:@selector(supplierPersonInfoIntro:)]) {
                [self.remarkDelegate supplierPersonInfoIntro:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }

        }
      
    }else if ([self.titleStr isEqualToString:@"添加备注"]){
        if ([self.remarkDelegate respondsToSelector:@selector(addRemark:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate addRemark:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }else if ([self.titleStr isEqualToString:@"申请原因"]){
        if ([self.remarkDelegate respondsToSelector:@selector(addRemark:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate addRemark:_noteTextView.text];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }
    }else{
        if ([self.remarkDelegate respondsToSelector:@selector(yp_PersonOrder:AndTag:)]) {
            if (self.noteTextView.text.length > self.limitCount) {
                Alertmsg(@"您输入的字数超限,请修改", nil)
            }else{
                [self.remarkDelegate yp_PersonOrder:_noteTextView.text AndTag:self.dingzhiTag];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
    }
    
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
