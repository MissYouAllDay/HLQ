//
//  YPNewlywedsController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewlywedsController.h"
#import "YPMyNewlywedsController.h"
#import "YPOurNewlywedsController.h"
#import "YPMyNewWedsManController.h"
#import "HRBeiHunController.h"//备婚首页

@interface YPNewlywedsController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

//@property (nonatomic, strong) YPMyNewlywedsController *womanVC;//新娘新郎共用一套
@property (nonatomic, strong) YPMyNewWedsManController *manVC;
@property (nonatomic, strong) YPOurNewlywedsController *ourVC;

@end

@implementation YPNewlywedsController{
    UIView *_navView;
    UIButton *_manBtn;
    UIButton *_womanBtn;
    
    UIButton *backBtn;
    UILabel *titleLab;
    UIButton *doneBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT+50)];
    _navView.backgroundColor = NavBarColor;
    [self.view addSubview:_navView];
    
    if (!backBtn) {
        backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-60);
    }];
    
    if (!titleLab) {
        titleLab  = [[UILabel alloc]init];
    }
    titleLab.text = @"新婚档案";
    titleLab.textColor = WhiteColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏右边
    if (!doneBtn) {
        doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    if (self.upState == 1) {//已提交
        [doneBtn setTitle:@"已提交" forState:UIControlStateNormal];
        doneBtn.enabled = NO;
    }else{
        [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
        doneBtn.enabled = YES;
    }
    [doneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
    
    if (!self.segment) {
        self.segment = [[UISegmentedControl alloc]initWithItems:@[@"我的",@"我们的"]];
    }
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(handleSegmentAction:) forControlEvents:UIControlEventValueChanged];
    self.segment.width = ScreenWidth/2.0;
    self.segment.tintColor = WhiteColor;
    [_navView addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_offset(-10);
        make.width.mas_equalTo(ScreenWidth/2.0);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
//    if (self.typeNum == 2) {
//        [self addChildViewController:self.womanVC];
//
//        [self.view addSubview:self.womanVC.view];
//        [self.womanVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_navView.mas_bottom);
//            make.left.right.bottom.mas_equalTo(self.view);
//        }];
//    }else if (self.typeNum == 1) {
        [self addChildViewController:self.manVC];
        
        [self.view addSubview:self.manVC.view];
        [self.manVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navView.mas_bottom);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
//    }
}

#pragma mark - target
- (void)backVC{
//    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您确定要提交吗?" message:@"提交之后, 将无法再更改\n请确保信息无误后提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
    [alert show];
}

- (void)handleSegmentAction:(UISegmentedControl *)sender{
    NSLog(@"handleSegmentAction:");
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [self.ourVC.view removeFromSuperview];
            
//            [self.view addSubview:self.myVC.view];
//            [self.myVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(_navView.mas_bottom);
//                make.left.right.bottom.mas_equalTo(self.view);
//            }];
            
//            if (self.typeNum == 2) {
//
//                [self.view addSubview:self.womanVC.view];
//                [self.womanVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(_navView.mas_bottom);
//                    make.left.right.bottom.mas_equalTo(self.view);
//                }];
//            }else{
            
                [self.view addSubview:self.manVC.view];
                [self.manVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navView.mas_bottom);
                    make.left.right.bottom.mas_equalTo(self.view);
                }];
//            }
            break;
        }
            
        case 1:
        {
            [self.manVC.view removeFromSuperview];
//            [self.womanVC.view removeFromSuperview];

            [self.view addSubview:self.ourVC.view];
            [self.ourVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_navView.mas_bottom);
                make.left.right.bottom.mas_equalTo(self.view);
            }];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"提交");
        [self SubmitNewPeople];
    }
}

#pragma mark - 网络请求
#pragma mark 提交新人订制
- (void)SubmitNewPeople{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/SubmitNewPeople";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"提交成功!"];
            
            self.upState = 1;
            
            [self setupNav];//重置提交按钮
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                UIViewController *mineVC = nil;
//                for (UIViewController * controller in self.navigationController.viewControllers) {
//                    //遍历
//                    if([controller isKindOfClass:[HRBeiHunController class]]){
//                        //这里判断是否为你想要跳转的页面
//                        mineVC = controller;
//                        break;
//                    }
//                }
//                [self.navigationController popToViewController:mineVC  animated:YES];
//            });
            
//            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
//- (YPMyNewlywedsController *)womanVC{
//    if (!_womanVC) {
//        _womanVC = [[YPMyNewlywedsController alloc]init];
//    }
//    _womanVC.upState = self.upState;
//    return _womanVC;
//}

- (YPMyNewWedsManController *)manVC{
    if (!_manVC) {
        _manVC = [[YPMyNewWedsManController alloc]init];
    }
    _manVC.upState = self.upState;
    return _manVC;
}

- (YPOurNewlywedsController *)ourVC{
    if (!_ourVC) {
        _ourVC = [[YPOurNewlywedsController alloc]init];
    }
    _ourVC.upState = self.upState;
    return _ourVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
