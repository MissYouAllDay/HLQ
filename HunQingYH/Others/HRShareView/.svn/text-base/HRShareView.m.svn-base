//
//  HRShareView.m
//  HunQingYH
//
//  Created by Dikai on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRShareView.h"
#import "HRShareItemButton.h"

//背景色
#define SHARE_BG_COLOR                        XNColor(239, 240, 241, 1)
//高
#define SHARE_BG_HEIGHT                       XNWindowHeight/2.6
//
#define SHARE_SCROLLVIEW_HEIGHT               (SHARE_BG_HEIGHT-40)/2
//item宽
#define SHARE_ITEM_WIDTH                      XNWindowWidth*0.15
//左间距
#define SHARE_ITEM_SPACE_LEFT                 15
//间距
#define SHARE_ITEM_SPACE                      10
//第一行 item  base tag
#define ROW1BUTTON_TAG                        1000
//第二行 item base tag
#define ROW2BUTTON_TAG                        600
//item base tag
#define BUTTON_TAG                            700
//背景view tag
#define BG_TAG                                1234

#define XNColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define XNWindowWidth        ([[UIScreen mainScreen] bounds].size.width)

#define XNWindowHeight       ([[UIScreen mainScreen] bounds].size.height)

#define XNFont(font)         [UIFont systemFontOfSize:(font)]

#define XNWidth_Scale        [UIScreen mainScreen].bounds.size.width/375.0f
static id _publishContent;
static HRShareView *shareView = nil;
@interface HRShareView(){
    NSArray *_DataArray;
    NSMutableArray *_ButtonTypeShareArray1;
    NSMutableArray *_ButtonTypeShareArray2;
    NSArray *_typeArray1;
    NSArray *_typeArray2;
}

@end
@implementation HRShareView

/**
 *  分享
 *
 *  @param content     内容
 *  @param resultBlock 结果
 */
+ (void)showShareViewWithPublishContent:(id)content
                                 Result:(ShareResultBlock)resultBlock{
    
    [[self alloc] initPublishContent:content
                              Result:resultBlock];
  

}
/**
 *  分享
 *
 *  @param content     内容
 *  @param resultBlock 结果
 */
- (void)initPublishContent:(id)content
                    Result:(ShareResultBlock)resultBlock{
    
    _publishContent = content;
    if (!shareView) {
        shareView = [[HRShareView alloc] init];
    }
    shareView.shareResultBlock =resultBlock;
//    resultBlock(1, YES);
    [self initData];
    [self initShareUI];
    
   
}

- (void)initData{
    
    _DataArray = @[@{@(0):@[@{@"朋友圈":@"分享朋友圈"}
                            ,@{@"微信好友":@"分享微信"}
                            ,@{@"QQ":@"分享QQ"}
//                            ,@{@"QQ空间":@"分享QQ空间"}
//                            ,@{@"新浪微博":@"分享微博"}
                            ]}
                   
                   ,@{@(1):@[
//                             @{@"短信":@"分享信息"}
//                             ,@{@"邮件":@"邮件"}
                             @{@"复制链接":@"复制链接"}
                             ]}];
    
    
    
    
 
    
    _typeArray1 = @[@(SSDKPlatformSubTypeWechatTimeline),
                    @(SSDKPlatformSubTypeWechatSession),
                    @(SSDKPlatformSubTypeQQFriend),
                    @(SSDKPlatformSubTypeQZone),
                    @(SSDKPlatformTypeSinaWeibo)];
    
    _typeArray2 = @[@(SSDKPlatformTypeSMS),
                    @(SSDKPlatformTypeMail),
                    @(SSDKPlatformTypeCopy)];
    
    
    _ButtonTypeShareArray1 = [NSMutableArray array];
    _ButtonTypeShareArray2 = [NSMutableArray array];
}

/**
 *  初始化视图
 */
- (void)initShareUI{
    
    CGRect orginRect = CGRectMake(0, XNWindowHeight, XNWindowWidth, SHARE_BG_HEIGHT);
    
    CGRect finaRect = orginRect;
    finaRect.origin.y =  XNWindowHeight-SHARE_BG_HEIGHT;
    
    /***************************** 添加底层bgView ********************************************/
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XNWindowWidth, XNWindowHeight)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    bgView.tag = BG_TAG;
    [window addSubview:bgView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(dismissShareView)];
    [bgView addGestureRecognizer:tap1];
    
    /***************************** 添加分享shareBGView ***************************************/
    
    UIVisualEffectView *shareBGView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    shareBGView.frame = orginRect;
    shareBGView.userInteractionEnabled = YES;
    shareBGView.backgroundColor = [SHARE_BG_COLOR colorWithAlphaComponent:0.5];
    [bgView addSubview:shareBGView];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(tapNoe)];
    [shareBGView addGestureRecognizer:tap2];
    /****************************** 添加item ************************************************/
    for (int i = 0; i<_DataArray.count; i++) {
        UIScrollView *rowScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, i*(SHARE_SCROLLVIEW_HEIGHT+0.5), shareBGView.width, SHARE_SCROLLVIEW_HEIGHT)];
        rowScrollView.directionalLockEnabled = YES;
        rowScrollView.showsVerticalScrollIndicator = NO;
        rowScrollView.showsHorizontalScrollIndicator = NO;
        rowScrollView.backgroundColor = [UIColor clearColor];
        [shareBGView.contentView addSubview:rowScrollView];
        
        /* add item */
        NSArray *itemArray = _DataArray[i][@(i)];
        rowScrollView.contentSize = CGSizeMake((SHARE_ITEM_WIDTH+SHARE_ITEM_SPACE_LEFT+SHARE_ITEM_SPACE)*itemArray.count, SHARE_SCROLLVIEW_HEIGHT);
        //按钮数组
        for (NSDictionary *itemDict in itemArray) {
            NSInteger index           = [itemArray indexOfObject:itemDict];
            HRShareItemButton *button = [HRShareItemButton shareButton];
            CGFloat itemHeight        = SHARE_ITEM_WIDTH+15;
            CGFloat itemY             = (SHARE_SCROLLVIEW_HEIGHT-itemHeight)/2;
            
            NSInteger imageTag = 0;
            if (i == 0) {
                [_ButtonTypeShareArray1 addObject:button];
                imageTag = ROW1BUTTON_TAG+index;
            } else {
                imageTag = ROW2BUTTON_TAG+index;
                [_ButtonTypeShareArray2 addObject:button];
            }
            button = [[HRShareItemButton alloc] initWithFrame:CGRectMake(SHARE_ITEM_SPACE_LEFT+index*(SHARE_ITEM_WIDTH+SHARE_ITEM_SPACE), itemY+SHARE_ITEM_WIDTH, SHARE_ITEM_WIDTH, itemHeight)
                                                    ImageName:[itemDict allValues][0]
                                                     imageTag:imageTag
                                                        title:[itemDict allKeys][0]
                                                    titleFont:10
                                                   titleColor:[UIColor blackColor]];
            
            button.tag = BUTTON_TAG+imageTag;
            [button addTarget:shareView
                       action:@selector(shareTypeClickIndex:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [rowScrollView addSubview:button];
            if (i == 0) {
                [_ButtonTypeShareArray1 addObject:button];
            } else {
                [_ButtonTypeShareArray2 addObject:button];
            }
            
        }
        if (i == 0) {
            /*line*/
            UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(SHARE_ITEM_SPACE_LEFT, rowScrollView.height, shareBGView.width-SHARE_ITEM_SPACE_LEFT*2, 0.5)];
            lineView.backgroundColor = XNColor(210, 210, 210, 1);
            [shareBGView.contentView addSubview:lineView];
        }
    }
    /****************************** 取消 ********************************************/
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, shareBGView.height-40, shareBGView.width, 40);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = XNFont(16);
    cancleButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.userInteractionEnabled =YES;
    [cancleButton addTarget:shareView action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBGView.contentView addSubview:cancleButton];
    
    /****************************** 动画 ********************************************/
    shareBGView.alpha = 0;
    [UIView animateWithDuration:0.35
                     animations:^{
                         bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                         shareBGView.frame = finaRect;
                         shareBGView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    
    for (HRShareItemButton *button in _ButtonTypeShareArray1) {
        NSInteger idx = [_ButtonTypeShareArray1 indexOfObject:button];
        
        [UIView animateWithDuration:0.9+idx*0.1 delay:0 usingSpringWithDamping:0.52 initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect buttonFrame = [button frame];
            buttonFrame.origin.y -= SHARE_ITEM_WIDTH;
            button.frame = buttonFrame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    for (HRShareItemButton *button in _ButtonTypeShareArray2) {
        NSInteger idx = [_ButtonTypeShareArray2 indexOfObject:button];
        
        [UIView animateWithDuration:0.9+idx*0.1 delay:0 usingSpringWithDamping:0.52 initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect buttonFrame = [button frame];
            buttonFrame.origin.y -= SHARE_ITEM_WIDTH;
            button.frame = buttonFrame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (void)shareTypeClickIndex:(UIButton *)btn {
    
    NSInteger tag = btn.tag-BUTTON_TAG;
//    NSInteger intV = tag % ROW1BUTTON_TAG;
//    NSInteger intV1 = tag % ROW2BUTTON_TAG;
//    NSInteger countRow1 = _typeArray1.count;
//    NSInteger countRow2 = _typeArray2.count;
    NSInteger shareType = 0;
    NSLog(@"%zd",tag);
    switch (tag) {
        case 1000:
            //朋友圈
            shareType =SSDKPlatformSubTypeWechatTimeline;
            break;
        case 1001:
            //微信
             shareType =SSDKPlatformSubTypeWechatSession;
            break;
        case 1002:
            //QQ
             shareType =SSDKPlatformSubTypeQQFriend;
            break;
        case 1003:
            //空间
             shareType =SSDKPlatformSubTypeQZone;
            break;
        case 10004:
            //微博
             shareType =SSDKPlatformTypeSinaWeibo;
            break;
//        case 600:
//            //短信
//             shareType =SSDKPlatformTypeSMS;
//            break;
//        case 601:
//            //邮件
//             shareType =SSDKPlatformTypeMail;
//            break;
        case 600:
            //复制链接
              shareType =SSDKPlatformTypeCopy;
            break;
            
        default:
            break;
    }
    
    // share type
//    NSUInteger typeUI = 0;
//    if (intV>=0&&intV<=countRow1) {
//      //第一行
//        typeUI = [_typeArray1[intV] unsignedIntegerValue];
////          NSLog(@"%zd个‘",typeUI);
//
//    } else if (intV1>=0&&intV1<=countRow2){
//        //第二行
//        typeUI = [_typeArray2[intV1] unsignedIntegerValue];
////          NSLog(@"%zd个‘",typeUI);
//    }
//
  
    
//    //built share parames
    NSDictionary *shareContent = (NSDictionary *)_publishContent;
    NSLog(@"%@",shareContent);
    NSString *title            =shareContent[@"title"];
    NSString *text             = shareContent[@"text"];
    NSArray *image             = shareContent[@"image"];
    NSString *url              = shareContent[@"url"];
    
    //    NSString *str =  [ShareSDK sdkVer];//3.5.0
    //    BOOL author = [ShareSDK hasAuthorized:SSDKPlatformSubTypeWechatSession];//NO
    
    //1、创建分享参数
    if (image) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:image
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
    
        /*
         调用shareSDK的无UI分享类型，
         */
        [ShareSDK share:shareType parameters:shareParams onStateChanged:^(SSDKResponseState state,NSDictionary *userData, SSDKContentEntity *contentEntity,NSError *error) {
            //block
            self.shareResultBlock(state, shareType);
         
        }];
        
    }
    
    
    

    [self dismissShareView];

    
}


- (void)dismissShareView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:BG_TAG];
    [UIView animateWithDuration:0.3
                     animations:^{
                         blackView.alpha = 0;
                         CGRect blackFrame = [blackView frame];
                         blackFrame.origin.y = XNWindowHeight;
                         blackView.frame = blackFrame;
                     }
                     completion:^(BOOL finished) {
                         
                         [blackView removeFromSuperview];
                         
                     }];
    
}

- (void)tapNoe{
    
}
@end
