//
//  LWSearchView.h
//  Hdoctor
//
//  Created by lanwon on 15/12/4.
//  Copyright © 2015年 lanwon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)(id obj);

@protocol SearchViewDelegate;
@protocol SearchViewDataSource;

@interface SearchView : UIView
@property (nonatomic, weak) IBOutlet UITextField  *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (nonatomic, weak) id<SearchViewDelegate> delegate;
@property (nonatomic, weak) id<SearchViewDataSource> datasource;
@property (nonatomic, copy) backBlock block;
@end

@protocol SearchViewDelegate <NSObject>
// 可选
@optional
- (NSArray *)searchView:(SearchView *)searchView didInputKeyWord:(NSString *)keyword;  // 输入中
- (void)searchView:(SearchView *)searchView didSelectKeyWord:(NSString *)keyword;      // 选中某行
- (void)searchView:(SearchView *)searchView didDeleteKeyWord:(NSString *)keyword;      // 删除某行
- (void)searchView:(SearchView *)searchView shouldReturnKeyWord:(NSString *)keyword;   // 搜索
@end

@protocol SearchViewDataSource <NSObject>
// 必选
@required
- (NSArray *)searchView:(SearchView *)searchView; // 返回数据源
@end
