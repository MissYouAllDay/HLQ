//
//  HRCarStyleModel.h
//  HunQingYH
//
//  Created by DiKai on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRCarStyleModel : NSObject
/**车型*/
@property(nonatomic,copy)NSString  *Parent;
/**照片*/
@property(nonatomic,copy)NSString  *Img;
/**数量*/
@property(nonatomic,assign)NSInteger  NumBer;
@end
