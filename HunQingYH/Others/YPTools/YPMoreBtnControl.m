//
//  YPMoreBtnControl.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMoreBtnControl.h"

// 判断是否是iPhone X
#define YP_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenWidth  (int)[[UIScreen mainScreen] bounds].size.width
#define ScreenHeight (int )[[UIScreen mainScreen] bounds].size.height
#define YP_NAVIGATION_HEIGHT (YP_iPhoneX ? 88.f : 64.f)

@interface YPMoreBtnControl ()

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

/** 按钮名称数组 */
@property (nonatomic, strong, readwrite) NSArray *btnTitleArr;///< 必传-初始化方法中

@end

@implementation YPMoreBtnControl{
    UIView *_backView;
    
    CGFloat _top;//标题行高度
    NSInteger _maxRow;//行数
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *)titleArr{
    if (self = [super initWithFrame:frame]) {
        self.btnTitleArr = [NSArray arrayWithArray:titleArr];
        [self initializeData];
        [self setupUI];
        [self addTarget:self action:@selector(controlRemove) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initializeData{
    _top = 60;
    if (_btnCol == 0) {
        _btnCol = 3;
    }
    _maxRow = self.btnTitleArr.count / self.btnCol; //行
    if (!_titleStr) {
        _titleStr = @"选择下列选项";
    }
    if (_leftRightMargin == 0) {
        _leftRightMargin = 18.0f;
    }
    if (_btnMargin == 0) {
        _btnMargin = 15.0f;
    }
    if (_btnHeight == 0) {
        _btnHeight = 40.0f;
    }
    if (_controlAlpha == 0) {
        _controlAlpha = 0.4f;
    }
    if (!_normalTitleColor) {
        _normalTitleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    }
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor whiteColor];
    }
    if (!_normalColor) {
        _normalColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
    }
    if (!_selectedColor) {
        _selectedColor = [UIColor colorWithRed:250/255.0f green:80/255.0f blue:120/255.0f alpha:1];
    }
    _viewWidth = ScreenWidth - self.leftRightMargin*2;
    _viewHeight = _top + _maxRow * (self.btnHeight + self.btnMargin) + self.btnMargin + self.btnHeight;
}

#pragma mark - UI
- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:self.controlAlpha];
    
    CGFloat width = (ScreenWidth-18*2-2*self.btnMargin)/self.btnCol;
    
    _maxRow = self.btnTitleArr.count / self.btnCol; //行
    
    if (!_backView) {
        _backView = [[UIView alloc]init];
    }
    _backView.backgroundColor = WhiteColor;
    
    _backView.frame = CGRectMake(0, -(self.viewHeight), ScreenWidth, self.viewHeight);
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.titleStr;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.centerX.mas_equalTo(_backView);
    }];
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(controlRemove) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label);
        make.right.mas_equalTo(-18);
    }];
    
    // 循环创建按钮
    for (NSInteger i = 0; i < self.btnTitleArr.count; i++) {
        
        UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proBtn.backgroundColor = self.normalColor;
        proBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        proBtn.clipsToBounds = YES;
        proBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [proBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
        [proBtn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger col = i % self.btnCol; //列
        proBtn.x = 18 + col * (width + self.btnMargin);
        NSInteger row = i / self.btnCol; //行
        proBtn.y = _top + row * (self.btnHeight + self.btnMargin);
        proBtn.width = width;
        proBtn.height = self.btnHeight;
        [proBtn setTitle:self.btnTitleArr[i] forState:UIControlStateNormal];
        
        if ([proBtn.titleLabel.text isEqualToString:self.selectedBtn.titleLabel.text]) {
            proBtn.selected = YES;
            proBtn.enabled = NO;
            [proBtn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
            proBtn.backgroundColor = self.selectedColor;
        }else{
            proBtn.selected = NO;
            proBtn.enabled = YES;
            [proBtn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
            proBtn.backgroundColor = self.normalColor;
        }
        
        [_backView addSubview:proBtn];
        proBtn.tag = i;
        [self.btnArray addObject:proBtn];
    }
}

- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);

    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
            [btn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
        } else {
            btn.selected = NO;
            [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        }
        btn.backgroundColor = self.normalColor;
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        btn.backgroundColor = self.selectedColor;
        [btn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = self.normalColor;
        [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
    }
    if (!self.selectBlock) {
        self.selectBlock(sender.titleLabel.text);
    }
    [self controlRemove];
}

#pragma mark - Show
- (void)showControl{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.frame = CGRectMake(0, 0, ScreenWidth, self.viewHeight);
        [self addSubview:_backView];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    } completion:nil];
}

#pragma mark - Remove
- (void)controlRemove{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.frame = CGRectMake(0, -(self.viewHeight), ScreenWidth, self.viewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter


@end
