//
//  danjianOrderDetailVC.h
//  HunQingYH
//
//  Created by xl on 2019/7/7.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface danjianOrderDetailVC : UIViewController
@property(nonatomic,copy)NSString  *Id;
/**0午餐,1晚餐*/
@property(nonatomic,copy)NSString  *type;
/**单间id*/
@property(nonatomic,strong)NSString  *danjianId;
/**单间数组*/
@property(nonatomic,strong)NSMutableArray  *danjianArray;
@end

NS_ASSUME_NONNULL_END
