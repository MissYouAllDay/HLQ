//
//  YPOurNewWedsHotelInfoController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPOurNewWedsHotelDelegate <NSObject>

@optional
- (void)yp_Hotel;

@end

@interface YPOurNewWedsHotelInfoController : UIViewController

@property (nonatomic, assign) id<YPOurNewWedsHotelDelegate> hotelDelegate;

/**
 新人订制ID
 */
@property (nonatomic, copy) NSString *peopleCustomID;
/**酒店名称*/
@property (nonatomic, copy) NSString *hotelName;
/**酒店地址*/
@property (nonatomic, copy) NSString *hotelAddress;
/**厅名*/
@property (nonatomic, copy) NSString *hallName;
/**桌数*/
@property (nonatomic, copy) NSString *tableCount;
/**酒店宴会厅相关照片*/
@property (nonatomic, copy) NSString *rummeryImg;
/**酒店宴会厅尺寸*/
@property (nonatomic, copy) NSString *rummeryXls;

@end
