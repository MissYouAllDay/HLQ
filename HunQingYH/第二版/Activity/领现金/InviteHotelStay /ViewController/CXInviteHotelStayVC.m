//
//  CXApplyPartnerVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayVC.h"
#import "CXInviteHotelStayHeaderView.h"     // banner + 活动规则
#import "CXInvitehotelStayMainView.h"      // 信息 填写

#import "CXInviteHotelStayLogVC.h" //  邀请记录
#import "CXHotelSelectList.h"       //  酒店列表

#import "CJAreaPicker.h"        //  地址选择器
#import "CXAreaData.h"          // 地址数据查询

@interface CXInviteHotelStayVC ()<UITextFieldDelegate,CJAreaPickerDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXInvitehotelStayMainView  *mainView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) NSString  *areaId;    // 区域id
@end

@implementation CXInviteHotelStayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒店入住";
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"hotelStay" highImageName:@"hotelStay" target:self action:@selector(pushCXInviteHotelStayLogVC)];
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"kefu" highImageName:@"kefu" target:self action:@selector(shareAction)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item];
    [self loadSubViews];
}

- (void)loadSubViews {
    
    CXInviteHotelStayHeaderView *cell = [[[NSBundle mainBundle] loadNibNamed:@"CXInviteHotelStayHeaderView" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0, 0, ScreenWidth, 380);
    
    self.mainView.frame = CGRectMake(0, cell.bottom, ScreenWidth, 500);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:cell];
    [self.scrollView addSubview:self.mainView];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, cell.height + self.mainView.height + HOME_INDICATOR_HEIGHT);
    self.scrollView.height = self.view.height - NAVIGATION_BAR_HEIGHT;
}

// MARK: - 请求数据
- (void)postInviteHotelData {
    
    if (![self.mainView checkData]) {
        return;
    }
    
    [EasyShowLodingView showLoding];
    
    NSString *url = URL_ACTIVITY_InvitehotelStay;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.mainView.shopNameTF.text  forKey:@"FacilitatorName"];
    [params setValue:self.areaId                    forKey:@"AreaId"];
    [params setValue:self.mainView.addressTF.text   forKey:@"Address"];
    [params setValue:self.mainView.canbiaoTF.text   forKey:@"MealMark"];
    [params setValue:self.mainView.tingNumTF.text   forKey:@"BanquetHall"];
    [params setValue:self.mainView.nameTF.text      forKey:@"InviterName"];
    [params setValue:self.mainView.telTF.text       forKey:@"InviterPhone"];
    [params setValue:UserId_New                     forKey:@"SubmittingID"];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"信息提交成功"] ;

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

// MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    switch (textField.tag - 1000) {
        case 1: [self selectAreaInfo]; return NO;
        default: break;
    }
    return YES;
}

// MARK: - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address withFullAddress:(NSString *)fullAddress parentID:(NSInteger)parentID {
    
    self.mainView.areaTF.text = fullAddress;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.areaId = [CXAreaData selectDataBaseWithCityInfo:address withParentId:parentID];
}

// MARK: - Unitl
- (void)shareAction {
    
    [CXUtils phoneAction:self withTel:kefuTel];
}

-(void)selectAreaInfo {
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    picker.endType = CJPlaceEndArea;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

// MARK: - 懒加载
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"#FD8071"];
    }
    
    return _scrollView;
}

- (CXInvitehotelStayMainView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXInvitehotelStayMainView" owner:nil options:nil] lastObject];
        _mainView.areaTF.delegate = self;
        _mainView.shopNameTF.delegate = self;
        
        _mainView.areaTF.tag = 1001;
        _mainView.shopNameTF.tag = 1000;
        [_mainView.subBtn addTarget:self action:@selector(postInviteHotelData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainView;
}

// MARK: - push
- (void)pushCXInviteHotelStayLogVC {
    
    CXInviteHotelStayLogVC *vc = [[CXInviteHotelStayLogVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
