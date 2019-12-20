//
//  YPAddYanHuiTingController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAddYanHuiTingController : UIViewController
@property (nonatomic, strong) NSMutableArray *imgLists;

/**厅名字*/
@property(nonatomic,copy)NSString  *tingName;
/**最低价位*/
@property(nonatomic,assign)float  lowestPrice;
/**桌数*/
@property(nonatomic,assign)NSInteger  tableNum;

/**类型  1添加 2编辑*/
@property(nonatomic,copy)NSString  *typeStr;

@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) UITextField *priceTF;
@property (nonatomic, strong) UITextField *countTF;
@end
