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
#import "CJAreaPicker.h"
@interface CXApplyPartnerVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CJAreaPickerDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXApplyPartnerMainView  *mainView;    // <#这里是个注释哦～#>
@property (nonatomic, copy) NSString *areaId;    // 地址id

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
    
    self.mainView.frame = CGRectMake(0, cell.bottom, ScreenWidth, Line375(390));
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:cell];
    [self.scrollView addSubview:self.mainView];

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, cell.height + self.mainView.height + HOME_INDICATOR_HEIGHT);
    self.scrollView.height = self.view.height - NAVIGATION_BAR_HEIGHT;
}


// MARK: - LoadData
// 上传申请数据
- (void)postApplyPartnerData{
    
    NSDictionary *param = @{@"UserId":UserId_New,@"Name":self.mainView.nameTF.text,@"AreaId":self.areaId,@"SelfRecommendation":[NSString stringFormatWithNull:self.mainView.detailTF.text],@"Type":@"1"};
    
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_APPLYPARTNER withParams:param Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
          [EasyShowTextView showText:@"信息提交成功"];
            
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
   
    NSDictionary *param = @{@"NamePhone":UserPhone_New,@"PageIndex":@"1",@"PageCount":@"1"};
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_APPLYPARTNER_RESULT withParams:param Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            NSArray *arr = object[@"Data"];
            if (arr.count == 0) {
                return ;
            }else {
                // 0未审核，1已审核，2驳回
                int type = [arr[0][@"Type"] intValue];
                
                if (type == 0) {
                    [self showAlert:@"尚未审核！请耐心等待..." withIsFail:NO];
                }
                if (type == 1) {
// 成功
                    
                }
                if (type == 2) {
                                   [self showAlert:@"信息审核失败" withIsFail:YES];
                               }
            }
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
    
    if (ISEMPTY(self.mainView.nameTF.text)) {
        
        [EasyShowTextView showText:@"请输入姓名"];
        return NO;
    }
    if (ISEMPTY(self.mainView.telTF.text)) {
           
       [EasyShowTextView showText:@"请输入手机号"];
       return NO;
    }
    if (ISEMPTY(self.mainView.addressTF.text)) {
           
       [EasyShowTextView showText:@"请选择地址"];
       return NO;
    }
    
    return YES;
}


// MARK: - UITextFileDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1002) {
        [self showAreaPickerView];
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

- (void)showAreaPickerView {
    //地区
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

// MARK: - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address withFullAddress:(NSString *)fullAddress parentID:(NSInteger)parentID {
    
    self.mainView.addressTF.text = fullAddress;
    self.areaId = [NSString stringWithFormat:@"%ld",(long)parentID];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// MARK: - 弹窗
- (void)showAlert:(NSString *)message withIsFail:(BOOL)isFail  {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (isFail) {
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再次提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    }else {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
