//
//  CXCommuntySecoundView.m
//  HunQingYH
//
//  Created by apple on 2019/10/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXCommuntySecoundView.h"
#import "SegMentView.h"
#import "YPGetWeddingInformationList.h"
#import "YPHome190226HunQianBiKanListController.h"
@interface CXCommuntySecoundView ()<UIScrollViewDelegate,CXSegMentDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SegMentView *segmentView;
//备婚笔记
///标题模型数组
@property (nonatomic, strong) NSMutableArray<YPGetWeddingInformationList *> *titleMarr;
///标题数组
@property (nonatomic, strong) NSMutableArray *tagMarr;
@end
@implementation CXCommuntySecoundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        self.segmentView.clipsToBounds = YES;
        [self addSubview:self.segmentView];
        [self addSubview:self.scrollView];
        [self GetWeddingInformationList];
    }
    return self;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT - self.segmentView.height)];
        _scrollView.showsVerticalScrollIndicator = MACH_SEND_NOTIFY;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (SegMentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[SegMentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _segmentView.delegate = self;
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, _segmentView.height - 1, ScreenWidth, 1);
        layer.backgroundColor = LineColor.CGColor;
        [_segmentView.layer addSublayer:layer];
    }
    return _segmentView;
}

- (void)segmentBar:(SegMentView *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {

    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = CGPointMake(ScreenWidth * toIndex, 0);
    }];
}

- (void)createSubViews {
    
    for (int i =0; i < self.titleMarr.count; i ++) {
        YPGetWeddingInformationList *model = self.titleMarr[i];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, self.height - self.segmentView.height)];
        YPHome190226HunQianBiKanListController *vc = [[YPHome190226HunQianBiKanListController alloc] init];
        vc.view.frame = bgView.bounds;
        vc.articleID = model.WeddingInformationID;
        [bgView addSubview:vc.view];
        [self.scrollView addSubview:bgView];
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.titleMarr.count, self.scrollView.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.segmentView.selectIndex = scrollView.contentOffset.x/ScreenWidth;
}


#pragma mark - 网络请求
#pragma mark 获取标题列表
- (void)GetWeddingInformationList{
    
    NSString *url = @"/api/HQOAApi/GetWeddingInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.titleMarr removeAllObjects];
            [self.tagMarr removeAllObjects];
            
            self.titleMarr = [YPGetWeddingInformationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetWeddingInformationList *info in self.titleMarr) {
                [self.tagMarr addObject:info.Title];
            }
            self.segmentView.dataArr = self.tagMarr;
            [self.segmentView makeShow];
            [self createSubViews];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetWeddingInformationList *> *)titleMarr{
    if (!_titleMarr) {
        _titleMarr = [NSMutableArray array];
    }
    return _titleMarr;
}

- (NSMutableArray *)tagMarr{
    if (!_tagMarr) {
        _tagMarr = [NSMutableArray array];
        
    }
    return _tagMarr;
}

@end
