//
//  UITextField+YPTextField.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/22.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "UITextField+YPTextField.h"

@implementation UITextField (YPTextField)

- (void)yp_textFieldDidChangedWithMaxLimit:(NSInteger)maxLimit{
    UITextRange *selectedRange = self.markedTextRange;
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    
    if (maxLimit == 0) {
        return;
    }
    
    if (self.text.length > maxLimit) {
        self.text = [self.text substringToIndex:maxLimit];
    }
    
    //UI更新
}

@end
