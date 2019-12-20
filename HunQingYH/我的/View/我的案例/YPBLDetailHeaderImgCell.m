//
//  YPBLDetailHeaderImgCell.m
//  MEMCoupon
//
//  Created by YanpengLee on 2016/12/8.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import "YPBLDetailHeaderImgCell.h"
#import "HZPhotoBrowserView.h"

@interface YPBLDetailHeaderImgCell ()

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation YPBLDetailHeaderImgCell{
    HZPhotoBrowserView *_backView;
    UIImageView *_bigImgV;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPBLDetailHeaderImgCell";
    YPBLDetailHeaderImgCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPBLDetailHeaderImgCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackImgV:(UIImageView *)backImgV{
    _backImgV = backImgV;
    
    _backImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneImgTap)];
    [_backImgV addGestureRecognizer:tap];
    
    
}

- (void)oneImgTap{
    
    _backView = [[HZPhotoBrowserView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //    // 设置阴影背景的点击响应，此处为收起大图
    //    _backView.userInteractionEnabled = YES;
    
    _backView.backgroundColor = [UIColor blackColor];
    [_backView setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:nil];
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBigImage)];
    [_backView addGestureRecognizer:bgTap];
    
    _backView.frame = CGRectOffset([UIApplication sharedApplication].keyWindow.rootViewController.view.frame,0 , [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height);
    float height = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height;
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
                         _backView.center = CGPointMake(_backView.center.x, _backView.center.y - height);
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }];
    

//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight - 70, 55, 30)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderWidth = 0.1;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    saveButton.layer.cornerRadius = 2;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:saveButton];
    
}

#pragma mark 保存图像
- (void)saveImage
{
    
    UIImageWriteToSavedPhotosAlbum(_backView.imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = _backView.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.50f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 60);
    label.center = _backView.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:21];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = @"保存失败";
    }   else {
        label.text = @"保存成功";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)dismissBigImage{
    
    CGRect oneImgBtnFrame = _backImgV.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _bigImgV.frame = CGRectMake(ScreenWidth*0.5, ScreenHeight*0.5, oneImgBtnFrame.size.width*0.01, oneImgBtnFrame.size.height*0.01);
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_bigImgV removeFromSuperview];
        [_backView removeFromSuperview];
        
        _bigImgV = nil;
        _backView = nil;
    });
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
