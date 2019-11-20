//
//  YPNewAddDriverModel.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPNewAddDriverModel : NSObject

/**是否展开*/
@property (nonatomic, assign) BOOL isOpen;
/**车名*/
@property (nonatomic, copy) NSString *carName;
/**车手*/
@property (nonatomic, strong) NSArray *drivers;

@end
