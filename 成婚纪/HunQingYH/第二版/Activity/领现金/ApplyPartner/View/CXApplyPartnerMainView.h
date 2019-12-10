//
//  CXApplyPartnerMainView.h
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXApplyPartnerMainView : UIView


@property (weak, nonatomic) IBOutlet UIView *nameBgView;
@property (weak, nonatomic) IBOutlet UIView *telBgView;
@property (weak, nonatomic) IBOutlet UIView *addressBgView;
@property (weak, nonatomic) IBOutlet UIView *detailBgView;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@end

NS_ASSUME_NONNULL_END
