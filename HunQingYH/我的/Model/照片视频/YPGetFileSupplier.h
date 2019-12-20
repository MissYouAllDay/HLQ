//
//  YPGetFileSupplier.h
//  hunqing
//
//  Created by Else丶 on 2018/3/20.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetFileSupplierData.h"

@interface YPGetFileSupplier : NSObject

/**总数量*/
@property (nonatomic, copy) NSString *TotalCount;
/**新娘姓名*/
@property (nonatomic, copy) NSString *BrideName;
/**新娘手机号*/
@property (nonatomic, copy) NSString *BridePhone;
/**新郎姓名*/
@property (nonatomic, copy) NSString *GroomName;
/**新郎手机号*/
@property (nonatomic, copy) NSString *GroomPhone;
/**婚庆公司名字*/
@property (nonatomic, copy) NSString *CorpName;
/**公司id*/
@property (nonatomic, copy) NSString *CorpId;
/**Data*/
@property (nonatomic, strong) YPGetFileSupplierData *Data;

@end
