//
//  HRDongTaiModel.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/22.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRDongTaiModel : NSObject
/**动态ID*/
@property(nonatomic,copy)NSString  *DynamicID;
/**发起人ID*/
@property(nonatomic,copy)NSString  *ObjectId;
/**发起人头像*/
@property(nonatomic,copy)NSString  *DynamicerHeadportrait;
/**发起人名字*/
@property(nonatomic,copy)NSString  *DynamicerName;
/**标题*/
@property(nonatomic,copy)NSString  *Title;
/**内容*/
@property(nonatomic,copy)NSString  *Content;
/**文件地址*/
@property(nonatomic,copy)NSString  *FileId;
/**文件类型 1照片 2视频*/
@property(nonatomic,assign)NSInteger  FileType;
/**浏览量*/
@property(nonatomic,assign)NSInteger  BrowseCount;
/**点赞量*/
@property(nonatomic,assign)NSInteger  GivethumbCount;
/**点赞状态*/
@property(nonatomic,assign)NSInteger  State;
/**分享量*/
@property(nonatomic,assign)NSInteger  ShareCount;
/**评论量*/
@property(nonatomic,assign)NSInteger  CommentsCount;
/**评论时间*/
@property(nonatomic,copy)NSString  *CreateTime;

/**身份编码*/
@property(nonatomic,copy)NSString  *OccupationCode;

/**封面图*/
@property(nonatomic,copy)NSString  *CoverImg;



//TODO:旧版 手否删除待定
/**发起人类型*/
@property(nonatomic,assign)NSInteger  ObjectTypes;


//


@property (nonatomic, assign, getter = isLiked) BOOL liked;
/**喜欢数字*/
@property(nonatomic,assign)NSInteger  likeNum;

//8-10


@end
