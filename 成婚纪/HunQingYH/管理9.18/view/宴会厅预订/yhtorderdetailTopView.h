//
//  yhtorderdetailTopView.h
//  HunQingYH
//
//  Created by xl on 2019/6/22.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface yhtorderdetailTopView : UIView
@property (weak, nonatomic) IBOutlet UIView *topcolorView;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *phontBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;
+(instancetype)initViewWithXib;

@end

NS_ASSUME_NONNULL_END
