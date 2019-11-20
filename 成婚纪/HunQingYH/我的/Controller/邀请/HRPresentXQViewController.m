//
//  HRPresentXQViewController.m
//  hunqing
//
//  Created by DiKai on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "HRPresentXQViewController.h"
#import "SDCycleScrollView.h"
#import "HRShangPinSec0Cell.h"
#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "HRPresentOnlyTextCell.h"
#import "YPGetActivityPrizesInfo.h"

static NSString *const cellId = @"DemoVC1Cell";

//图片浏览
#import "HZPhotoBrowserView.h"
@interface HRPresentXQViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    UIView *navView;
    UITableView *thisTableView;
    SDCycleScrollView *_cycleScrollView;
    HZPhotoBrowserView *_backView;
    UIImageView *_bigImgV;
}
//@property(nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) NSString *imgStr;

@property (nonatomic, strong) YPGetActivityPrizesInfo *info;

@end

@implementation HRPresentXQViewController

//-(NSArray *)dataArray{
//    if (!_dataArray) {
////        _dataArray = [NSArray arrayWithObjects:@"https://p3.pstatp.com/origin/433f0002b6df28fb0cb4",@"https://p3.pstatp.com/origin/434200028d6038089805", @"https://p9.pstatp.com/origin/43450000b5fe77749118",@"https://p1.pstatp.com/origin/43430002835ef68a27f4",@"https://p3.pstatp.com/origin/43350002d83d49e3d3c0",@"https://p1.pstatp.com/origin/43340002e1e200391dcc",nil];
//
//
//    }
//    return _dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMainUI];
    [self createNav];
    
}
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_red"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
    //    UILabel *titleLab  = [[UILabel alloc]init];
    //    titleLab.text =@"我的添加";
    //    titleLab.textColor = BlackColor;
    //    titleLab.font = [UIFont systemFontOfSize:20 ];
    //    [navView addSubview:titleLab];
    //    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_equalTo(backBtn.mas_centerY);
    //        make.centerX.mas_equalTo(navView.mas_centerX);
    //    }];
}
-(void)creatMainUI{
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.rowHeight = UITableViewAutomaticDimension;
    thisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [thisTableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:thisTableView];

    
}
#pragma mark ------------tableviewDatascource --------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section ==1) {
////        return self.dataArray.count;
//
//    }else{
//        return 1;
//    }
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        HRShangPinSec0Cell * cell = [HRShangPinSec0Cell cellWithTableView:tableView];
        
        if (self.info.CommodityName.length > 0) {
            cell.titleLab.text = self.info.CommodityName;
        }else{
            cell.titleLab.text = @"当前无名称";
        }
        NSLog(@"self.info.MarketPrice -- %@",self.info.MarketPrice);
//        cell.priceLab.text = self.info.MarketPrice;
        cell.priceLab.text = [NSString stringWithFormat:@"¥%@",self.info.MarketPrice];
        
        if (self.info.PrizesKeyWord.length > 0) {
            cell.desLab.text = self.info.PrizesKeyWord;
        }else{
            cell.desLab.text = @"当前无关键字";
        }
        return cell;
        
    }else{
        
        
//        DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if(!cell)
//        {
//            cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        }
//
//        NSString *url = self.dataArray[indexPath.row];
//
//        cell.imgStr =url;
//
//
//
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//            /**
//             *  缓存image size
//             */
//            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
//
//                //reload row
//                if(result)  [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
//                else{
//                    NSLog(@"没结果");
//                }
//            }];
//
//        }];
//        return cell;
        
        HRPresentOnlyTextCell *cell = [HRPresentOnlyTextCell cellWithTableView:tableView];
        if (self.info.PrizesContent.length > 0) {
            cell.textLab.text = self.info.PrizesContent;
        }else{
            cell.textLab.text = @"当前无内容";
        }
        return cell;
    }
    
    
}
#pragma mark ------------tableviewDelegate----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (self.info.CommodityName.length == 0) {
            return 50;
        }else{
            return [self getHeighWithTitle:self.info.CommodityName font:kFont(14) width:ScreenWidth-20]+[self getHeighWithTitle:self.info.PrizesKeyWord font:kFont(14) width:ScreenWidth-20]+50;
        }
    }else{
        
        if (self.info.PrizesContent.length == 0) {
            return 60;
        }else{
            return [self getHeighWithTitle:self.info.PrizesContent font:kFont(15) width:ScreenWidth-20]+60;
        }
    
        
//        NSString *url = self.dataArray[indexPath.row];
//        //         NSLog(@"------%@",url);
//        NSLog(@"预估%f",[XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200]);
//        /**
//         *  参数1:图片URL
//         *  参数2:imageView 宽度
//         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
//         */
//        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else{
        return 60;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        headerView.backgroundColor =CHJ_bgColor;
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 50)];
        bgView.backgroundColor =WhiteColor;
        [headerView addSubview:bgView];
        
        UILabel *xqLab = [[UILabel alloc]init];
        xqLab.text =@"详情";
        xqLab.textColor=TextNormalColor;
        xqLab.font =kFont(15);
        [bgView addSubview:xqLab];
        [xqLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(bgView);
            //            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
        
        UIView *leftLine = [[UIView alloc]init];
        leftLine.backgroundColor =CHJ_bgColor;
        [bgView addSubview:leftLine];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(xqLab);
            make.right.mas_equalTo(xqLab.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(50, 2));
        }];
        
        
        UIView *rightLine = [[UIView alloc]init];
        rightLine.backgroundColor =CHJ_bgColor;
        [bgView addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(xqLab);
            make.left.mas_equalTo(xqLab.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 2));
        }];
        return headerView;
    }
}
#pragma mark -------target-------

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
- (UIView *)addHeaderView{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];//原高度 ScreenWidth*2/3  2-2
    
//    NSMutableArray *imagesURLStrings = [NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NSString *str = @"http://p3.pstatp.com/large/3c6000014be275cc89f0";
//        [imagesURLStrings addObject:str];
//    }
    
    NSArray *arr = [self.info.Imgs componentsSeparatedByString:@","];
    
    //网络加载轮播图片
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) imageURLStringsGroup:arr];//原高度 ScreenWidth*2/3  2-2 修改
    
    _cycleScrollView.infiniteLoop = YES;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage=[UIImage imageNamed:@"头"];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 2.0; // 轮播时间间隔
    _cycleScrollView.currentPageDotColor = NavBarColor;
    header.backgroundColor = CHJ_bgColor;
    [header addSubview:_cycleScrollView];
    
    
    
    
    return header;
}


-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ---SDCycleScrollowViewDelegate------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"----点击了第%ld张图片",(long)index);
    
//    self.imgStr = self.dataArray[index];
    NSArray *arr = [self.info.Imgs componentsSeparatedByString:@","];
    self.imgStr = arr[index];
    
    _backView = [[HZPhotoBrowserView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //    // 设置阴影背景的点击响应，此处为收起大图
    //    _backView.userInteractionEnabled = YES;
    
    _backView.backgroundColor = [UIColor blackColor];
    [_backView setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:nil];
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBigImage)];
    [_backView addGestureRecognizer:bgTap];
    
    _backView.frame = CGRectOffset([UIApplication sharedApplication].keyWindow.rootViewController.view.frame,0 , [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height);
    float height = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height;
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
                         _backView.center = CGPointMake(_backView.center.x, _backView.center.y - height);
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }];
    
    
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight - 70, 55, 30)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderWidth = 0.1;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    saveButton.layer.cornerRadius = 2;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:saveButton];
  
    
    
    
}
#pragma mark --------图片浏览------------
- (void)oneImgTap{
    
    _backView = [[HZPhotoBrowserView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //    // 设置阴影背景的点击响应，此处为收起大图
    //    _backView.userInteractionEnabled = YES;
    
    _backView.backgroundColor = [UIColor blackColor];
    [_backView setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:nil];
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBigImage)];
    [_backView addGestureRecognizer:bgTap];
    
    _backView.frame = CGRectOffset([UIApplication sharedApplication].keyWindow.rootViewController.view.frame,0 , [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height);
    float height = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height;
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
                         _backView.center = CGPointMake(_backView.center.x, _backView.center.y - height);
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }];
    
    
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight - 70, 55, 30)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderWidth = 0.1;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    saveButton.layer.cornerRadius = 2;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:saveButton];
    
}

#pragma mark 保存图像
- (void)saveImage
{
    
    UIImageWriteToSavedPhotosAlbum(_backView.imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = _backView.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.50f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 60);
    label.center = _backView.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:21];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = @"保存失败";
    }   else {
        label.text = @"保存成功";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)dismissBigImage{
    
    CGRect oneImgBtnFrame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenWidth*2/3);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _bigImgV.frame = CGRectMake(ScreenWidth*0.5, ScreenHeight*0.5, oneImgBtnFrame.size.width*0.01, oneImgBtnFrame.size.height*0.01);
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_bigImgV removeFromSuperview];
        [_backView removeFromSuperview];
        
        _bigImgV = nil;
        _backView = nil;
    });
    
}

#pragma mark - 隐藏导航条

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self GetActivityPrizesInfo];
}

#pragma mark - 网络请求
#pragma mark 查看活动奖品详细信息
-(void)GetActivityPrizesInfo{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityPrizesInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ActivityPrizesID"]  = self.activityPrizesID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.info.ActivityPrizesID  = [object valueForKey:@"ActivityPrizesID"];
            self.info.CommodityName     = [object valueForKey:@"CommodityName"];
            self.info.PrizesKeyWord     = [object valueForKey:@"PrizesKeyWord"];
            self.info.PrizesContent     = [object valueForKey:@"PrizesContent"];
            self.info.Country           = [object valueForKey:@"Country"];
            self.info.Imgs              = [object valueForKey:@"Imgs"];
            self.info.MarketPrice       = [object valueForKey:@"MarketPrice"];
            self.info.CreateTime        = [object valueForKey:@"CreateTime"];

            NSLog(@" --------    %@ %@ %@ %@ %@ %@ %@ %@",self.info.ActivityPrizesID,self.info.CommodityName,self.info.PrizesKeyWord,self.info.PrizesContent,self.info.Country,self.info.Imgs,self.info.MarketPrice,self.info.CreateTime);
            
            thisTableView.tableHeaderView =[self addHeaderView];
            [thisTableView reloadData];
            
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
- (YPGetActivityPrizesInfo *)info{
    if (!_info) {
        _info = [[YPGetActivityPrizesInfo alloc]init];
    }
    return _info;
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
