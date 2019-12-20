//
//  YPGetActivitySponsor.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetActivitySponsor : NSObject

/**主办方Logo*/
@property (nonatomic, copy) NSString *SponsorLogo;
/**主办方名称*/
@property (nonatomic, copy) NSString *SponsorName;
/**主办方信息*/
@property (nonatomic, copy) NSString *SponsorInfo;

///7-5
/**门票价格*/
@property (nonatomic, copy) NSString *TicketPrice;
/**主办方价格*/
@property (nonatomic, copy) NSString *SponsorPrice;

@end
