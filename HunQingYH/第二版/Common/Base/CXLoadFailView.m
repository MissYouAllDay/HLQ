//
//  CXLoadFailView.m
//  HuanXinDemo
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 HuaTingAuto. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - - - 请求失败  - - - - - - - - - - - - - - - - - - - - - -

#import "CXLoadFailView.h"


@interface CXLoadFailView ()

@property (nonatomic, strong) UIView *markView;

@end

@implementation CXLoadFailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.markView];
        self.hidden = YES;
    }
    return self;
}

- (UIView *)markView {
    
    if (!_markView) {
        
        _markView = [[UIView alloc] initWithFrame:self.bounds];
        _markView.backgroundColor = [UIColor whiteColor];
        _markView.clipsToBounds = YES;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 100)/2, Line375(100), 100, 100)];
        _imgView.image = [UIImage imageNamed:@"loadFail"];
        [_markView addSubview:_imgView];
        
        _alertLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.bottom, self.width, 22)];
        [_markView addSubview:_alertLab];
        _alertLab.text = @"请求失败了喽～";
        _alertLab.font = [UIFont systemFontOfSize:12];
        _alertLab.textColor = RGBS(51);
        _alertLab.textAlignment = NSTextAlignmentCenter;
    }
    return _markView;
}

@end
