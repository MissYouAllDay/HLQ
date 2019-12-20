//
//  DemoVC1Cell.h
//  XHWebImageHeightLayoutExample
//
//  Created by zhuxiaohui on 2016/11/15.
//  Copyright © 2016年 it7090.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoVC1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, copy) NSString *imgStr;

/**6-20 点击查看单张大图/全部 lookAll-全部  7-5 婚嫁节 不能点击看大图*/
@property (nonatomic, copy) NSString *lookAll;

@end
