//
//  MCFlowLayout.m
//  collectionviewTestWithFlowLayout
//
//  Created by macan on 16/3/9.
//  Copyright © 2016年 macan. All rights reserved.
//

#import "MCFlowLayout.h"

#define MCSize  [UIScreen mainScreen].bounds.size
@implementation MCFlowLayout


- (instancetype)init
{
    
    if (self = [super init]) {
        self.itemSize = (CGSize){MCSize.width/2, 100};
    }
    return  self;
}

- (void)prepareLayout
{
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}


@end
