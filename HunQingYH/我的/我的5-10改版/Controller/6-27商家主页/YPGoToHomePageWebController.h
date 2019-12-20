//
//  YPGoToHomePageWebController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "BasicWebViewVC.h"

@interface YPGoToHomePageWebController : BasicWebViewVC

@property (nonatomic, copy) NSString *professionID;

/**网页URL*/
@property(nonatomic,copy)NSString *webUrl;
/**是否显示分享按钮 默认显示*/
@property(nonatomic,assign)BOOL isShareBtn;
/**分享url*/
@property (nonatomic,copy) NSString *shareURL;
/**分享标题 标题为空时默认标题、描述、图标都使用默认，标题不为空请传描述和图标*/
@property (nonatomic,copy) NSString *shareTitle;
/**分享描述*/
@property (nonatomic,copy) NSString *shareDesText;
/**分享图标*/
@property (nonatomic,copy) NSString *shareIcon;

@end
