//
//  YPReToBeCheckDetailImgsCell.h
//  hunqing
//
//  Created by Else丶 on 2018/3/21.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetFileSupplierData.h"
#import "YPHotelImgColCell.h"
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"

@interface YPReToBeCheckDetailImgsCell : UITableViewCell<YPImagesGroupViewDelegate>

/**用户端-供应商 去掉 不合格*/
@property (nonatomic, copy) NSString *isCustomerPortCorper;

@property (nonatomic, strong) NSArray<YPGetFileSupplierData *> *imgArr;

@property (weak, nonatomic) IBOutlet UIView  *moreImgsView;

@property (nonatomic, strong) HZImagesGroupView *imagesGroupView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
