//
//  CXApplyPartnerVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXApplyPartnerVC.h"
#import "CXActivityRuleCell.h"
#import "CXApplyPartnerMainView.h"
@interface CXApplyPartnerVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXApplyPartnerMainView  *mainView;    // <#这里是个注释哦～#>
@end

@implementation CXApplyPartnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请合伙人";
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"fenxiang" highImageName:@"fenxiang" target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self loadSubViews];
    [self loadApplyPartnerResult];
}

- (void)loadSubViews {
    
    CXActivityRuleCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CXActivityRuleCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0, 0, ScreenWidth, Line375(390));
    
    self.mainView.frame = CGRectMake(0, cell.bottom, ScreenWidth, 390);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:cell];
    [self.scrollView addSubview:self.mainView];

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, cell.height + self.mainView.height + HOME_INDICATOR_HEIGHT);
    self.scrollView.height = self.view.height - NAVIGATION_BAR_HEIGHT;
}


// MARK: - LoadData
// 上传申请数据
- (void)postApplyPartnerData{
   
    NSDictionary *param = @{@"UserId":UserId_New,@"Name":self.mainView.nameTF.text,@"AreaId":@"0",@"SelfRecommendation":[NSString stringFormatWithNull:self.mainView.detailTF.text],@"Type":@"1"};
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_APPLYPARTNER withParams:param Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
          [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

// 请求申请结果
- (void)loadApplyPartnerResult {
   
    NSDictionary *param = @{@"NamePhone":UserPhone_New,@"AreaID":@"0",@"PageIndex":@"1",@"PageCount":@"1"};
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_APPLYPARTNER_RESULT withParams:param Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            NSLog(@"%@----%@",URL_ACTIVITY_APPLYPARTNER_RESULT,object);
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

// MARK: - CheckData
// 检查数据是否正确
- (BOOL)checkApplyPartnerData {
     
    self.mainView.nameTF.text = [self.mainView.nameTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.mainView.telTF.text = [self.mainView.telTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (!ISEMPTY(self.mainView.nameTF.text)) {
        
        [EasyShowTextView showText:@"请输入姓名"];
        return NO;
    }
    if (!ISEMPTY(self.mainView.telTF.text)) {
           
       [EasyShowTextView showText:@"请输入手机号"];
       return NO;
    }
    
    return YES;
}


// MARK: - UITextFileDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1002) {
        
        return NO;
    }
    return YES;
}

// MARK: - Unitl
- (void)shareAction {
    
    NSLog(@"你点击了分享");
}

//  提交按钮点击事件
- (void)subBtnAction:(UIButton *)sender {
    
    if (![self checkApplyPartnerData]) {
        
        return;
    }
    [self postApplyPartnerData];
}

// MARK: - 懒加载
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#FFF000"];
    }
    
    return _scrollView;
}

- (CXApplyPartnerMainView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXApplyPartnerMainView" owner:nil options:nil] lastObject];
        _mainView.addressTF.delegate = self;
        [_mainView.subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainView;
}


@end
