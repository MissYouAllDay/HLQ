//
//  HRYQDownLoadViewController.h
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRYQDownLoadViewController : UIViewController
/**邀请人数*/
@property(nonatomic,copy)NSString  *InvitedNumber;
/**活动ID*/
@property(nonatomic,copy)NSString  *ActivityID;

/**档次*/
@property (nonatomic, strong) NSArray *grades;
/**截止时间*/
@property (nonatomic, copy) NSString *endTime;

@end
