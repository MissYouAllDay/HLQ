//
//  YPReLoginRegistSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/6.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReLoginRegistSucController.h"
#import "YPReLoginRegistSucView.h"
#import "YPPersonInfoController.h"//个人资料
#import "YPSupplierPersonInfoController.h"//供应商个人资料

@interface YPReLoginRegistSucController ()

@end

@implementation YPReLoginRegistSucController{
    YPReLoginRegistSucView *_sucView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WhiteColor;
    
    if (!_sucView) {
        _sucView = [YPReLoginRegistSucView yp_ReLoginRegistSucView];
    }
    if (self.professionType == 1) {//新人
        [_sucView.iconImgV sd_setImageWithURL:[NSURL URLWithString:@"http://www.chenghunji.com/Download/User/wanshan.png"] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    }else{//供应商
        [_sucView.iconImgV sd_setImageWithURL:[NSURL URLWithString:@"http://www.chenghunji.com/Download/User/newwanshan.png"] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    }
    [_sucView.passBtn addTarget:self action:@selector(passBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sucView.personInfoBtn addTarget:self action:@selector(personInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sucView];
    [_sucView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_greaterThanOrEqualTo(-40);
    }];
}

#pragma mark - target
- (void)passBtnClick{
    NSLog(@"passBtnClick");
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)personInfoBtnClick{
    NSLog(@"personInfoBtnClick");
    
    if (self.professionType == 1) {//新人-个人资料
        //个人资料
        YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
        person.backType = 1;
        [self.navigationController pushViewController:person animated:YES];
    }else{
        //供应商个人资料
        YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
        person.backType = 1;
        [self.navigationController pushViewController:person animated:YES];
    }
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
