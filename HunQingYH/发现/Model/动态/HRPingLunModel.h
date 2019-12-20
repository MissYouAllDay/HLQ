//
//  HRPingLunModel.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/22.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRPingLunModel : NSObject
/**评论ID*/
@property(nonatomic,copy)NSString  *CommentsID;
/**评论人姓名*/
@property(nonatomic,copy)NSString  *CommentserName;
/**评论时间*/
@property(nonatomic,copy)NSString   *CommentsCreateTime;
/**评论内容*/
@property(nonatomic,copy)NSString  *CommentsContent;
/**头像*/
@property(nonatomic,copy)NSString  *CommentsHeadportrait;

///4-13 添加
/**评论人ID*/
@property (nonatomic, copy) NSString *CommentsPeopleId;

///5-28 添加
/**评论人身份*/
@property (nonatomic, copy) NSString *Profession;

@end
