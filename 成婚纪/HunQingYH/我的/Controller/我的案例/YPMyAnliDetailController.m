//
//  YPMyAnliDetailController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyAnliDetailController.h"
#import "YPBLDetailHeaderImgCell.h"
#import "YPMyAnliDetailTextCell.h"
#import "YPCaseInfoInfo.h"
//视频
#import "CHPlayerHeader.h"
#import "CHPlayerView.h"
#import "PlayOnFullScreenViewController.h"
#import "HRVideoTableViewCell.h"
#import "HRAddAnLiViewController.h"
#import "VideoPlayerViewController.h"
#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "HRAVPlayerViewController.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 200
static NSString *const cellId = @"DemoVC1Cell";

@interface YPMyAnliDetailController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) CHPlayerView * playerView;

@property (nonatomic, strong) YPCaseInfoInfo *infoInfo;
@property(nonatomic,strong)NSArray *imagesArray;

@end

@implementation YPMyAnliDetailController{
    UIView *_navView;
    UIButton *_backBtn;
    UIButton *_moreBtn;
    UILabel *_titleLabel;
}
-(NSArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray  =[NSArray array];
    }
    return _imagesArray;
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CHPlayerContinuePlayNotification object:self.playerView];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self CaseInfoInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHPlayerStopPlayNotification object:self.playerView];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [[UIApplication sharedApplication] keyWindow].backgroundColor = WhiteColor;
 
    [self setupNav];
    [self setupUI];
    
   
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor =  WhiteColor;
    [self.view addSubview:_navView];
    
    _titleLabel  = [[UILabel alloc]init];
    _titleLabel.text = @"";
    _titleLabel.textColor = WhiteColor;
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    _backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    if ([self.IsCheShouMyTeam integerValue] == 1) {
        
        //车手查询我的车队进入  不能编辑
        
    }else{
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
        [_moreBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navView).mas_offset(-15);
            make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        }];
    }
}
-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //            self.tableView.rowHeight = UITableViewAutomaticDimension;
    //            self.tableView.estimatedRowHeight = 80;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
    [sheet showInView:self.view];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    

    if (self.imagesArray.count > 0) {
        return 2 + self.imagesArray.count;
    }else{
        if ([self.infoInfo.VIDeos  isEqualToString:@""]) {
            return 2;
        }else{
             return 3;
        }
       
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.infoInfo.VIDeos isEqualToString:@""]) {
        //有图
        if (indexPath.row ==0) {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            UILabel *title = [[UILabel alloc]init];
            if (self.infoInfo.LogTitle.length > 0) {
                title.text = self.infoInfo.LogTitle;
            }else{
                title.text = @"无标题";
            }
            title.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
            title.textColor = BlackColor;
            title.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.contentView);
//                make.top.mas_equalTo(cell.contentView).mas_offset(22);
//                make.bottom.mas_equalTo(cell.contentView).mas_offset(-22);
            }];

            return cell;
        }else if (indexPath.row ==1){
            YPMyAnliDetailTextCell *cell = [YPMyAnliDetailTextCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoInfo.LogContent.length > 0) {
                cell.content.text = self.infoInfo.LogContent;
            }else{
                cell.content.text = @"当前没有内容";
            }
            return cell;

        }else{
            NSArray *arr = [self.infoInfo.Imgs componentsSeparatedByString:@","];
//
//            YPBLDetailHeaderImgCell *cell = [YPBLDetailHeaderImgCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            //        NSArray *arr = [@"http://121.42.156.151:94/FileGain.aspx?fi=6411bfca56ca40baa896e48704e63a87&it=0,http://121.42.156.151:94/FileGain.aspx?fi=6411bfca56ca40baa896e48704e63a87&it=0,http://121.42.156.151:94/FileGain.aspx?fi=6411bfca56ca40baa896e48704e63a87&it=0" componentsSeparatedByString:@","];
//            NSString *str = arr[indexPath.row - 2];
//            [cell.backImgV sd_setImageWithURL:[NSURL URLWithString:str]];
//            cell.imgStr = str;
//            return cell;

            DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(!cell)
            {
                cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            NSString *url = arr[indexPath.row - 2];
             NSLog(@"刷新%@",url);
            cell.imgStr =url;
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                /**
                 *  缓存image size
                 */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    
                    //reload row
                    if(result && (self.isViewLoaded && self.view.window))  {
                        
                        [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                    }else{
                        
                    }
                    
                }];
                
            }];
           return cell;
        }
    }else{//没图
        if ([self.infoInfo.VIDeos isEqualToString:@""]) {//没视频
            if (indexPath.row ==0) {
                UITableViewCell *cell = [[UITableViewCell alloc]init];
                UILabel *title = [[UILabel alloc]init];
                if (self.infoInfo.LogTitle.length > 0) {
                    title.text = self.infoInfo.LogTitle;
                }else{
                    title.text = @"无标题";
                }
                title.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
                title.textColor = BlackColor;
                title.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(cell.contentView);
                    make.top.mas_equalTo(cell.contentView).mas_offset(22);
                    make.bottom.mas_equalTo(cell.contentView).mas_offset(-22);
                }];
                
                return cell;
            }else{
                YPMyAnliDetailTextCell *cell = [YPMyAnliDetailTextCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.infoInfo.LogContent.length > 0) {
                    cell.content.text = self.infoInfo.LogContent;
                }else{
                    cell.content.text = @"当前没有内容";
                }
                return cell;

            }
        }else{//有视频
        
            if (indexPath.row ==0) {
                
                UITableViewCell *cell = [[UITableViewCell alloc]init];
                UILabel *title = [[UILabel alloc]init];
                if (self.infoInfo.LogTitle.length > 0) {
                    title.text = self.infoInfo.LogTitle;
                }else{
                    title.text = @"无标题";
                }
                title.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
                title.textColor = BlackColor;
                title.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(cell.contentView);
                    make.top.mas_equalTo(cell.contentView).mas_offset(22);
                    make.bottom.mas_equalTo(cell.contentView).mas_offset(-22);
                }];
                
                return cell;
            }else if (indexPath.row ==1){
                YPMyAnliDetailTextCell *cell = [YPMyAnliDetailTextCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.infoInfo.LogContent.length > 0) {
                    cell.content.text = self.infoInfo.LogContent;
                }else{
                    cell.content.text = @"当前没有内容";
                }
                return cell;

            }else{
            

                HRVideoTableViewCell *cell = [HRVideoTableViewCell cellWithTableView:tableView];
                [cell.playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
                [cell.VideoimageView sd_setImageWithURL:[NSURL URLWithString:self.infoInfo.CoverMap]];
               
                return cell;
                
            }
        }
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([self.infoInfo.VIDeos isEqualToString:@""]) {
        //有图
        if (indexPath.row ==0) {
          
        }else if (indexPath.row ==1){
            
        }else{
            //
          
        }
    }else{//没图
        if ([self.infoInfo.VIDeos isEqualToString:@""]) {//没视频
            if (indexPath.row ==0) {
             
            }else{
                
                
            }
        }else{//有视频
            
            if (indexPath.row ==0) {
              
            }else if (indexPath.row ==1){
                
                
            }else{
                
//                VideoPlayerViewController *p = [VideoPlayerViewController new];
//                p.videoTitle =self.infoInfo.LogTitle;
//                p.type =PlayerTypeOfNavigationBar;
//                p.videoUrl =self.infoInfo.VIDeos;
//                [self.navigationController pushViewController:p animated:YES];
                
      
                [self playClick];
                
//                PlayOnFullScreenViewController *p = [PlayOnFullScreenViewController new];
//                p.videoTitle =self.infoInfo.LogTitle;
//                NSLog(@"%@",self.infoInfo.VIDeos);
//                p.videoUrl =self.infoInfo.VIDeos;
//                [self.navigationController presentViewController:p animated:YES completion:nil];
            }
        }
    }
    
    
    
    
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.infoInfo.VIDeos isEqualToString:@""]) {
        //有图
        if (indexPath.row ==0) {
            return 50;
        }else if (indexPath.row ==1){
            if ([self.infoInfo.LogContent isEqualToString:@""]) {
                return 0;
            }else{
               return [self getHeighWithTitle:self.infoInfo.LogContent font:kFont(17) width:ScreenWidth]+50;
            }
           
        }else{
                       //
            
            NSArray *arr = [self.infoInfo.Imgs componentsSeparatedByString:@","];
            //
            NSString *url = arr[indexPath.row - 2];
            /**
             *  参数1:图片URL
             *  参数2:imageView 宽度
             *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
             */
    
            return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
                   }
    }else{//没图
        if ([self.infoInfo.VIDeos isEqualToString:@""]) {//没视频
            if (indexPath.row ==0) {
                 return 50;
                           }else{
                               if ([self.infoInfo.LogContent isEqualToString:@""]) {
                                   return 0;
                               }else{
                                   return [self getHeighWithTitle:self.infoInfo.LogContent font:kFont(17) width:ScreenWidth]+50;
                               }
                               
                            }
        }else{//有视频
            
            if (indexPath.row ==0) {
                return 50;
                            }else if (indexPath.row ==1){
                                if ([self.infoInfo.LogContent isEqualToString:@""]) {
                                    return 0;
                                }else{
                                    return [self getHeighWithTitle:self.infoInfo.LogContent font:kFont(17) width:ScreenWidth]+50;
                                }
                                
            }else{
                
                return 200;
            }
        }
    }
    

    
    
    

  
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

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = NavBarColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"三个点-W"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
        _titleLabel.text = self.infoInfo.LogTitle;
    }
    else
    {
        _titleLabel.text = @"";
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"编辑");
        
        HRAddAnLiViewController *addvc =[HRAddAnLiViewController new];
        if (![self.infoInfo.Imgs isEqualToString:@""]) {//相册编辑
             addvc.type =@"上传图片";
            addvc.leixingStr =@"2";
            addvc.titleStr =self.infoInfo.LogTitle;
            addvc.neirongStr =self.infoInfo.LogContent;
            addvc.CaseID =self.infoInfo.CaseID;
            NSMutableArray *fmarr = [NSMutableArray array];
            NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.infoInfo.CoverMap]];
            UIImage* resultImage = [UIImage imageWithData: imageData];
            [fmarr addObject:resultImage];
            addvc.fmImageArray =fmarr;
            
            if (![self.infoInfo.Imgs isEqualToString:@""]) {//有图
                NSMutableArray *xiangcearr = [NSMutableArray array];
                for (NSString *str in self.imagesArray) {
                    NSData* imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                    UIImage* resultImage2 = [UIImage imageWithData: imageData2];
                    [xiangcearr addObject:resultImage2];
                }
                
                addvc.selectImageArray =xiangcearr;
            }
            
            [self.navigationController pushViewController:addvc animated:YES];
        }else{
            
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传新视频将会替换现有视频，不上传则继续使用原视频" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag =1002;
            [alertView show];

           
        }
      
    }else if (buttonIndex == 1){
        NSLog(@"删除");
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除案例" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag =1000;
        [alertView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 1 && alertView.tag == 1000) {
   //删除案例
        [self deleteAnliRequest];
    }
    if (buttonIndex == 0 && alertView.tag == 1001) {
        [self backVC];
    }
    if (buttonIndex == 1 && alertView.tag == 1002) {
         HRAddAnLiViewController *addvc =[HRAddAnLiViewController new];
        //视频编辑
        addvc.type =@"上传视频";
        addvc.leixingStr =@"2";
        addvc.titleStr =self.infoInfo.LogTitle;
        addvc.neirongStr =self.infoInfo.LogContent;
         addvc.CaseID =self.infoInfo.CaseID;
        NSMutableArray *fmarr = [NSMutableArray array];
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.infoInfo.CoverMap]];
        UIImage* resultImage = [UIImage imageWithData: imageData];
        [fmarr addObject:resultImage];
        addvc.fmImageArray =fmarr;
        addvc.editVideoUrl =self.infoInfo.VIDeos;
        [self.navigationController pushViewController:addvc animated:YES];
    }
}
#pragma mark - 网络请求
#pragma mark - 获取案例详细信息
- (void)CaseInfoInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CaseInfoInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.SupplierID.length > 0) {
//        params[@"SupplierID"] = [NSString stringWithFormat:@"%zd",self.SupplierID];
        params[@"FacilitatorId"] = self.SupplierID;//18-08-10
        
    }else{
//        params[@"SupplierID"] = mySupplierID;
        params[@"FacilitatorId"] = FacilitatorId_New;//18-08-10
    }
    params[@"CaseID"] = self.CaseID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"%@",object);
            self.infoInfo.CaseID        = [object valueForKey:@"CaseID"];
            self.infoInfo.CoverMap      = [object valueForKey:@"CoverMap"];
            self.infoInfo.LogTitle      = [object valueForKey:@"LogTitle"];
            self.infoInfo.LogContent    = [object valueForKey:@"LogContent"];
            self.infoInfo.Imgs          = [object valueForKey:@"Imgs"];
            self.infoInfo.VIDeos        = [object valueForKey:@"VIDeos"];
            self.infoInfo.CreateTime    = [object valueForKey:@"CreateTime"];
            
            self.infoInfo.CaseID =[object objectForKey:@"CaseID"];//????? 18-08-10
            
            self.imagesArray = [self.infoInfo.Imgs componentsSeparatedByString:@","];
            
            [self.tableView reloadData];

          
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

- (void)deleteAnliRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DelCaseInfoInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"SupplierID"] = mySupplierID;
    params[@"FacilitatorId"] = FacilitatorId_New;//18-08-10 服务商Id
    
    params[@"CaseID"] = self.CaseID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"%@",object);
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag =1001;
            [alertView show];
            
            
            
            
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

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
////设置是否支持自动旋转 默认开启 == 配合锁屏
//- (BOOL)shouldAutorotate{
//    NSNumber *lock = [[NSUserDefaults standardUserDefaults] objectForKey:CHPlayer_LockScreen];
//    return ![lock boolValue];
//}
// 设置是否支持自动旋转 默认开启
//
//- (BOOL)shouldAutorotate{
//    return YES;
//}

// 支持旋转的方向
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
#pragma mark - getter
- (YPCaseInfoInfo *)infoInfo{
    if (!_infoInfo) {
        _infoInfo = [[YPCaseInfoInfo alloc]init];
    }
    return _infoInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playClick{
//    VideoPlayerViewController *p = [VideoPlayerViewController new];
//    p.videoTitle =self.infoInfo.LogTitle;
//    p.type =PlayerTypeOfNavigationBar;
//
//
//    p.videoUrl =self.infoInfo.VIDeos;
//    [self.navigationController pushViewController:p animated:YES];
    HRAVPlayerViewController *PVC = [HRAVPlayerViewController new];
    PVC.videoTitle =self.infoInfo.LogTitle;
    PVC.videoUrl =self.infoInfo.VIDeos;
    [self.navigationController presentViewController:PVC animated:YES completion:nil];
}


@end
