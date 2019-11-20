//
//  customerModel.h
//  HunQingYH
//
//  Created by xl on 2019/7/4.
//  Copyright © 2019 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface customerModel : NSObject
/**身份*/
@property(nonatomic,copy)NSString  *shenfenStr;
/**姓名*/
@property(nonatomic,copy)NSString  *nameStr;
/**电话*/
@property(nonatomic,copy)NSString  *phoneStr;

@end

NS_ASSUME_NONNULL_END
