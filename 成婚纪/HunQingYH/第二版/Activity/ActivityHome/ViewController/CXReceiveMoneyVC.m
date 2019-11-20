//
//  CXReceiveMoneyVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveMoneyVC.h"
#import "CXReceiveMoneyView.h"

@interface CXReceiveMoneyVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CXReceiveMoneyView *mainView;

@end

@implementation CXReceiveMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.mainView];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.mainView.height + 50 );
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - Line375(50))];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (CXReceiveMoneyView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXReceiveMoneyView" owner:nil options:nil] lastObject];
        _mainView.frame = CGRectMake(0, 0, ScreenWidth, Line375(552));
    }
    return _mainView;
}

- (UIView *)listView {
    
    return self.view;
}
@end
