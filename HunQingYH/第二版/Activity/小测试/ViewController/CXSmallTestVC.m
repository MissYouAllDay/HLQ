//
//  CXSmallTestVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/10.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXSmallTestVC.h"
#import "CXSmallTestMainView.h"
@interface CXSmallTestVC ()

@property (nonatomic, strong) CXSmallTestMainView  *mainView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) UIScrollView  *scrollView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) UIImageView  *bannerImg;    // <#这里是个注释哦～#>
@end

@implementation CXSmallTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bannerImg];
    [self.scrollView addSubview:self.mainView];
}

-(UIImageView *)bannerImg {
    
    if (!_bannerImg) {
        _bannerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(270))];
        _bannerImg.backgroundColor = [UIColor orangeColor];
    }
    return _bannerImg;
}

- (CXSmallTestMainView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXSmallTestMainView" owner:nil options:nil] lastObject];
        _mainView.frame = CGRectMake(0, self.bannerImg.bottom - 36, ScreenWidth, Line375(370));
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

@end
