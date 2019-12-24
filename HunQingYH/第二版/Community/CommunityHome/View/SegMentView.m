//
//  SegMentView.m
//  loveSearch
//
//  Created by mac on 2019/1/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SegMentView.h"

@interface SegMentView ()

/** 滚动图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 起始位置 */
@property (nonatomic, assign) CGFloat oriX;
/** 记录点击的button */
@property (nonatomic, strong) UIButton *markBtn;
@property (nonatomic, strong) UIView  *sliderView;    // 滑块
@property (nonatomic, assign) CGFloat sliderWidth;    // k滑块的长度

@end

@implementation SegMentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.oriX = 0;
        self.itemW = 0;
        self.sliderWidth = self.itemW - 10;
        self.selectIndex = 0;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)makeShow {
    
    if (self.itemW == 0) {
        _itemW = ScreenWidth / self.dataArr.count;
    }
    [self loadSubView];
}

- (void)setDataArr:(NSArray *)dataArr {
    
    _dataArr = dataArr;
    
//    [self loadSubView];
}

- (void)setSelectIndex:(int)selectIndex {
    
    _selectIndex = selectIndex;
    
    if (!_dataArr) {
        
        return;
    }
    
    UIButton *btn = [self.scrollView viewWithTag:1000 + selectIndex];
    [self selectBtnAction:btn];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (void)loadSubView {
    
    for (int i = 0; i < self.dataArr.count; i ++) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.oriX, 0, self.itemW, self.height)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bgView.bounds;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = 1000 + i;
        [btn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [bgView addSubview:btn];
        [self.scrollView addSubview:bgView];
        
        self.oriX += self.itemW;
        
        if (i == self.selectIndex) {
            self.markBtn = btn;
            self.markBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
            _sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.markBtn.left + (self.markBtn.width - self.sliderWidth)/2, self.markBtn.bottom -self.markBtn.bottom, self.sliderWidth, 4)];
//            _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.markBtn.height)];
            _sliderView.backgroundColor = [UIColor greenColor];
            [self.scrollView addSubview:self.sliderView];
            self.sliderView.layer.cornerRadius = self.sliderView.height/2;
            self.sliderView.clipsToBounds = YES;
        }
    }
}

- (void)selectBtnAction:(UIButton *)sender {
    
    if (self.markBtn == sender) {
        return;
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
            [self.delegate segmentBar:self didSelectIndex:sender.tag - 1000 fromIndex:self.markBtn.tag - 1000];
    }
    
    self.markBtn.selected = NO;
    self.markBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.markBtn = sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.left = (self.markBtn.width - self.sliderWidth)/2;
    }];
}



@end
