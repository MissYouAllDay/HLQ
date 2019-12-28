//
//  CXLoadNullView.m
//  HuanXinDemo
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 HuaTingAuto. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - - - 没有数据  - - - - - - - - - - - - - - - - - - - - - -

#import "CXLoadNullView.h"

@interface CXLoadNullView ()

@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UIButton *markBtn;

@end

@implementation CXLoadNullView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.markView];
    }
    return self;
}

- (UIView *)markView {
    
    if (!_markView) {
        _markView = [[UIView alloc] initWithFrame:self.bounds];
        _markView.backgroundColor = [UIColor whiteColor];
        _markView.clipsToBounds = YES;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 100)/2, Line375(100), 100, 100)];
        _imgView.image = [UIImage imageNamed:@"HYTH_nodata"];
        [_markView addSubview:_imgView];
        _imgView.userInteractionEnabled = YES;
        
        _alertLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.bottom, self.width, 22)];
        [_markView addSubview:_alertLab];
        _alertLab.text = @"空空如也哦～";
        _alertLab.userInteractionEnabled = YES;
        _alertLab.textAlignment = NSTextAlignmentCenter;
        _alertLab.font = [UIFont systemFontOfSize:12];
        _alertLab.textColor = RGBS(51);
        
        _addLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _alertLab.bottom + 3, self.width, 22)];
        [_markView addSubview:_addLab];
        _addLab.text = @"立即添加";
        _addLab.userInteractionEnabled = YES;
        _addLab.textAlignment = NSTextAlignmentCenter;
        _addLab.font = [UIFont systemFontOfSize:14];
        _addLab.textColor = RGB(255, 100, 50);
        
        _markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _markBtn.frame = CGRectMake(_imgView.x, _imgView.y, _imgView.width, _addLab.bottom - _imgView.top);
        [_markView addSubview:_markBtn];
        [_markBtn addTarget:self action:@selector(clickMarkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _markView;
}
// 添加n按钮 点击事件
- (void)clickMarkBtnAction {

    if (self.markBlock) {
        self.markBlock();
    }
}

- (void)selectMarkBtnAction:(MarkBtnBloack)markBlock {
    
    _markBlock = markBlock;
}
@end
