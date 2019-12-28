//
//  CXWeddingBackItem.h
//  HunQingYH
//
//  Created by canxue on 2019/11/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetCommodityTypeTableListData.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXWeddingBackItem : UICollectionViewCell

@property (nonatomic, strong) YPGetCommodityTypeTableListData  *model;    // <#这里是个注释哦～#>
@property (weak, nonatomic) IBOutlet UIImageView *mainIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@end

NS_ASSUME_NONNULL_END
