//
//  CXReceiveMoneyVC.h
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 全额返现 - - - - - - - - - - - - - - - - - - 

#import <UIKit/UIKit.h>
#import <JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXReceiveMoneyVC : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) UINavigationController  *mainNav;    // <#这里是个注释哦～#>
@end

@interface CXReceiveMoneyRow : UICollectionViewCell

@property (nonatomic, strong) UIImageView  *img;    // <#这里是个注释哦～#>

@end

NS_ASSUME_NONNULL_END
