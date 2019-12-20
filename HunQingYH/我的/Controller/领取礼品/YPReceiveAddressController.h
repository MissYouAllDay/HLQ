//
//  YPReceiveAddressController.h
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YPReceiveAddressController : UIViewController
/**相关对象类型 0公司加入供应商、1供应商邀请供应、2微信投票、3邀请备婚、4新人出方案 5爆米花抽奖 6酒店新人出方案*/
@property(nonatomic,assign)NSInteger  ObjectTypes;
/**档次*/
@property (nonatomic, copy) NSString *grade;
/**活动ID*/
@property (nonatomic, copy) NSString *ActivityID;
/**活动奖品ID*/
@property(nonatomic,assign)NSInteger  ActivityPrizesID;
/**微信领奖码*/
@property(nonatomic,copy)NSString  *weiCode;

@end
