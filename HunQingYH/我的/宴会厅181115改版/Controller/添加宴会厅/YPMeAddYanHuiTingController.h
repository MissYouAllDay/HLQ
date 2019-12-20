//
//  YPMeAddYanHuiTingController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMeAddYanHuiTingController : UIViewController

/**名称*/
@property (nonatomic, strong) UITextField *nameTF;
/**面积*/
@property (nonatomic, strong) UITextField *mianjiTF;
/**长度*/
@property (nonatomic, strong) UITextField *lengthTF;
/**宽度*/
@property (nonatomic, strong) UITextField *widthTF;
/**层高*/
@property (nonatomic, strong) UITextField *cenggaoTF;
/**容纳桌数-最小*/
@property (nonatomic, strong) UITextField *tableMinTF;
/**容纳桌数-最大*/
@property (nonatomic, strong) UITextField *tableMaxTF;
/**详情图*/
@property (strong, nonatomic) NSMutableArray *upfmArray;

@property (nonatomic, copy) NSString *BanquetID;

///**页面类型  1上传  2编辑*/
//@property (nonatomic, copy) NSString  *leixingStr;

@end

NS_ASSUME_NONNULL_END
