//
//  YPBeiHunController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPBeiHunController.h"
#import <SDCycleScrollView.h>
#import "YPBeiHunColViewCell.h"
#import "YPBHProjectController.h"//我要出方案
#import "YPNewlywedsController.h"//新婚档案
#import "YPBHShowFangAnController.h"//方案展示
#import "YPBHInviteController.h"//邀请有礼
#import "YPBHAssureController.h"//婚礼担保
#import "YPBHWelfareController.h"//签单福利
#import "YPMarriageNoticeController.h"//婚前必知
#import "YPFreeWeddingController.h"//2-7 添加 免费办婚礼
#import "HRYQJHController.h"//邀请结婚
#import "HRFAStoreViewController.h"
@interface YPBeiHunController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *colView;

@end

@implementation YPBeiHunController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetBHImg];
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
    
    self.view.backgroundColor = bgColor;
    
    [self setupNav];
//    [self setupUI];

}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"备婚";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{

    [self.view addSubview:self.scrollView];
    
    if (!self.colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ScreenWidth-2)/3.0, 140);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        
        self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, 140*2+1) collectionViewLayout:layout];
    }
    [self.colView registerNib:[UINib nibWithNibName:@"YPBeiHunColViewCell" bundle:nil] forCellWithReuseIdentifier:@"YPBeiHunColViewCell"];
    self.colView.backgroundColor = bgColor;
    self.colView.delegate = self;
    self.colView.dataSource = self;
    [self.view addSubview:self.colView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 5;
    return 6;//2-5 修改 隐藏方案展示
//    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    YPBeiHunColViewCell *cell = [YPBeiHunColViewCell cellWithColView:collectionView AndIndexPath:indexPath];
    YPBeiHunColViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPBeiHunColViewCell" forIndexPath:indexPath];
    cell.backgroundColor = WhiteColor;
    switch (indexPath.item) {
        case 0:
            cell.iconImgV.image = [UIImage imageNamed:@"icon_01"];
            cell.titleLabel.text = @"免费出方案";
            break;
        case 1:
//            cell.iconImgV.image = [UIImage imageNamed:@"show"];
//            cell.titleLabel.text = @"方案展示";
//            break;
//        case 2:
            cell.iconImgV.image = [UIImage imageNamed:@"icon_02"];
            cell.titleLabel.text = @"免费办婚礼";
            break;
//        case 3:
            case 2:
            cell.iconImgV.image = [UIImage imageNamed:@"icon_03"];
            cell.titleLabel.text = @"邀请结婚";
            break;
//        case 4:
            case 3:
            cell.iconImgV.image = [UIImage imageNamed:@"icon_04"];
            cell.titleLabel.text = @"婚礼担保";
            break;
//        case 5:
            case 4:
            cell.iconImgV.image = [UIImage imageNamed:@"icon_05"];
            cell.titleLabel.text = @"婚前必知";
            break;
            
        case 5:
            cell.iconImgV.image = [UIImage imageNamed:@"共享方案"];
            cell.titleLabel.text = @"共享方案";
            break;
        default:
            break;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.item) {
        case 0:{
            [self IsNewPeopleAddCustom];//判断是否添加订制
            break;
        }
        case 1:{
//            //方案展示
//            YPBHShowFangAnController *show = [[YPBHShowFangAnController alloc]init];
//            [self.navigationController pushViewController:show animated:YES];
//             break;
//        }
//        case 2:{
            
//            //邀请有礼 -- 2-7 删除
//            YPBHInviteController *invite = [[YPBHInviteController alloc]init];
//            [self.navigationController pushViewController:invite animated:YES];
//            break;
            
            //2-7 免费办婚礼
            YPFreeWeddingController *freeWedding = [[YPFreeWeddingController alloc]init];
            [self.navigationController pushViewController:freeWedding animated:YES];
            break;
        }
//        case 3:{
            case 2:{

//            //婚礼担保 -- 2.7 修改 - 邀请结婚
//            YPBHAssureController *assure = [[YPBHAssureController alloc]init];
//            [self.navigationController pushViewController:assure animated:YES];

                HRYQJHController *jhVC = [HRYQJHController new];
                [self.navigationController pushViewController:jhVC animated:YES];
            break;
        }

//        case 4:{
            case 3:{

//            //签单福利
//            YPBHWelfareController *welfare = [[YPBHWelfareController alloc]init];
//            [self.navigationController pushViewController:welfare animated:YES];
//            break;
                
            //婚礼担保 -- 2.7 修改
            YPBHAssureController *assure = [[YPBHAssureController alloc]init];
            [self.navigationController pushViewController:assure animated:YES];
            
            break;
                
        }
            
//        case 5:{
            case 4:{

            //婚前必知
            YPMarriageNoticeController *notic = [[YPMarriageNoticeController alloc]init];
            [self.navigationController pushViewController:notic animated:YES];
            break;
        }
        case 5:{
            
            //方案商城
            HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
            [self.navigationController pushViewController:faanganVC animated:YES];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - SDCycleScrollViewDelegate

#pragma mark - 网络请求
#pragma mark 获取备婚图片
- (void)GetBHImg{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/GetBHImg";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *ImgUrl = [object valueForKey:@"ImgURL"];

            self.scrollView.imageURLStringsGroup = @[ImgUrl];
            
            [self setupUI];
            
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

#pragma mark 判断新人是否添加了订制
- (void)IsNewPeopleAddCustom{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/IsNewPeopleAddCustom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = myID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            NSString *customID = [object valueForKey:@"NewPeopleCustomID"];//未添加返回0
            NSString *state = [object valueForKey:@"CustomState"];
            if ([customID integerValue] == 0) {
                //未添加
                //我要出方案 添加界面
                YPBHProjectController *project = [[YPBHProjectController alloc]init];
                [self.navigationController pushViewController:project animated:YES];
            }else{
                
                //我要出方案
                YPNewlywedsController *weds = [[YPNewlywedsController alloc]init];
//                weds.typeNum = @"";
                weds.upState = [state integerValue];//提交状态
                [self.navigationController pushViewController:weds animated:YES];
            }
            
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
- (SDCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, CGRectGetMaxY(_navView.frame), ScreenWidth, ScreenWidth*0.5) delegate:self placeholderImage:[UIImage imageNamed:@"图片占位图"]];
    }
    return _scrollView;
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
