//
//  YPSupplierInfoAddYouhuiController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPSupplierInfoAddYouhuiController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) NSInteger limitCount;//限制字数

@property (nonatomic, copy) NSString *editRemark;
/**修改-记录ID*/
@property (nonatomic, copy) NSString *recordID;

@end

NS_ASSUME_NONNULL_END
