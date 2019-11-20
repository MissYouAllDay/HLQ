//
//  HRAddYanHuiTingController.h
//  HunQingYH
//
//  Created by DiKai on 2017/9/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRAddYanHuiTingController : UIViewController
/**厅名字*/
@property(nonatomic,copy)NSString  *tingName;
/**最低价位*/
@property(nonatomic,assign)float  lowestPrice;
/**桌数*/
@property(nonatomic,assign)NSInteger  tableNum;



@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) UITextField *priceTF;
@property (nonatomic, strong) UITextField *countTF;
@property (strong, nonatomic) NSMutableArray *upfmArray;
@property (strong, nonatomic) NSMutableArray *upXCArray;

/**页面类型  1上传  2编辑*/
@property(nonatomic,copy)NSString  *leixingStr;

@property(nonatomic,copy)NSString *BanquetID;
@end
