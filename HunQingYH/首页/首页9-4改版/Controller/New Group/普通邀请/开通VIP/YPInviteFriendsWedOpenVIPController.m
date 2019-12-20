//
//  YPInviteFriendsWedOpenVIPController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/16.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedOpenVIPController.h"
#import "YPInviteFriendsWedOpenVIPSucController.h"

@interface YPInviteFriendsWedOpenVIPController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//记录点击的是哪个按钮
@property (nonatomic, assign) NSInteger currentTag;

@property (nonatomic, strong) NSMutableArray *imgs1Marr;
@property (nonatomic, strong) NSMutableArray *imgs2Marr;
@property (nonatomic, strong) NSMutableArray *imgs3Marr;

@end

@implementation YPInviteFriendsWedOpenVIPController{
    UIView *_navView;
    NSString *_uploadIMGStr;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //    [self GetWeChatActivityList];
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
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"开通VIP邀请权限";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIButton *imgBtn = [[UIButton alloc]init];
    imgBtn.tag = indexPath.row + 1000;
    [imgBtn setImage:[UIImage imageNamed:@"IFW_addImg"] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:imgBtn];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70);
        make.right.mas_equalTo(-70);
        make.centerY.mas_equalTo(cell.contentView);
        make.top.mas_equalTo(9);
        make.bottom.mas_equalTo(-9);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-140, 140));
    }];
    if (indexPath.row == 0) {
        if (self.imgs1Marr.count > 0) {
            [imgBtn setImage:self.imgs1Marr[0] forState:UIControlStateNormal];
            imgBtn.selected = YES;
        }else{
            [imgBtn setImage:[UIImage imageNamed:@"IFW_addImg"] forState:UIControlStateNormal];
            imgBtn.selected = NO;
        }
    }else if (indexPath.row == 1){
        if (self.imgs2Marr.count > 0) {
            [imgBtn setImage:self.imgs2Marr[0] forState:UIControlStateNormal];
            imgBtn.selected = YES;
        }else{
            [imgBtn setImage:[UIImage imageNamed:@"IFW_addImg"] forState:UIControlStateNormal];
            imgBtn.selected = NO;
        }
    }else if (indexPath.row == 2){
        if (self.imgs3Marr.count > 0) {
            [imgBtn setImage:self.imgs3Marr[0] forState:UIControlStateNormal];
            imgBtn.selected = YES;
        }else{
            [imgBtn setImage:[UIImage imageNamed:@"IFW_addImg"] forState:UIControlStateNormal];
            imgBtn.selected = NO;
        }
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self getHeighWithTitle:@"新人资源多？立即开通vip邀请，月入万元可提现！" font:[UIFont fontWithName:@"PingFangSC-Regular" size:16] width:ScreenWidth-36]+18+[self getHeighWithTitle:@"上传申请照片（至少上传一张）：" font:[UIFont fontWithName:@"PingFangSC-Regular" size:16] width:ScreenWidth-36]+18+[self getHeighWithTitle:@"照片可证明您长期拥有新人资源，如：工作现场、名片、营业执照等" font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] width:ScreenWidth-36]+18;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"新人资源多？立即开通vip邀请，月入万元可提现！";
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label2.numberOfLines = 0;
    label2.textColor = RGB(250, 80, 120);
    [view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo([self getHeighWithTitle:@"新人资源多？立即开通vip邀请，月入万元可提现！" font:[UIFont fontWithName:@"PingFangSC-Regular" size:16] width:ScreenWidth-36]);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"上传申请照片（至少上传一张）：";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).mas_offset(18);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo([self getHeighWithTitle:@"上传申请照片（至少上传一张）：" font:[UIFont fontWithName:@"PingFangSC-Regular" size:16] width:ScreenWidth-36]);
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"照片可证明您长期拥有新人资源，如：工作现场、名片、营业执照等";
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    label1.numberOfLines = 0;
    label1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo([self getHeighWithTitle:@"照片可证明您长期拥有新人资源，如：工作现场、名片、营业执照等" font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] width:ScreenWidth-36]);
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 90;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIButton *submitBtn = [[UIButton alloc]init];
    
    if (self.imgs1Marr.count > 0 || self.imgs2Marr.count > 0 || self.imgs3Marr.count > 0) {
        submitBtn.enabled = YES;
        [submitBtn setImage:[UIImage imageNamed:@"Btn Copy 3"] forState:UIControlStateNormal];
    }else{
        submitBtn.enabled = NO;
        [submitBtn setImage:[UIImage imageNamed:@"Btn"] forState:UIControlStateNormal];
    }
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

#pragma mark - TakePhoto
- (void)takePhoto:(UIButton *)sender {
    
    NSLog(@"takephoto");
    UIActionSheet *actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionsheet.tag = sender.tag;
    [actionsheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
        [self LocalPhotoWithTag:actionSheet.tag];
    }
    
}

- (void)openCameraWithTag:(NSInteger)tag{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    
    if (tag == 1000) {//
        // 拍照最多个数
        cameraVc.maxCount = 1-self.imgs1Marr.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.imgs1Marr.count > 0) {
                [self.imgs1Marr removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.imgs1Marr addObject:image];
                if (self.imgs1Marr.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }else if (tag == 1001) {
        // 拍照最多个数
        cameraVc.maxCount = 1-self.imgs2Marr.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.imgs2Marr.count > 0) {
                [self.imgs2Marr removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.imgs2Marr addObject:image];
                if (self.imgs2Marr.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }else if (tag == 1002) {
        // 拍照最多个数
        cameraVc.maxCount = 1-self.imgs3Marr.count;
        
        cameraVc.callback = ^(NSArray *cameras){
            
            //如果之前存有照片 清空
            if (self.imgs3Marr.count > 0) {
                [self.imgs3Marr removeAllObjects];
            }
            
            for (int i=0; i<cameras.count; i++) {
                ZLCamera *camera  =[cameras objectAtIndex:i];
                UIImage *image = camera.thumbImage;
                [self.imgs3Marr addObject:image];
                if (self.imgs3Marr.count > 1) {
                    Alertmsg(@"不能超过1张", nil);
                    break;
                }
                [self.tableView reloadData];
            }
        };
    }
    
    [cameraVc showPickerVc:self];
}

- (void)LocalPhotoWithTag:(NSInteger)tag{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    if (tag == 1000) {
        pickerVc.maxCount = 1 - self.imgs1Marr.count;
    }else if (tag == 1001) {
        pickerVc.maxCount = 1 - self.imgs2Marr.count;
    }else if (tag == 1002) {
        pickerVc.maxCount = 1 - self.imgs3Marr.count;
    }
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}

// 代理回调方法
#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //    _lastSelectedAssets=assets;
    for (int i=0; i<assets.count; i++) {
        ZLPhotoAssets *camera  =[assets objectAtIndex:i];
        UIImage *image = camera.originImage;
        
        if (self.currentTag == 1000) {
            [self.imgs1Marr addObject:image];
            
            //获取图片的ID
            //            self.idZhengImgID = [Upload getUUID];
            
            if (self.imgs1Marr.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }else if (self.currentTag == 1001) {
            [self.imgs2Marr addObject:image];
            
            //获取图片的ID
            //            self.idFanImgID = [Upload getUUID];
            
            if (self.imgs2Marr.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }else if (self.currentTag == 1002) {
            [self.imgs3Marr addObject:image];
            
            //获取图片的ID
            //            self.handImgID = [Upload getUUID];
            
            if (self.imgs3Marr.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
        }
    }
    [self.tableView reloadData];
}

//图片浏览器
-(void)showPhotoBrowser:(NSMutableArray *)imgsMarr{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 图片游览器
    
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    NSMutableArray *photos = [[NSMutableArray alloc]initWithCapacity:imgsMarr.count];
    for (int i = 0; i < imgsMarr.count; i ++) {
        ZLPhotoPickerBrowserPhoto *photo=[ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:[imgsMarr objectAtIndex:i]];
        [photos addObject:photo];
        
    }
    pickerBrowser.photos = photos;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndexPath = indexPath;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"走方法");
    
    if (self.currentTag == 1000) {
        if (self.imgs1Marr.count >indexPath.row) {
            [self.imgs1Marr removeObjectAtIndex:indexPath.row];
        }
    }else if (self.currentTag == 1001) {
        if (self.imgs2Marr.count >indexPath.row) {
            [self.imgs2Marr removeObjectAtIndex:indexPath.row];
        }
    }else if (self.currentTag == 1002) {
        if (self.imgs3Marr.count >indexPath.row) {
            [self.imgs3Marr removeObjectAtIndex:indexPath.row];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    
    if (self.imgs1Marr.count > 0 || self.imgs2Marr.count > 0 || self.imgs3Marr.count > 0) {
        [self uploadImageRequest];
    }else{
        [EasyShowTextView showText:@"请至少上传一张图片" inView:self.tableView];
    }

}

- (void)imgBtnClick:(UIButton *)sender{
    self.currentTag = sender.tag;
    
    if (sender.tag == 1000) {
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.imgs1Marr];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }else if (sender.tag == 1001) {
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.imgs2Marr];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }else if (sender.tag == 1002) {
        if (sender.selected) {
            //展示图片
            [self showPhotoBrowser:self.imgs3Marr];
        }else{
            //添加图片
            [self takePhoto:sender];
        }
    }
}

#pragma mark - 网络请求
#pragma mark 上传图片
- (void)uploadImageRequest{
    
    [EasyShowLodingView showLoding];
    
    NSMutableArray *marr = [NSMutableArray array];
    marr = [marr arrayByAddingObjectsFromArray:self.imgs1Marr.copy].mutableCopy;
    marr = [marr arrayByAddingObjectsFromArray:self.imgs2Marr.copy].mutableCopy;
    marr = [marr arrayByAddingObjectsFromArray:self.imgs3Marr.copy].mutableCopy;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:@"0" forKey:@"ot"];
    [dict setValue:UserId_New forKey:@"oi"];
    [dict setValue:@"2" forKey:@"t"];
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = dict;
    imageEntity.imageArray = marr;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"相册返回：====%@",response);
        _uploadIMGStr = [response objectForKey:@"Inform"];
        
        [self ApplyInvitationVIP];
        
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
  
}

#pragma mark 邀请VIP申请
- (void)ApplyInvitationVIP{
    
    NSString *url = @"/api/HQOAApi/ApplyInvitationVIP";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"Imgs"] = _uploadIMGStr;
    params[@"Type"] = @"1";//1用户端申请,2后台添加
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPInviteFriendsWedOpenVIPSucController *suc = [[YPInviteFriendsWedOpenVIPSucController alloc]init];
            [self.navigationController pushViewController:suc animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (NSMutableArray *)imgs1Marr{
    if (!_imgs1Marr) {
        _imgs1Marr = [NSMutableArray array];
    }
    return _imgs1Marr;
}

- (NSMutableArray *)imgs2Marr{
    if (!_imgs2Marr) {
        _imgs2Marr = [NSMutableArray array];
    }
    return _imgs2Marr;
}

- (NSMutableArray *)imgs3Marr{
    if (!_imgs3Marr) {
        _imgs3Marr = [NSMutableArray array];
    }
    return _imgs3Marr;
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
