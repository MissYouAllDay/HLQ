//
//  UITextField+YPTextField.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/22.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (YPTextField)

/**
 * 判断是否包含高亮字符,不计入字数
 */
- (void)yp_textFieldDidChangedWithMaxLimit:(NSInteger)maxLimit;

@end

NS_ASSUME_NONNULL_END
