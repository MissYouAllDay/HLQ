//
//  YPBHWelfareController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBHWelfareController : UIViewController

/**签单人数*/
@property(nonatomic,assign)NSInteger  SignatureNumber;
/**活动ID*/
@property(nonatomic,copy)NSString  *ActivityID;

/**档次*/
@property (nonatomic, strong) NSArray *grades;
/**预算*/
@property(nonatomic,assign)NSInteger  Budget;

@end
