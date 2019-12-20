//
//  HRDongTaiModel.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/22.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDongTaiModel.h"

@implementation HRDongTaiModel
-(void)setLiked:(BOOL)liked{
    if (_State ==1) {
    
        _liked =1;
    }else{
        _liked =0;
    }
}
@end
