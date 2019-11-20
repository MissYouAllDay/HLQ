//
//  YPGetNewPeopleInfo.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetNewPeopleInfo : NSObject

/**新人姓名*/
@property (nonatomic, copy) NSString *Name;
/**出生日期*/
@property (nonatomic, copy) NSString *DateOfBirth;
/**籍贯*/
@property (nonatomic, copy) NSString *PlaceOfOrigin;
/**星座*/
@property (nonatomic, copy) NSString *Constellation;
/**职业*/
@property (nonatomic, copy) NSString *Occupation;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**QQ号*/
@property (nonatomic, copy) NSString *QQNumber;
/**微信号*/
@property (nonatomic, copy) NSString *WechatNumber;

@end
