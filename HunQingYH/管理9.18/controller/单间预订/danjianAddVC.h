//
//  danjianAddVC.h
//  HunQingYH
//
//  Created by xl on 2019/7/8.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface danjianAddVC : UIViewController
/**日期*/
@property(nonatomic,copy)NSDate  *timeDate;
/**<#注释#>*/
@property(nonatomic,copy)NSString  *danjianName;
/***/
@property(nonatomic,copy)NSString  *Id;
/**0午餐,1晚餐*/
@property(nonatomic,copy)NSString  *type;

/**1编辑*/
@property(nonatomic,copy)NSString  *formType;
/**记录id*/
@property(nonatomic,copy)NSString  *recordId;
@end

NS_ASSUME_NONNULL_END
