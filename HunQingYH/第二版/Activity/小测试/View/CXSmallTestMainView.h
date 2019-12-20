//
//  CXSmallTestMainView.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//
// - - - - - - - - - - - - - - 测试信息采集- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXSmallTestMainView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateTF;

@property (weak, nonatomic) IBOutlet UITextField *hotelTF;

@property (weak, nonatomic) IBOutlet UITextField *hunShaTF;

@property (weak, nonatomic) IBOutlet UITextField *hunQingTF;

@property (weak, nonatomic) IBOutlet UIButton *SubBtn;

@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@property (weak, nonatomic) IBOutlet UIView *inputBgView;

@end

NS_ASSUME_NONNULL_END
