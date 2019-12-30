//
//  CXApplyReceiveMoneyView.m
//  HunQingYH
//
//  Created by canxue on 2019/12/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXApplyReceiveMoneyView.h"
#import "CJAreaPicker.h"

@interface CXApplyReceiveMoneyView ()<UITextFieldDelegate,CJAreaPickerDelegate>

@end
@implementation CXApplyReceiveMoneyView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    //    self.hidden = YES;
    
    self.nameBgView.layer.cornerRadius  =
    self.telBgView.layer.cornerRadius   =
    self.hunQiBgView.layer.cornerRadius =
    self.addressBgView.layer.cornerRadius =
    self.tabNumBgView.layer.cornerRadius  =
    self.canbiaoBgView.layer.cornerRadius =
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    
    self.nameBgView.layer.borderColor  =
    self.telBgView.layer.borderColor   =
    self.hunQiBgView.layer.borderColor =
    self.addressBgView.layer.borderColor =
    self.tabNumBgView.layer.borderColor  =
    self.canbiaoBgView.layer.borderColor = [CXUtils colorWithHexString:@"#F8616E"].CGColor;
    
    self.nameBgView.layer.borderWidth  =
    self.telBgView.layer.borderWidth   =
    self.hunQiBgView.layer.borderWidth =
    self.addressBgView.layer.borderWidth =
    self.tabNumBgView.layer.borderWidth  =
    self.canbiaoBgView.layer.borderWidth = 1;
    
    self.bgView.layer.cornerRadius = 10;
    
    self.hunqiTF.delegate = self;
    self.addressTF.delegate = self;
    
    self.hunqiTF.tag = 1000;
    self.addressTF.tag = 1001;
    
    [self.subBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)closeBtn:(UIButton *)sender {
    
    //TODO:写个动画
    [self removeFromSuperview];
}

- (void)showView {
    //TODO:写个动画
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
}

// MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1000) {
        [self showDatePickerView];
        return NO;
    }else if (textField.tag == 1001){
        [self showAreaPickerView];
        return NO;
    }
    return YES;
}

- (void)showDatePickerView {
    
    [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        self.hunqiTF.text = selectValue;
    }];
}

- (void)showAreaPickerView {
    //地区
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self.viewController presentViewController:navc animated:YES completion:nil];
}

// MARK: - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address withFullAddress:(NSString *)fullAddress parentID:(NSInteger)parentID {
    
    self.addressTF.text = fullAddress;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)checkDataToPost {
    
    if (ISEMPTY(self.nameTF.text)) {
        [EasyShowTextView showText:@"请填写姓名"];
        return NO;
    }
    if (ISEMPTY(self.telTF.text)) {
        [EasyShowTextView showText:@"请填写手机号"];
        return NO;
    }
    if (ISEMPTY(self.hunqiTF.text)) {
        [EasyShowTextView showText:@"请选择婚期"];
        return NO;
    }
    if (ISEMPTY(self.addressTF.text)) {
        [EasyShowTextView showText:@"请选择地址"];
        return NO;
    }
    if (ISEMPTY(self.tabNumTF.text)) {
        [EasyShowTextView showText:@"请填写桌数"];
        return NO;
    }
    if (ISEMPTY(self.canbiaoTF.text)) {
        [EasyShowTextView showText:@"请填写餐标"];
        return NO;
    }
    
    return YES;
}

- (void)postData {
    
    if (![self checkDataToPost]) {
        return ;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_CategoryList withParams:nil Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"提交成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self closeBtn];
            });
        }
        
        [EasyShowTextView showText:@"提交失败"];
    } Failure:^(NSError *error) {
        [EasyShowTextView showText:@"提交失败"];
    }];
    
}

@end
