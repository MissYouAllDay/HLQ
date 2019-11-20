//
//  YPWedPackageDetailWuLiaoController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/14.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPWedPackageDetailWuLiaoController : UIViewController

///标记: 0: 默认 1: 特惠(分享)
@property (nonatomic, assign) NSInteger typeTag;

/**内容*/
@property (nonatomic, copy) NSString *contentStr;

//18-11-07 分享
/**分享标题*/
@property (nonatomic, copy) NSString *ShareTitle;
/**分享描述*/
@property (nonatomic, copy) NSString *ShareDescribe;
/**记录ID*/
@property (nonatomic, copy) NSString *RecordID;

@end
