//
//  CXSmallTestVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/10.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXSmallTestResultVC.h"
#import "CXSmallTestResultView.h"


@interface CXSmallTestResultVC ()

@property (nonatomic, strong) CXSmallTestResultView  *mainView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) UIScrollView  *scrollView;           // <#这里是个注释哦～#>
@property (nonatomic, strong) UIImageView  *bannerImg;             // <#这里是个注释哦～#>
@property (nonatomic, strong) UILabel  *titleLab;    //    标题

@end

@implementation CXSmallTestResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bannerImg];
    [self.scrollView addSubview:self.mainView];
    [self.scrollView addSubview:self.titleLab];
}

-(UIImageView *)bannerImg {
    
    if (!_bannerImg) {
        _bannerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(270))];
        _bannerImg.backgroundColor = [UIColor orangeColor];
    }
    return _bannerImg;
}

- (CXSmallTestResultView *)mainView {
    
    if (!_mainView) {
        _mainView = [[CXSmallTestResultView alloc] initWithFrame:CGRectMake(0, self.bannerImg.bottom - 36, ScreenWidth, ScreenHeight - self.bannerImg.bottom + 36 - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
        _mainView.backgroundColor = [UIColor colorWithHexString:@"#FD5A4A"];
    }
    return _mainView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#FD5A4A"];
    }
    return _scrollView;
}

- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainView.top - Line375(38)/2, Line375(240), Line375(38))];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"测试结果";
        _titleLab.backgroundColor = [CXUtils colorWithHexString:@"#FED349"];
        _titleLab.textColor = [CXUtils colorWithHexString:@"#C82326"];
        _titleLab.layer.cornerRadius = _titleLab.height/2;
    }
    return _titleLab;
}

@end
