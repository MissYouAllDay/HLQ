//
//  HRYQBeiHunViewController.h
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRYQBeiHunViewController : UIViewController
/**邀请备婚人数*/
@property(nonatomic,assign)NSInteger  WeddingNumber;
/**签单人数*/
@property(nonatomic,assign)NSInteger  SignatureNumber;
/**活动ID*/
@property(nonatomic,copy)NSString  *ActivityID;
/**截止时间*/
@property (nonatomic, copy) NSString *endTime;
/**档次*/
@property (nonatomic, strong) NSArray *grades;
@end
