//
//  CXApplyPartnerVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayVC.h"
#import "CXInviteHotelStayHeaderView.h"
#import "CXInvitehotelStayMainView.h"

#import "CXInviteHotelStayLogVC.h" //  邀请记录

@interface CXInviteHotelStayVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXInvitehotelStayMainView  *mainView;    // <#这里是个注释哦～#>
@end

@implementation CXInviteHotelStayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒店入住";
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"hotelStay" highImageName:@"hotelStay" target:self action:@selector(pushCXInviteHotelStayLogVC)];
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"kefu" highImageName:@"kefu" target:self action:@selector(shareAction)];

    self.navigationItem.rightBarButtonItems = @[item,item1];
    [self loadSubViews];
}

- (void)loadSubViews {
    
    CXInviteHotelStayHeaderView *cell = [[[NSBundle mainBundle] loadNibNamed:@"CXInviteHotelStayHeaderView" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0, 0, ScreenWidth, 380);
    
    self.mainView.frame = CGRectMake(0, cell.bottom, ScreenWidth, 500);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:cell];
    [self.scrollView addSubview:self.mainView];

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, cell.height + self.mainView.height + HOME_INDICATOR_HEIGHT);
    self.scrollView.height = self.view.height - NAVIGATION_BAR_HEIGHT;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1002) {
        
        return NO;
    }
    return YES;
}

// MARK: - Unitl
- (void)shareAction {
    
    NSLog(@"你点击了分享");
}

// MARK: - 懒加载
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#FD8071"];
    }
    
    return _scrollView;
}

- (CXInvitehotelStayMainView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXInvitehotelStayMainView" owner:nil options:nil] lastObject];
        _mainView.addressTF.delegate = self;
    }
    return _mainView;
}

// MARK: - push
- (void)pushCXInviteHotelStayLogVC {
    
    CXInviteHotelStayLogVC *vc = [[CXInviteHotelStayLogVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
