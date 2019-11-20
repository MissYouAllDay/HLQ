//
//  HRDTDetailViewController.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRDTDetailViewController : UIViewController
/**动态ID*/
@property(nonatomic,copy)NSString  *DynamicID;

/**0 来自我的动态/全部 1其他*/
@property(nonatomic,copy)NSString  *fromType;
@end
