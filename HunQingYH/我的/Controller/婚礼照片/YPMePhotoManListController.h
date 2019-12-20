//
//  YPMePhotoManListController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMePhotoManListController : UIViewController

/**身份 1:新人  0:其他(供应商)*/
@property (nonatomic, copy) NSString *professionStr;


/**跳转类型 1照片 2视频*/
@property(nonatomic,copy)NSString  *fromType;
@end
