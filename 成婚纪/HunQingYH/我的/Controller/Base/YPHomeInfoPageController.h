//
//  YPHomeInfoPageController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPHomeInfoPageController : UIViewController

/**头像*/
@property (nonatomic, copy) NSString *imageURL;
/**名称*/
@property (nonatomic, copy) NSString *nameStr;
/**职业ID*/
@property (nonatomic, copy) NSString *professionStr;

/**id*/
@property(nonatomic,copy)NSString  *ObjectId;
/**种类 1 动态 2视频 3全部*/
@property(nonatomic,copy)NSString  *type;

/**5-29 职业*/
@property (nonatomic, copy) NSString *profession;

@end
