//
//  YPGetFacilitatorActivityIdentityList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetFacilitatorActivityIdentityList : NSObject

/**身份编码*/
@property (nonatomic, copy) NSString *IdentityId;
/**身份名称*/
@property (nonatomic, copy) NSString *Name;

///18-10-25 修改
/**TopImg*/
@property (nonatomic, copy) NSString *TopImg;

@end
