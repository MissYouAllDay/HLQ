//
//  YPGetHotelBanquetlList.h
//  HunQingYH
//
//  Created by Else丶 on 2019/5/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetHotelBanquetlList : NSObject

/**宴会厅id*/
@property (nonatomic, copy) NSString *Id;
/**名称*/
@property (nonatomic, copy) NSString *Name;
/**桌数*/
@property (nonatomic, copy) NSString *TableNumber;
/**酒店头像*/
@property (nonatomic, copy) NSString *HotelImage;
/**Data_1*/
@property (nonatomic, strong) NSArray *Data_1;

@end

NS_ASSUME_NONNULL_END
