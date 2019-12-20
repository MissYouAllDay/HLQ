//
//  YPReMeInfoController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReMeInfoController : UIViewController

/**头像*/
@property (nonatomic, copy) NSString *imageURL;
/**名称*/
@property (nonatomic, copy) NSString *nameStr;
/**职业*/
@property (nonatomic, copy) NSString *professionStr;

/**id*/
@property(nonatomic,copy)NSString  *id;
/**种类 1 动态 2视频*/
@property(nonatomic,copy)NSString  *type;
@end
