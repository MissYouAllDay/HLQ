//
//  YPEDuBaseController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryListContainerView.h>
@interface YPEDuBaseController : UIViewController<JXCategoryListContentViewDelegate>

///**18-09-17 活动ID*/
//@property (nonatomic, copy) NSString *ActivityId;
/**Type 0伴手礼,1婚礼返还,2代收*/
@property (nonatomic, copy) NSString *typeStr;

@end
