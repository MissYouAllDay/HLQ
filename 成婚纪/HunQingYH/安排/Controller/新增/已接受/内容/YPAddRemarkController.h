//
//  YPAddRemarkController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPAddRemarkDelegate <NSObject>

@optional
- (void)addRemark:(NSString *)remark;// --- 新增-已接受-修改备注使用 -- 废弃 ✘
- (void)hotelInfoName:(NSString *)title;
- (void)hotelInfoAddress:(NSString *)address;
- (void)supplierPersonInfoName:(NSString *)name;//昵称
- (void)supplierPersonInfoPhone:(NSString *)phone;//手机号
- (void)supplierPersonInfoIntro:(NSString *)intro;//简介

- (void)yp_PersonOrder:(NSString *)content AndTag:(NSString *)tag;

@end

typedef void(^YPAddRemarkBlock)(NSString *titleStr,NSString *remark);

@interface YPAddRemarkController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) NSInteger limitCount;//限制字数

@property (nonatomic, copy) NSString *editRemark;

/**私人定制标识*/
@property (nonatomic, copy) NSString *dingzhiTag;

@property (nonatomic, assign) id<YPAddRemarkDelegate> remarkDelegate;

@property (nonatomic, copy) YPAddRemarkBlock yp_AddBlock;

@end
