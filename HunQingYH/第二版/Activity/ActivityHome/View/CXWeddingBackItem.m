//
//  CXWeddingBackItem.m
//  HunQingYH
//
//  Created by canxue on 2019/11/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXWeddingBackItem.h"

@implementation CXWeddingBackItem

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainIcon.contentMode = UIViewContentModeScaleToFill;
}

- (void)setModel:(YPGetCommodityTypeTableListData *)model {
    
    _model = model;
    
    [self.mainIcon sd_setImageWithURL:[NSURL URLWithString:self.model.ShowImage] placeholderImage:nil];
    self.name.text = self.model.Name;
    self.pricelab.text = [NSString stringWithFormat:@"¥ %@",self.model.Quota];
}
@end
