//
//  YPGetWeddingPlanning.h
//  HunQingYH
//
//  Created by Else丶 on 2019/4/5.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetWeddingPlanning : NSObject

/**服务商Id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**服务商登录*/
@property (nonatomic, copy) NSString *UserId;
/**服务商名称*/
@property (nonatomic, copy) NSString *FacilitatorName;
/**服务商地址*/
@property (nonatomic, copy) NSString *FacilitatorAddress;
/**服务商头像*/
@property (nonatomic, copy) NSString *FacilitatorImage;
/**首页banner*/
@property (nonatomic, copy) NSString *Banner;
/**简介*/
@property (nonatomic, copy) NSString *AbstractData;
/**服务内容*/
@property (nonatomic, copy) NSString *ContentData;
/**新人评价*/
@property (nonatomic, copy) NSString *EvaluateData;

@end

NS_ASSUME_NONNULL_END
