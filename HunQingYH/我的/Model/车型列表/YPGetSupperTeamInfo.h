//
//  YPGetSupperTeamInfo.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetSupperTeamInfo : NSObject

/**车型*/
@property (nonatomic, copy) NSString *Parent;
/**照片*/
@property (nonatomic, copy) NSString *Img;
/**数量*/
@property (nonatomic, copy) NSString *NumBer;

///9.16 添加
/**车型ID 对应车型，只不过命名不同*/
@property (nonatomic, copy) NSString *ModelID;

@end
