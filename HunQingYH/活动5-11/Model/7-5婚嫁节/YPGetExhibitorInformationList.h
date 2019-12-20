//
//  YPGetExhibitorInformationList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetExhibitorInformationList : NSObject

/**参展商名称*/
@property (nonatomic, copy) NSString *ExhibitorName;
/**参展商logo*/
@property (nonatomic, copy) NSString *ExhibitorLogo;
/**参展商信息*/
@property (nonatomic, copy) NSString *ExhibitorInfo;
/**类别*/
@property (nonatomic, copy) NSString *WeddingClass;

@end
