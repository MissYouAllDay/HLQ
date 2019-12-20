//
//  CXReviceSuccessVC.h
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXReviceSuccessVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UILabel *alertLab;
/** <#name#> */
@property (nonatomic, copy) NSString *name;
- (IBAction)subBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
