//
//  CXMyCouponNotUsedDetailVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponUseSuccessVC.h"
#import "CXMyCouponUseResultActivityView.h"        // 活动信息
#import "CXMyCouponDetailCodeCell.h"    // 二维码
#import "CXQRCode.h"                    // 生成二维码
@interface CXMyCouponUseSuccessVC ()

@property (nonatomic, strong) UIScrollView              *scrollView;    //
@property (nonatomic, strong) CXMyCouponUseResultActivityView *activityCell;  // 活动cell
@property (nonatomic, strong) CXMyCouponDetailCodeCell  *codeCell;      // 二维码cell
@property (nonatomic, strong) UILabel  *statusLab;    // 状态

@end

@implementation CXMyCouponUseSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.statusLab];
    [self.scrollView addSubview:self.activityCell];
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
    self.codeCell.alertlab.hidden = YES;

    [self payFaildStatus];
}

- (void)paySucceedStatus {
    
    [self payStatusWithStatus:@"支付成功" withAlert:@"活动名称 活动名称 活动名称"];
    
    self.activityCell.hidden = YES;
    self.codeCell.top = self.statusLab.bottom + 10;
}

- (void)payFaildStatus {
    
    [self payStatusWithStatus:@"扫码失败" withAlert:@"请确认该券使用商家及使用时间"];
}

- (void)payStatusWithStatus:(NSString *)status withAlert:(NSString *)alertText {
    
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.minimumLineHeight = 30;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",status,alertText] attributes:@{NSFontAttributeName:FontW(24, UIFontWeightBold),NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#2B2B2B"],NSParagraphStyleAttributeName:paragraph}];
    [att addAttributes:@{NSFontAttributeName:FontW(13, UIFontWeightMedium),NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#9F9E9E"]} range:NSMakeRange(status.length + 1, alertText.length)];
    
    self.statusLab.attributedText = att;
}

-(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CXMyCouponUseResultActivityView *)activityCell {
    
    if (!_activityCell) {
        _activityCell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponUseResultActivityView" owner:nil options:nil] lastObject];
        _activityCell.frame = CGRectMake(0, self.statusLab.bottom + 10, ScreenWidth, 95);
    }
    return _activityCell;
}

- (CXMyCouponDetailCodeCell *)codeCell {
    if (!_codeCell) {
        _codeCell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponDetailCodeCell" owner:nil options:nil] lastObject];
        _codeCell.frame = CGRectMake(0, self.activityCell.bottom + 10, ScreenWidth, 305);
    }
    return _codeCell;
}

- (UILabel *)statusLab {
    
    if (!_statusLab) {
        _statusLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 102)];
        _statusLab.numberOfLines = 2;
    }
    return _statusLab;
}

@end
