//
//  HRHotelTingTableViewController.h
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHotelTingTableViewController : UITableViewController
/**供应商ID*/
@property(nonatomic,assign)NSInteger  SupplierID;
/**酒店ID*/
@property(nonatomic,assign)NSInteger  RummeryID;
/**职业类别*/
@property(nonatomic,copy)NSString  *zhiyeName;
@end
