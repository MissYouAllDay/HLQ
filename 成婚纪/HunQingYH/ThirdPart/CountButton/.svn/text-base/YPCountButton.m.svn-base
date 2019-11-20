//
//  YPCountButton.m
//  MEMCoupon
//
//  Created by Else丶 on 2017/3/7.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPCountButton.h"
#import "UIImage+ResizeImg.h"

@implementation YPCountButton{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
}

@synthesize normalStateImageName = _normalStateImageName;
@synthesize highlightedStateImageName;
@synthesize selectedStateImageName;
@synthesize normalStateBgImageName;
@synthesize highlightedStateBgImageName;
@synthesize selectedStateBgImageName;

- (void)pretreat {
    self.countdownBeginNumber = 60;
    self.normalStateBgImageName = @"userinfo_relationship_button_background";
    self.highlightedStateBgImageName = @"userinfo_relationship_button_background";
    self.selectedStateBgImageName = @"userinfo_relationship_button_highlighted";
    self.normalStateImageName = @"timerBtn_imageView_normal";
    self.highlightedStateImageName = @"timerBtn_imageView_highlighted";
    self.selectedStateImageName = @"timerBtn_imageView_selected";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    [self setupBackgroundNotification];
    [self pretreat];
    return self;
}


- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (void)setupBackgroundNotification {
    //页面将要进入前台，开启定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantPastTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //页面消失，进入后台不显示该页面，关闭定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantFutureTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)drawRect:(CGRect)rect
{
    _countdown = self.countdownBeginNumber - 1;
    [self setupSendSNSCodeButton];
}

- (void)setupSendSNSCodeButton {
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.cornerRadius = 3.0;
    self.clipsToBounds = YES;
    
    [self setBackgroundImage:[UIImage resizedImage:self.normalStateBgImageName] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage resizedImage:self.highlightedStateBgImageName] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage resizedImage:self.selectedStateBgImageName] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageWithName:self.normalStateImageName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageWithName:self.highlightedStateImageName] forState:UIControlStateHighlighted];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [self setBackgroundColor:NavBarColor];
//    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"验证码边框"] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(receiveCode) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)receiveCode{
    //    [self getCode];
    if ([self.delegate respondsToSelector:@selector(countButtonClicked)]) {
        [self.delegate countButtonClicked];
    }
    if (self.tfText.length>0) {
        [self initWithCountdownBeginNumber];
        
    }else{
        [EasyShowTextView showText:@"请输入手机号"];
        
    }
}

- (void)initWithCountdownBeginNumber  {
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setBackgroundColor:WhiteColor];
    
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"还剩 %ld 秒",self.countdownBeginNumber - 1] forState:UIControlStateNormal];
    [self setImage:[UIImage imageWithName:self.selectedStateImageName] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"验证码边框"] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

-(void)closeGetVerifyButtonUser
{
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setBackgroundColor:WhiteColor];
    
    [self setImage:[UIImage imageWithName:self.selectedStateImageName] forState:UIControlStateNormal];
    _countdown = _countdown-1;
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"还剩 %zd 秒",_countdown] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"验证码边框"] forState:UIControlStateNormal];
    if(_countdown == 0){
        [self setImage:[UIImage imageWithName:self.normalStateImageName] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"验证码边框"] forState:UIControlStateNormal];
        _countdown = self.countdownBeginNumber - 1;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


//页面将要进入前台，开启定时器
-(void)distantPastTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //开启定时器
    //    [_countdownTimer setFireDate:[NSDate distantPast]];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)distantFutureTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //关闭定时器
    //    [_countdownTimer setFireDate:[NSDate distantFuture]];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:Nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:Nil];
}

@end
