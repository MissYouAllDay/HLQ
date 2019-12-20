//
//  YPGetWebBannerUrl.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/8.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetWebBannerUrl : NSObject

/**图片地址*/
@property (nonatomic, copy) NSString *BannerURL;
/**要跳转的页面地址    如果为空 则不跳转*/
@property (nonatomic, copy) NSString *HTMLURL;
/**banner编码
 HLDB  婚礼担保
 MFCFA 免费出方案
 MFBC 免费保存视频照片
 CHJJM 婚礼桥加盟
 MFBHL 免费办婚礼(APP)
 MFBHL_S免费办婚礼小图
 YQHYJH 邀请好友结婚
 DHY 订婚宴
 HJCGJ 婚嫁采购节
 */
@property (nonatomic, copy) NSString *BannerCode;

@end
