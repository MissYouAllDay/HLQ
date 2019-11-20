//
//  YPPhotoListColCell.m
//  hunqing
//
//  Created by Else丶 on 2018/3/19.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPPhotoListColCell.h"

@implementation YPPhotoListColCell{
    UIImageView *_image;
//    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleAspectFill;
        _image.clipsToBounds = YES;
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(frame.size.height*0.8);
        }];
        
//        _label = [[UILabel alloc]init];
//        _label.textColor = LightGrayColor;
//        _label.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:_label];
//        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.mas_equalTo(self.contentView);
//            make.height.mas_equalTo(frame.size.height*0.2);
//            make.top.mas_equalTo(_image.mas_bottom);
//        }];
    }
    return self;
}

//- (void)setPhotoModel:(YPGetFileSupplierData *)photoModel{
//    _photoModel = photoModel;
//    
//    [_image sd_setImageWithURL:[NSURL URLWithString:_photoModel.FileUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        _image.alpha = 0;
//        //旋转
//        //      _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
//        //缩放
//        _image.transform = CGAffineTransformMakeScale(0.6, 0.6);
//        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
//            
//            _image.transform = CGAffineTransformIdentity;
//            _image.alpha = 1;
//            
//        } completion:nil];
//        
////        _label.alpha = 0;
////        //旋转
////        //      _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
////        _label.text = @"";
////        //缩放
////        _label.transform = CGAffineTransformMakeScale(0.6, 0.6);
////        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
////
////            _label.transform = CGAffineTransformIdentity;
////            _label.alpha = 1;
////
////        } completion:nil];
//        
//    }];
//}

- (void)setDataModel:(YPGetFileSupplierData *)dataModel{
    _dataModel = dataModel;
    
    [_image sd_setImageWithURL:[NSURL URLWithString:_dataModel.FileUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _image.alpha = 0;
        //旋转
        //      _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
        //缩放
        _image.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            
            _image.transform = CGAffineTransformIdentity;
            _image.alpha = 1;
            
        } completion:nil];
        
    }];
}

@end
