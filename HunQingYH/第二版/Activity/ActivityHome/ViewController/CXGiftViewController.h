//
//  CXGiftViewController.h
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 婚礼福利 - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>
#import <JXCategoryListContainerView.h>
NS_ASSUME_NONNULL_BEGIN

@interface CXGiftViewController : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *allIds;

@end

NS_ASSUME_NONNULL_END
