//
//  CXBackMoneyListVC.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//
// - - - - - - - - - - - - - - 立返商家 - - - - - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXBackMoneyListVC : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, assign) int type;    // 类型 0:酒店 1:婚庆 2:婚纱

@end

NS_ASSUME_NONNULL_END
