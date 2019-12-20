//
//  YPReActivityAllListController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetFacilitatorActivityCoverMapListData.h"

@interface YPReActivityAllListController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
/**身份ID*/
@property (nonatomic, copy) NSString *IdentityId;
@property (nonatomic, strong) NSArray<YPGetFacilitatorActivityCoverMapListData *> *dataArr;

@end
