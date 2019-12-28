//
//  CXGiftGoodDetailVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGiftGoodDetailVC.h"
#import "CXGiftGoodDetailView.h"
#import "CXActivityCouponModel.h"   // model
#import "XHWebImageAutoSize.h"
@interface CXGiftGoodDetailVC ()
@property (nonatomic, strong) UIScrollView  *scrollView;    //
@property (nonatomic, strong) CXGiftGoodDetailView  *mainView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXActivityCouponModel  *model;    // <#这里是个注释哦～#>
@property (nonatomic, strong) UITableView  *tableView;    // <#这里是个注释哦～#>
@end

@implementation CXGiftGoodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.mainView];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.mainView.bottom + HOME_INDICATOR_HEIGHT);
    
    [self loadGiftInfoDetailData];
}

- (void)configerUI {
    
    
    
}

- (void)loadGiftInfoDetailData {
    
    NSString *url = URL_ACTIVITY_GetCouponInfo;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.giftId forKey:@"Id"];
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        NSLog(@"%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.model = [CXActivityCouponModel mj_objectWithKeyValues:object];
            self.mainView.model = self.model;
            [self addDetailImgs:self.model.DetailMap];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowEmptyView showEmptyViewWithTitle:@"网络错开小差了" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
            [self loadGiftInfoDetailData];
        }];
    }];
    
}

- (void)addDetailImgs:(NSString *)imgsString {
    
    NSArray *imgArr = [imgsString componentsSeparatedByString:@","];
    
    CGFloat top = self.mainView.bottom;
    
    [self createDetailImgs:0 withTop:top withAllImgs:imgArr];
//    for (int i = 0; i < imgArr.count; i ++) {
//
//        NSURL *url = [NSURL URLWithString:imgArr[i]];
//        CGFloat hei = 200;
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, hei)];
//        [img sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            [XHWebImageAutoSize imageHeightForURL:url layoutWidth:ScreenWidth estimateHeight:200];
//
//        }];
//        img.height = hei;
//        [self.scrollView addSubview:img];
//        top += hei;
//    }
//
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth, top);
}

- (void)createDetailImgs:(int)index withTop:(CGFloat)top withAllImgs:(NSArray *)imgArr{
    
    NSURL *url = [NSURL URLWithString:imgArr[index]];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, 200)];
    img.clipsToBounds = YES;
    int next = index + 1;
    NSArray *imgs = imgArr;
    __block CGFloat topNum = top;
    [img sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        CGFloat hei = (CGFloat)image.size.height * (CGFloat)ScreenWidth / (CGFloat)image.size.width;
        img.height = hei;
        topNum = topNum + hei;
        
        if (next < imgArr.count) {
            [self createDetailImgs:next withTop:topNum withAllImgs:imgArr];
        }
        self.scrollView.contentSize = CGSizeMake(ScreenWidth, topNum);
    }];
    
    [self.scrollView addSubview:img];
    
}

// MARK: - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NAVIGATION_HEIGHT_S)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CXGiftGoodDetailView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXGiftGoodDetailView" owner:nil options:nil] lastObject];
        _mainView.frame = CGRectMake(0, 0, ScreenWidth, Line375(770));
    }
    return _mainView;
}



@end
