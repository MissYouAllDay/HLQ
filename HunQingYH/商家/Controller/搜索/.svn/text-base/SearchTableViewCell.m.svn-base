//
//  CustomTableViewCell.m
//  lallal
//
//  Created by lanwon on 16/2/24.
//  Copyright © 2016年 lanwon. All rights reserved.
//

#import "SearchTableViewCell.h"

@interface SearchTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end

@implementation SearchTableViewCell

- (void)awakeFromNib {
   [super awakeFromNib];
    self.keyWordLb.numberOfLines = 1;
    self.backgroundColor = [UIColor whiteColor];
}

- (IBAction)deleteClick:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:self.keyWordLb.text];
    }
}
@end
