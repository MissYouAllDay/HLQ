//
//  YPGetWeddingPackageEvaluateList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetWeddingPackageEvaluateList : NSObject

/**评论Id*/
@property (nonatomic, copy) NSString *Id;
/**评论人Id*/
@property (nonatomic, copy) NSString *PeopleId;
/**内容*/
@property (nonatomic, copy) NSString *Content;
/**图片*/
@property (nonatomic, copy) NSString *Image;

///6-14 添加
/**评论人姓名*/
@property (nonatomic, copy) NSString *PeopleName;
/**评论人头像*/
@property (nonatomic, copy) NSString *PeopleImage;
/**评论人职业*/
@property (nonatomic, copy) NSString *PeopleOccupation;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

@end
