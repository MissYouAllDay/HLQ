//
//  HRHotelJSTableViewController.h
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHotelJSTableViewController : UITableViewController
/**供应商ID*/
@property(nonatomic,assign)NSInteger  SupplierID;
/**职业*/
@property(nonatomic,copy)NSString  *ProfessionID;
/**地区*/
@property(nonatomic,copy)NSString  *Region;
/**简介*/
@property(nonatomic,copy)NSString  *BriefinTroduction;
/**手机号*/
@property(nonatomic,copy)NSString  *PhoneNo;
/**名称*/
@property(nonatomic,copy)NSString  *Name;
/**所属公司*/
@property(nonatomic,copy)NSString  *OwnedCompany;
/**酒店ID*/
@property(nonatomic,assign)NSInteger  RummeryID;
/**婚庆公司ID*/
@property(nonatomic,assign)NSInteger  CorpID;
/**地址*/
@property(nonatomic,copy)NSString  *Adress;
/**创建时间*/
@property(nonatomic,copy)NSString  *CreateTime;
/**头像*/
@property(nonatomic,copy)NSString  *Headportrait;
/**年龄*/
@property(nonatomic,assign)NSInteger  Age;
/**联系人*/
@property(nonatomic,copy)NSString  *TrueName;
/**是否收藏 0未收藏 1已收藏*/
@property(nonatomic,assign)NSInteger  IsCollection;
/**是否能被搜索到 1搜索到*/
@property(nonatomic,assign)NSInteger  IsSearch;
/**简介行高*/
@property(nonatomic,assign)CGFloat  rowhight;
@property(nonatomic,strong)NSMutableArray *anLiArr;
@end
