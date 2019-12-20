//
//  YPCreateShenFenController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPCreateShenFenController : UIViewController

/**验证码ID*/
@property (nonatomic, copy) NSString *authCodeID;
/**手机号*/
@property (nonatomic, copy) NSString *phoneNo;
/**职业ID*/
@property (nonatomic, copy) NSString *professionID;
/**职业*/
@property (nonatomic, copy) NSString *professionName;

@end
