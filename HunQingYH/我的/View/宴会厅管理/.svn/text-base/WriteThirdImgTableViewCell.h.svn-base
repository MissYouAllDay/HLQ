//
//  WriteThirdImgTableViewCell.h
//  Coupon
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 shanshanxu. All rights reserved.
//
@protocol DeleteImgDelegate <NSObject>

-(void)onBtClickForDel:(NSUInteger )number;
-(void)onBtClickForPick;
@end
#import <UIKit/UIKit.h>

@interface WriteThirdImgTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *bt1;
@property (strong, nonatomic) IBOutlet UIButton *bt2;

@property (strong, nonatomic) IBOutlet UIButton *bt3;
@property(nonatomic,weak)id<DeleteImgDelegate>delegate;
- (IBAction)onClick:(UIButton *)sender;
+(CGFloat)getHeight;

@end
