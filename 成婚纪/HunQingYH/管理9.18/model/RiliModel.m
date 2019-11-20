//
//  RiliModel.m
//  HunQingYH
//
//  Created by xl on 2019/7/4.
//  Copyright © 2019 xl. All rights reserved.
//

#import "RiliModel.h"

@implementation RiliModel

- (void)setDay:(NSString *)Day {
    
    if (!ISEMPTY(Day)) {
        _Day = Day;
    }
}

- (void)setNumber:(NSString *)Number {
    
       if (!ISEMPTY(Number)) {
         _Number = Number;
     }
}
@end
