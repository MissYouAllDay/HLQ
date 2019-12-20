//
//  LuckView.m
//  QSyihz
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 yihuazhuan. All rights reserved.
//

#import "LuckView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "YPLotteryPrizeView.h"

@interface LuckView ()<UIAlertViewDelegate> {
    NSTimer *imageTimer;
    NSTimer *startTimer;
    
    int currentTime;
    int stopTime;
    int result;
}

@property (strong , nonatomic) UIImageView *iv;
@property (assign, nonatomic) BOOL isImage;
@property (strong, nonatomic) NSMutableArray * btnArray;
@property (strong, nonatomic) UIButton * startBtn;
@property (assign, nonatomic) CGFloat time;


@end

@implementation LuckView{
    YPLotteryPrizeView *_view0;
    YPLotteryPrizeView *_view1;
    YPLotteryPrizeView *_view2;
    YPLotteryPrizeView *_view3;
    YPLotteryPrizeView *_view4;
    YPLotteryPrizeView *_view5;
    YPLotteryPrizeView *_view6;
    YPLotteryPrizeView *_view7;
    YPLotteryPrizeView *_view8;
    YPLotteryPrizeView *_view9;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentTime = 0;
        self.isImage = YES;
        self.time = 0.1;
        stopTime = 63 + self.stopCount;
        self.iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.iv.image = [UIImage imageNamed:@"cjbj01"];
        [self addSubview:self.iv];
        
       imageTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(updataImage:) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)updataImage:(NSTimer *)timer {
    self.isImage = !self.isImage;
    if (self.isImage == YES) {
        self.iv.image = [UIImage imageNamed:@"cjbj02"];
    } else {
        self.iv.image = [UIImage imageNamed:@"cjbj01"];
    }
}

- (void)setStopCount:(int)stopCount {
    _stopCount = stopCount;
    NSLog(@"LuckView -- %d",_stopCount);
    stopTime = 63 + _stopCount;
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
//    CGFloat yj = 15;
//    CGFloat j = 20;
//    CGFloat upj = 5;
//    CGFloat imageW = 10;
//    CGFloat btnw = (self.width - imageW * 2 - j * 2 - upj * 2)/3;
//
//    for (int i = 0; i < imageArray.count + 1; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.x = j + upj * (i % 3) + (i % 3) * btnw + imageW;
//        btn.y = yj + upj * (i / 3) + (i / 3) * btnw + imageW;
//        btn.width = btnw;
//        btn.height = btnw;
//        btn.backgroundColor = [UIColor clearColor];
//        btn.layer.cornerRadius = 5;
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.iv.userInteractionEnabled = YES;
//        [self.iv addSubview:btn];
//
//        if (i == 4) {
//            btn.layer.cornerRadius = 10;
//            [btn setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
//            btn.tag = 10;
//            self.startBtn = btn;
//            continue;
//        }
//
//        btn.tag = i > 4? i -1: i;
//        btn.layer.borderWidth = 5;
//        btn.layer.borderColor = [UIColor clearColor].CGColor;
//        [btn sd_setImageWithURL:[_imageArray objectAtIndex:i > 4? i -1: i] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cjbj02"]];
//        btn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//        [self.btnArray addObject:btn];
//    }
//    [self tradePlacesWithBtn1:self.btnArray[3] btn2:self.btnArray[4]];
//    [self tradePlacesWithBtn1:self.btnArray[5] btn2:self.btnArray[6]];
//    [self tradePlacesWithBtn1:self.btnArray[8] btn2:self.btnArray[9]];
    
    [self setupUI];
}

- (void)setupUI{
    
    CGFloat margin = 3;
    CGFloat btnW = (ScreenWidth-40-margin*5)/4.0;
    
    [self.btnArray removeAllObjects];
    
    if (!_view0) {
        _view0 = [[YPLotteryPrizeView alloc] init];
    }
    _view0.tag = 1000;
    _view0.titleLabel.text = _titleArray[0];
    [_view0.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view0];
    [self.btnArray addObject:_view0];
    
    if (!_view1) {
        _view1 = [[YPLotteryPrizeView alloc] init];
    }
    _view1.tag = 1001;
    _view1.titleLabel.text = _titleArray[1];
    [_view1.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view1];
    [self.btnArray addObject:_view1];
    
    if (!_view2) {
        _view2 = [[YPLotteryPrizeView alloc] init];
    }
    _view2.tag = 1002;
    _view2.titleLabel.text = _titleArray[2];
    [_view2.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view2];
    [self.btnArray addObject:_view2];
    
    if (!_view3) {
        _view3 = [[YPLotteryPrizeView alloc] init];
    }
    _view3.tag = 1003;
    _view3.titleLabel.text = _titleArray[3];
    [_view3.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view3];
    [self.btnArray addObject:_view3];
    
    if (!_view4) {
        _view4 = [[YPLotteryPrizeView alloc] init];
    }
    _view4.tag = 1004;
    _view4.titleLabel.text = _titleArray[4];
    [_view4.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[4]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view4];
    [self.btnArray addObject:_view4];
    
    if (!_view5) {
        _view5 = [[YPLotteryPrizeView alloc] init];
    }
    _view5.tag = 1005;
    _view5.titleLabel.text = _titleArray[5];
    [_view5.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[5]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view5];
    [self.btnArray addObject:_view5];
    
    if (!_view6) {
        _view6 = [[YPLotteryPrizeView alloc] init];
    }
    _view6.tag = 1006;
    _view6.titleLabel.text = _titleArray[6];
    [_view6.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[6]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view6];
    [self.btnArray addObject:_view6];
    
    if (!_view7) {
        _view7 = [[YPLotteryPrizeView alloc] init];
    }
    _view7.tag = 1007;
    _view7.titleLabel.text = _titleArray[7];
    [_view7.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[7]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view7];
    [self.btnArray addObject:_view7];
    
    if (!_view8) {
        _view8 = [[YPLotteryPrizeView alloc] init];
    }
    _view8.tag = 1008;
    _view8.titleLabel.text = _titleArray[8];
    [_view8.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[8]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view8];
    [self.btnArray addObject:_view8];
    
    if (!_view9) {
        _view9 = [[YPLotteryPrizeView alloc] init];
    }
    _view9.tag = 1009;
    _view9.titleLabel.text = _titleArray[9];
    [_view9.iconImgV sd_setImageWithURL:[NSURL URLWithString:_imageArray[9]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [self.iv addSubview:_view9];
    [self.btnArray addObject:_view9];
    
    /*
     0 1 2 3
     9     4
     9     4
     8 7 6 5
     */
    
    _view0.frame = CGRectMake(margin, margin, btnW, btnW);
    _view1.frame = CGRectMake(margin*2+btnW, margin, btnW, btnW);
    _view2.frame = CGRectMake(margin*3+btnW*2, margin, btnW, btnW);
    _view3.frame = CGRectMake(margin*4+btnW*3, margin, btnW, btnW);
    _view4.frame = CGRectMake(margin*4+btnW*3, margin*2+btnW, btnW, btnW*2+margin);//右大
    _view5.frame = CGRectMake(margin*4+btnW*3, margin*4+btnW*3, btnW, btnW);
    _view6.frame = CGRectMake(margin*3+btnW*2, margin*4+btnW*3, btnW, btnW);
    _view7.frame = CGRectMake(margin*2+btnW, margin*4+btnW*3, btnW, btnW);
    _view8.frame = CGRectMake(margin, margin*4+btnW*3, btnW, btnW);
    _view9.frame = CGRectMake(margin, margin*2+btnW, btnW, btnW*2+margin);//左大
    
    if (!self.lotteryBtn) {
        self.lotteryBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin*2+btnW, margin*2+btnW, btnW*2+margin, btnW*2+margin)];
    }
    [self.lotteryBtn setImage:[UIImage imageNamed:@"lotteryBtn"] forState:UIControlStateNormal];
    [self.lotteryBtn setBackgroundColor:RGB(252, 212, 54)];
    self.lotteryBtn.layer.cornerRadius = 10;
    self.lotteryBtn.clipsToBounds = YES;
    if ([self.LotteryQualification integerValue] == 0) {
        self.lotteryBtn.selected = YES;
    }else{
        self.lotteryBtn.selected = NO;
    }
    [self.lotteryBtn addTarget:self action:@selector(lotteryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.iv.userInteractionEnabled = YES;
    [self.iv addSubview:self.lotteryBtn];
    
}

- (void)lotteryBtnClick:(UIButton *)sender{
    
    if (sender.isSelected) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用光了╥﹏╥...您未达到抽奖资格，领四次爆米花可获得一次抽奖机会哦~" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{

        [self UserGetPrizes];

    }
}

- (void)yp_lotteryBtnClick{
    
    currentTime = result;
    self.time = 0.1;
    stopTime = 63 + self.stopCount % 10;
    [self.startBtn setEnabled:NO];
    [self.startBtn setImage:[UIImage imageNamed:@"subo"] forState:UIControlStateNormal];
    
    startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    
}

- (void)btnClick:(UIButton *)btn {
//    if (btn.tag == 10) {
//        currentTime = result;
//        self.time = 0.1;
//        stopTime = 63 + self.stopCount % 8;
//        [self.startBtn setEnabled:NO];
//        [self.startBtn setImage:[UIImage imageNamed:@"subo"] forState:UIControlStateNormal];
//
//        startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
//
//    } else {
        self.luckBtn(btn);
        if ([self.delegate respondsToSelector:@selector(luckSelectBtn:)]) {
            [self.delegate luckSelectBtn:btn];
        }
//    }
}

- (void)start:(NSTimer *)timer {
//    UIButton *oldBtn = [self.btnArray objectAtIndex:currentTime % self.btnArray.count];
//    oldBtn.layer.borderColor = [UIColor clearColor].CGColor;
//    currentTime++;
//    UIButton *btn = [self.btnArray objectAtIndex:currentTime % self.btnArray.count];
//    btn.layer.borderColor = [UIColor orangeColor].CGColor;

    YPLotteryPrizeView *oldBtn = [self.btnArray objectAtIndex:currentTime % (self.btnArray.count)];
    oldBtn.layer.borderColor = [UIColor clearColor].CGColor;
    currentTime++;
    YPLotteryPrizeView *btn = [self.btnArray objectAtIndex:currentTime % (self.btnArray.count)];
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    btn.layer.borderWidth = 3;
    
    if (currentTime > stopTime) {
        [timer invalidate];
        [self.startBtn setEnabled:YES];
        [self.startBtn setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
//        result = currentTime % (self.btnArray.count);
        
        //--------------------------
        result = self.stopCount;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        
        YPLotteryPrizeView *endView = [self.btnArray objectAtIndex:result];
        endView.layer.borderColor = [UIColor redColor].CGColor;
        endView.layer.borderWidth = 3;
        //--------------------------
        
        [self stopWithCount:result];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜您!" message:[NSString stringWithFormat:@"您抽中%@一件",self.PrizeName] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
//        if (self.luckResultBlock != nil) {
//            self.luckResultBlock(result);
//        }
        return;
    }
   
    if (currentTime > stopTime - 10) {
        self.time += 0.1;
        [timer invalidate];
        startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }
}


- (void)stopWithCount:(NSInteger)count {
    if ([self.delegate respondsToSelector:@selector(luckViewDidStopWithArrayCount:)]) {
        [self.delegate luckViewDidStopWithArrayCount:count];
    }
}


- (void)tradePlacesWithBtn1:(UIButton *)firstBtn btn2:(UIButton *)secondBtn {
    CGRect frame = firstBtn.frame;
    firstBtn.frame = secondBtn.frame;
    secondBtn.frame = frame;
}

- (void)dealloc {
    [imageTimer invalidate];
    [startTimer invalidate];
}


- (void)getLuckResult:(luckBlock)luckResult {
    self.luckResultBlock = luckResult;
}

- (void)getLuckBtnSelect:(luckBtnBlock)btnBlock {
    self.luckBtn = btnBlock;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        
        if (self.luckResultBlock != nil) {
            self.luckResultBlock(result);
        }
        
    }
}

#pragma mark 用户抽奖
- (void)UserGetPrizes{
    
    NSString *url = @"/api/HQOAApi/UserGetPrizes";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //            timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLotterry:) userInfo:currentView repeats:NO];
            
            self.PrizeId    = [object valueForKey:@"PrizeId"];
            self.PrizeName  = [object valueForKey:@"PrizeName"];
            self.Imgurl     = [object valueForKey:@"Imgurl"];
            self.PrizeSubscript = [object valueForKey:@"PrizeSubscript"];
            
            //指定抽奖结果,对应数组中的元素
            self.stopCount = [self.PrizeSubscript intValue];
//            result = [self.PrizeSubscript intValue];
            NSLog(@"[self.PrizeSubscript intValue] -- %d",[self.PrizeSubscript intValue]);
            
            [self yp_lotteryBtnClick];//开启抽奖
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

@end
