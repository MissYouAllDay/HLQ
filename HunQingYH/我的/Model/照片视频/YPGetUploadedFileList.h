//
//  YPGetUploadedFileList.h
//  hunqing
//
//  Created by Else丶 on 2018/3/20.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetUploadedFileList : NSObject

/**封面图*/
@property (nonatomic, copy) NSString *ImgUrl;
/**类型 1图片 2视频*/
@property (nonatomic, copy) NSString *FileType;
/**客户id*/
@property (nonatomic, copy) NSString *CustomerId;
/**新郎姓名*/
@property (nonatomic, copy) NSString *GroomName;
/**新郎手机号*/
@property (nonatomic, copy) NSString *GroomPhone;
/**新娘姓名*/
@property (nonatomic, copy) NSString *BrideName;
/**新娘手机号*/
@property (nonatomic, copy) NSString *BridePhone;
/**上传者姓名*/
@property (nonatomic, copy) NSString *UpsName;
/**上传时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**驳回数量*/
@property (nonatomic, copy) NSString *RejectCount;
/**婚庆公司名*/
@property (nonatomic, copy) NSString *CorpName;

@end
