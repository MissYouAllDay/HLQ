//
//  ContactModel.h
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "JSONModel.h"

@interface ContactModel : JSONModel

@property (nonatomic,strong) NSString <Ignore>  *pinyin;//拼音

/**车型ID*/
@property (nonatomic, copy) NSString *CarModelID;
/**车型名称*/
@property (nonatomic, copy) NSString *Name;
/**图片*/
@property (nonatomic, copy) NSString *CarImg;
/**颜色*/
@property (nonatomic, copy) NSString *Color;

///9.12 添加
/**品牌名称 -- 我的->我的车辆*/
@property (nonatomic, copy) NSString *BrandName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
