//
//  CXMyCouponNotUsedDetailVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponNotUsedDetailVC.h"
#import "CXMyCouponDetailCell.h"        // 活动信息
#import "CXMyCouponDetailShopCell.h"    // 店铺信息
#import "CXMyCouponDetailCodeCell.h"    // 二维码
#import "CXQRCode.h"                    // 生成二维码
@interface CXMyCouponNotUsedDetailVC ()

@property (nonatomic, strong) UIScrollView              *scrollView;    //
@property (nonatomic, strong) CXMyCouponDetailCell      *activityCell;  // 活动cell
@property (nonatomic, strong) CXMyCouponDetailShopCell  *shopCell;      // 店铺信息
@property (nonatomic, strong) CXMyCouponDetailCodeCell  *codeCell;      // 二维码cell

@end

@implementation CXMyCouponNotUsedDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.activityCell];
    [self.scrollView addSubview:self.shopCell];
    [self.scrollView addSubview:self.codeCell];
    
    [self defaSetting];
    
    self.scrollView.backgroundColor = [CXUtils colorWithHexString:@"#F1F0F0"];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.codeCell.bottom + HOME_INDICATOR_HEIGHT + 20);
}

- (void)defaSetting {
    NSString *baseUrl = @"https://www.baidu.com";
    UIImage *qrCodeImage = [CXQRCode qrCodeImageWithContent:baseUrl
                                              codeImageSize:73
                                                       logo:nil
                                                  logoFrame:CGRectZero
                                                        red:0.0f
                                                      green:0/255.0f
                                                       blue:0/255.0f];
    self.codeCell.qrCodeImg.image =  qrCodeImage;
    
}

-(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CXMyCouponDetailCell *)activityCell {
    
    if (!_activityCell) {
        _activityCell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponDetailCell" owner:nil options:nil] lastObject];
        _activityCell.frame = CGRectMake(0, 10, ScreenWidth, 95);
    }
    return _activityCell;
}

- (CXMyCouponDetailShopCell *)shopCell {
    if (!_shopCell) {
        _shopCell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponDetailShopCell" owner:nil options:nil] lastObject];
        _shopCell.frame = CGRectMake(0, self.activityCell.bottom + 10, ScreenWidth, 158);
    }
    return _shopCell;
}

- (CXMyCouponDetailCodeCell *)codeCell {
    if (!_codeCell) {
        _codeCell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponDetailCodeCell" owner:nil options:nil] lastObject];
        _codeCell.frame = CGRectMake(0, self.shopCell.bottom + 10, ScreenWidth, 325);
    }
    return _codeCell;
}

@end
