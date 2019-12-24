//
//  SegMentView.h
//  loveSearch
//
//  Created by mac on 2019/1/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SegMentView;
@protocol CXSegMentDelegate <NSObject>

- (void)segmentBar:(SegMentView *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end

@interface SegMentView : UIView


/** 默认选择的位置 默认为0 */
@property (nonatomic, assign) int selectIndex;
/** 代理 */
@property (nonatomic, weak) id<CXSegMentDelegate> delegate;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

/** item宽度 */
@property (nonatomic, assign) CGFloat itemW;

- (void)makeShow;


@end

NS_ASSUME_NONNULL_END
