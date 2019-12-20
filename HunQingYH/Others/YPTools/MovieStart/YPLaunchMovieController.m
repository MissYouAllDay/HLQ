//
//  YPLaunchMovieController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPLaunchMovieController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface YPLaunchMovieController ()<AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayerLayer *avPlayer;

@end

@implementation YPLaunchMovieController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    
    [self setupMovieView];
}

- (void)setupMovieView{
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"launchIcon"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STATUSBAR_HEIGHT_S+20);
        make.left.mas_equalTo(18);
    }];
    
    UIButton *intoHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(36, ScreenHeight*0.5+ScreenWidth*0.5+50, ScreenWidth-72, 56)];
    [intoHomeBtn setImage:[UIImage imageNamed:@"intoHomeBtn"] forState:UIControlStateNormal];
    [intoHomeBtn setImage:[UIImage imageNamed:@"intoHomeBtn"] forState:UIControlStateHighlighted];
    [intoHomeBtn addTarget:self action:@selector(intoHomeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intoHomeBtn];
    
    //播放单位
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    //player
    self.avPlayer = [AVPlayerLayer playerLayerWithPlayer:player];
    self.avPlayer.frame = CGRectMake(0, ScreenHeight*0.5-ScreenWidth*0.5, ScreenWidth, ScreenWidth);
    //layer 填充方式
    self.avPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.avPlayer.player = player;
    [self.view.layer addSublayer:self.avPlayer];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    
    //开始播放
    [self.avPlayer.player play];
    
    //重复播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
}

#pragma mark - target
//播放完成代理
- (void)playDidEnd:(NSNotification *)notif{
    //播放完成后,设置播放进度为0 重新播放
    [self.avPlayer.player seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer.player play];
}

- (void)intoHomeBtn{
    [UIApplication sharedApplication].keyWindow.rootViewController = self.VC;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

#pragma mark - getter
//- (AVPlayerViewController *)avPlayer{
//    if (!_avPlayer) {
//        _avPlayer = [[AVPlayerViewController alloc]init];
//        _avPlayer.delegate = self;
//        //不播放组件
//        _avPlayer.showsPlaybackControls = NO;
//        //关闭画中画功能 iOS9之后有效
//        _avPlayer.allowsPictureInPicturePlayback = NO;
//    }
//    return _avPlayer;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
