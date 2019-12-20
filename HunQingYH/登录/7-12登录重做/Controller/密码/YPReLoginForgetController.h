//
//  YPReLoginForgetController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReLoginForgetController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
@property (nonatomic, copy) NSString *inType;

@end
