//
//  YPGetFileSupplierData.h
//  hunqing
//
//  Created by Else丶 on 2018/3/20.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetFileSupplierData : NSObject

/**Id*/
@property (nonatomic, copy) NSString *Id;
/**文件路径*/
@property (nonatomic, copy) NSString *FileUrl;
/**视频高清*/
@property(nonatomic,copy)NSString  *FileUrlHD;
/**视频普清*/
@property(nonatomic,copy)NSString  *FileUrlLD;
/**视频流畅*/
@property(nonatomic,copy)NSString  *FileUrlSD;
/**类型
 1图片 2视频*/
@property (nonatomic, copy) NSString *Type;
/**状态
 0未审核 1审核通过 2审核驳回*/
@property (nonatomic, copy) NSString *Status;
/**上传时间*/
@property (nonatomic, copy) NSString *CreateTime;

//3-21 添加
/**驳回理由*/
@property (nonatomic, copy) NSString *Reason;
/**原文件路径*/
@property (nonatomic, copy) NSString *OriginalFileUrl;

@end
