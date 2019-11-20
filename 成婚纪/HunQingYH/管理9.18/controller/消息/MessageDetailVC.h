//
//  MessageDetailVC.h
//  HunQingYH
//
//  Created by xl on 2019/8/14.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailVC : UIViewController
@property(nonatomic,copy)NSString  *Id;
/**接单状态 0未接单，1接单，2拒单*/
@property(nonatomic,copy)NSString  *ReceiptType;
/**0宴会厅 1单间*/
@property(nonatomic,copy)NSString  *type;
@end

NS_ASSUME_NONNULL_END
