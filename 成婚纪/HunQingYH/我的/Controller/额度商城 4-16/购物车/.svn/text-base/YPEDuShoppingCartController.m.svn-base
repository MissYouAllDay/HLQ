//
//  YPEDuShoppingCartController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/18.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuShoppingCartController.h"
#import "LZConfigFile.h"
#import "HRCartTableViewCell.h"
#import "HRCartModel.h"
#import "HRTuiJianShangPinCell.h"
#import "YPEDuGoodDetailController.h"
#import "YPEDuSureOrderController.h"//结算
///18-08-09 修改
//#import "YPGetCommodityTypeTableListData.h"//凑单商品模型
#import "YPShoppingCartPieceTogether.h"//凑单商品模型


@interface YPEDuShoppingCartController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL _isHiddenNavigationBarWhenDisappear;//记录当页面消失时是否需要隐藏系统导航
    BOOL _isHasTabBarController;//是否含有tabbar
    BOOL _isHasNavitationController;//是否含有导航
    UIButton *editBtn;//编辑按钮
    NSInteger editFlag;//0非编辑状态 1 编辑
    UILabel *label;//合计lab
    UIButton *btn ;//计算按钮
    NSInteger requestIndext; //请求次数
    UIButton *selectAll;//全选按钮
}


@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property(nonatomic,strong)UICollectionView *collectionView;
/**推荐数组*/
@property(nonatomic,strong)NSMutableArray   *tuijianArray;
@end

@implementation YPEDuShoppingCartController{
    NSInteger _TotalCount;//购物车商品总数量
}
-(NSMutableArray *)tuijianArray{
    if (!_tuijianArray) {
        _tuijianArray = [NSMutableArray array];
    }
    return _tuijianArray;
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    
    
    if (_isHasNavitationController == YES) {
        if (self.navigationController.navigationBarHidden == YES) {
            _isHiddenNavigationBarWhenDisappear = NO;
        } else {
            self.navigationController.navigationBarHidden = YES;
            _isHiddenNavigationBarWhenDisappear = YES;
        }
    }
    
    
    //当进入购物车的时候判断是否有已选择的商品,有就清空
    //主要是提交订单后再返回到购物车,如果不清空,还会显示
    if (self.selectedArray.count > 0) {
        for (HRCartModel *model in self.selectedArray) {
            model.select = NO;//这个其实有点多余,提交订单后的数据源不会包含这些,保险起见,加上了
        }
        [self.selectedArray removeAllObjects];
    }
    editFlag =0;
    requestIndext =0;
    [self GetshangpinList];
    //初始化显示状态
    _allSellectedButton.selected = NO;
    _totlePriceLabel.attributedText = [self HRSetString:@"￥0.00"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (_isHiddenNavigationBarWhenDisappear == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
//    editFlag =0;
//    requestIndext =0;
//    [self setupNav];
   
//    _isHasTabBarController = self.tabBarController?YES:NO;
    _isHasTabBarController =NO;
    _isHasNavitationController = self.navigationController?YES:NO;
//    [self GetshangpinList];

    
    
    [self setupCustomNavigationBar];
  
}




- (void)loadData {
    [self changeView];
}

/**
 *  @author LQQ, 16-02-18 11:02:16
 *
 *  计算已选中商品金额
 */
-(void)countPrice {
    double totlePrice = 0.0;
    for (HRCartModel *model in self.dataArray) {//9.20修改

//    for (HRCartModel *model in self.selectedArray) {
        
        double price = [model.Quota doubleValue];
        
        totlePrice += price*model.Count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.attributedText = [self HRSetString:string];
}

#pragma mark - 初始化数组
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}


- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectedArray;
}

#pragma mark - 布局页面视图
#pragma mark -- 自定义导航
- (void)setupCustomNavigationBar {
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LZSCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    backgroundView.backgroundColor = WhiteColor;
    [self.view addSubview:backgroundView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - 0.5, LZSCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    
    
        //设置导航栏左边通知
        UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.left.mas_equalTo(backgroundView.mas_left);
            make.bottom.mas_equalTo(backgroundView.mas_bottom).offset(-10);
        }];
  
        UILabel *titleLab  = [[UILabel alloc]init];
        titleLab.text = @"购物车";
        titleLab.textColor = BlackColor;
        [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [backgroundView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(backBtn.mas_centerY);
            make.centerX.mas_equalTo(backgroundView.mas_centerX);
        }];
    
    
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backgroundView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = LZColorFromRGB(245, 245, 245);
    backgroundView.tag = TAG_CartEmptyView + 1;
    [self.view addSubview:backgroundView];
    
    //当有tabBarController时,在tabBar的上面
    if (_isHasTabBarController == YES) {
        backgroundView.frame = CGRectMake(0, LZSCREEN_HEIGHT -  2*TAB_BAR_HEIGHT, LZSCREEN_WIDTH, TAB_BAR_HEIGHT);
    } else {
        backgroundView.frame = CGRectMake(0, LZSCREEN_HEIGHT -  TAB_BAR_HEIGHT, LZSCREEN_WIDTH, TAB_BAR_HEIGHT);
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, LZSCREEN_WIDTH, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, TAB_BAR_HEIGHT - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    if (editFlag ==0) {
        //非编辑状态 ：隐藏全选
        selectAll.hidden =YES;
    }else{
        selectAll.hidden =NO;
    }
    
    //结算按钮
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = BASECOLOR_RED;
    btn.frame = CGRectMake(LZSCREEN_WIDTH - 80, 0, 80, TAB_BAR_HEIGHT);
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
    //合计
    label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor redColor];
    [backgroundView addSubview:label];
//    double totlePrice = 0.0;
    
 
//    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    label.attributedText = [self HRSetString:@"￥0.00"];
//    CGFloat maxWidth = LZSCREEN_WIDTH - selectAll.bounds.size.width - btn.bounds.size.width - 30;
    //    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, LZTabBarHeight)];
//    label.frame = CGRectMake(selectAll.bounds.size.width + 20, 0, maxWidth - 10, TAB_BAR_HEIGHT);
    self.totlePriceLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(btn);
        make.right.mas_equalTo(btn.mas_left).offset(-20);
    }];
    [self countPrice];
}

- (NSMutableAttributedString*)HRSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}
#pragma mark -- 购物车为空时的默认视图
- (void)changeView {
    if (self.dataArray.count > 0) {
        UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        if (view != nil) {
            [view removeFromSuperview];
        }
        
        [self setupCartView];
    } else {
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
        [bottomView removeFromSuperview];
        [self.myTableView reloadData];
        self.myTableView = nil;
        [self.myTableView removeFromSuperview];
        
        [self setupCartEmptyView];
    }
}

- (void)setupCartEmptyView {
    
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LZSCREEN_WIDTH, LZSCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    backgroundView.tag = TAG_CartEmptyView;
    UIImageView *noCarImageView = [[UIImageView alloc]init];
    noCarImageView.image =[UIImage imageNamed:@"shopCart"];
    [backgroundView addSubview:noCarImageView];
    [noCarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView);
        make.top.mas_equalTo(backgroundView.mas_top).offset(150);
        make.size.mas_equalTo(noCarImageView.image.size);
    }];
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.font =kFont(15);
    desLab.textColor =[UIColor grayColor];
    desLab.textAlignment =NSTextAlignmentCenter;
    desLab.text =@"购物车还没有商品，先去商城看看吧";
    [backgroundView addSubview:desLab];
    [desLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView);
        make.top.mas_equalTo(noCarImageView.mas_bottom);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 50));
    }];
    [self.view addSubview:backgroundView];
    
}
#pragma mark -- 购物车有商品时的视图
- (void)setupCartView {
    //创建底部视图
    [self setupCustomBottomView];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    table.delegate = self;
    table.dataSource = self;
    
    table.rowHeight = lz_CartRowHeight;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = LZColorFromRGB(245, 246, 248);
    [self.view addSubview:table];
    self.myTableView = table;
    
    if (_isHasTabBarController) {
        table.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LZSCREEN_WIDTH, LZSCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 2*TAB_BAR_HEIGHT);
    } else {
        table.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LZSCREEN_WIDTH, LZSCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT);
    }
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
//    if (editFlag ==0) {
//        //非编辑状态 ：有推荐凑单
//          return self.dataArray.count+1;
//    }else{
//        //编辑状态 ：无推荐凑单
//          return self.dataArray.count;
//    }
    //9.20 去掉推荐
    return self.dataArray.count;
   
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (editFlag ==0) {
//        //非编辑状态 ：有推荐凑单
//        if (indexPath.row ==self.dataArray.count) {
//            return self.tuijianArray.count/ 2 * (ScreenWidth/2+100)+50;
//        }else{
//            return 100;
//        }
//    }else{
//        //编辑状态 ：无推荐凑单
//
//            return 100;
//
//    }
//
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editFlag ==0) {
        //非编辑状态 ：有推荐凑单
//        if (indexPath.row ==self.dataArray.count) {
//            //推荐凑单
//
//
//            UITableViewCell *cell = [[UITableViewCell  alloc]init];
//            cell.contentView.backgroundColor =CHJ_bgColor;
//            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//            //    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.dataArray.count / 2 * 200) collectionViewLayout:layout];
//            UIView *headeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//            headeView.backgroundColor =WhiteColor;
//            UILabel *desLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//            desLab.text =@"凑单推荐";
//            desLab.font =kFont(20);
//            desLab.textAlignment =NSTextAlignmentCenter;
//            [headeView addSubview:desLab];
//            [cell.contentView addSubview:headeView];
//
//            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, self.tuijianArray.count/ 2 * (ScreenWidth/2+100)) collectionViewLayout:layout];
//            collectionView.delegate = self;
//            collectionView.dataSource = self;
//            [collectionView registerNib:[UINib nibWithNibName:@"HRTuiJianShangPinCell" bundle:nil] forCellWithReuseIdentifier:@"HRTuiJianShangPinCell"];
//            layout.itemSize = CGSizeMake( (ScreenWidth - 10) / 2, ScreenWidth/2+100);
//            layout.minimumLineSpacing = 5;
//            layout.minimumInteritemSpacing = 0;
//            collectionView.scrollEnabled = NO;
//            collectionView.backgroundColor = [UIColor whiteColor];
//            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
//            [cell.contentView addSubview:collectionView];
//            return cell;
//        }else{
            HRCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRCartReusableCell"];
            if (cell == nil) {
                cell = [[HRCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HRCartReusableCell"];
            }
            
            HRCartModel *model = self.dataArray[indexPath.row];
            __block typeof(cell)wsCell = cell;
            //加号按钮点击回调
            [cell numberAddWithBlock:^(NSInteger number) {
                wsCell.lzNumber = number;
                model.Count = number;
                
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
//                if ([self.selectedArray containsObject:model]) {
//                    [self.selectedArray removeObject:model];
//                    [self.selectedArray addObject:model];
//                    [self countPrice];
//                }
//                NSLog(@"购物车%@加 %@ --ID为：%@--%zd个",model.ShoppingCartId, model.CommodityName,model.PlaceOriginId,number);
                [self UpShoppingCarRequestWithShoppingCarID:model.ShoppingCartId withXingHaoID:model.PlaceOriginId WithNumber:number];
            }];
            //减号按钮点击回调
            [cell numberCutWithBlock:^(NSInteger number) {
                
                wsCell.lzNumber = number;
                model.Count = number;
                
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                
                //判断已选择数组里有无该对象,有就删除  重新添加
//                if ([self.selectedArray containsObject:model]) {
//                    [self.selectedArray removeObject:model];
//                    [self.selectedArray addObject:model];
//                    [self countPrice];
//                }
//                  NSLog(@"购物车%@减 %@ --ID为：%@--%zd个",model.ShoppingCartId, model.CommodityName,model.PlaceOriginId,number);
               [self UpShoppingCarRequestWithShoppingCarID:model.ShoppingCartId withXingHaoID:model.PlaceOriginId WithNumber:number];
            }];
             cell.selectBtn.hidden =YES;
            [cell cellSelectedWithBlock:^(BOOL select) {
                
                model.select = select;
                if (select) {
                    [self.selectedArray addObject:model];
                } else {
                    [self.selectedArray removeObject:model];
                }
                
                if (self.selectedArray.count == self.dataArray.count) {
                    _allSellectedButton.selected = YES;
                } else {
                    _allSellectedButton.selected = NO;
                }
                
                [self countPrice];
            }];
            
            [cell reloadDataWithModel:model];
            return cell;
//        }
    }else{
        //编辑状态 ：无推荐凑单
       
            HRCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRCartReusableCell"];
            if (cell == nil) {
                cell = [[HRCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HRCartReusableCell"];
            }
            
            HRCartModel *model = self.dataArray[indexPath.row];
            __block typeof(cell)wsCell = cell;
            
            [cell numberAddWithBlock:^(NSInteger number) {
                wsCell.lzNumber = number;
                model.Count = number;
                
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                if ([self.selectedArray containsObject:model]) {
                    [self.selectedArray removeObject:model];
                    [self.selectedArray addObject:model];
                    [self countPrice];
                }
                [self UpShoppingCarRequestWithShoppingCarID:model.ShoppingCartId withXingHaoID:model.PlaceOriginId WithNumber:number];
            }];
            
            [cell numberCutWithBlock:^(NSInteger number) {
                
                wsCell.lzNumber = number;
                model.Count = number;
                
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                
                //判断已选择数组里有无该对象,有就删除  重新添加
                if ([self.selectedArray containsObject:model]) {
                    [self.selectedArray removeObject:model];
                    [self.selectedArray addObject:model];
                    [self countPrice];
                }
                [self UpShoppingCarRequestWithShoppingCarID:model.ShoppingCartId withXingHaoID:model.PlaceOriginId WithNumber:number];
            }];
        
            cell.selectBtn.hidden=NO;
            [cell cellSelectedWithBlock:^(BOOL select) {
                
                model.select = select;
                if (select) {
                    [self.selectedArray addObject:model];
                } else {
                    [self.selectedArray removeObject:model];
                }
                
                if (self.selectedArray.count == self.dataArray.count) {
                    _allSellectedButton.selected = YES;
                } else {
                    _allSellectedButton.selected = NO;
                }
                
                [self countPrice];
            }];
            
            [cell reloadDataWithModel:model];
            return cell;
        
    }
    
    
    
   
    
   
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            HRCartModel *model = [self.dataArray objectAtIndex:indexPath.row];
            
            [self deleteShoppingCarwithID:model.ShoppingCartId];
//            [self.dataArray removeObjectAtIndex:indexPath.row];
//            //    删除
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//            //判断删除的商品是否已选择
//            if ([self.selectedArray containsObject:model]) {
//                //从已选中删除,重新计算价格
//                [self.selectedArray removeObject:model];
//                [self countPrice];
//            }
//
//            if (self.selectedArray.count == self.dataArray.count) {
//                _allSellectedButton.selected = YES;
//            } else {
//                _allSellectedButton.selected = NO;
//            }
//
//            if (self.dataArray.count == 0) {
//                [self changeView];
//            }
//
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)reloadTable {
    [self.myTableView reloadData];
}

#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tuijianArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"collection";
    HRTuiJianShangPinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HRTuiJianShangPinCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor =CHJ_bgColor;
    cell.model =self.tuijianArray[indexPath.item];

    cell.shopBtn.userInteractionEnabled =NO;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 2, 2, 2);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YPShoppingCartPieceTogether *model = self.tuijianArray[indexPath.item];
    YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
    detail.commodityId = model.CommodityId;
    
    detail.willShowCart = YES;//显示购物车
    
    detail.ActivityIdType = self.ActivityIdType;//18-09-19
    
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark -- 页面按钮点击事件
#pragma mark --- 返回按钮点击事件
- (void)backButtonClick:(UIButton*)button {
    if (_isHasNavitationController == NO) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (HRCartModel *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (button.selected) {
        
        for (HRCartModel *model in self.dataArray) {
            model.select = YES;
            [self.selectedArray addObject:model];
        }
    }
    
    [self.myTableView reloadData];
    [self countPrice];
}
#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
    
    
    if (editFlag ==0) {
        //非编辑状态 ：去结算
      
            for (HRCartModel *model in self.selectedArray) {
                NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.Count);
            }
            YPEDuSureOrderController *sureVC = [[YPEDuSureOrderController alloc]init];
            sureVC.modelArr = self.dataArray.copy;
            sureVC.ActivityIdType = self.ActivityIdType;//18-09-19
            [self.navigationController pushViewController:sureVC animated:YES];
            
      
    }else{
        //编辑状态 ：删除
        if (self.selectedArray.count > 0) {
            NSString *idStr =@"";
            for (int i=0; i<self.selectedArray.count; i++) {
                HRCartModel *model =self.selectedArray[i];
                if (i==0) {
                    idStr=[idStr stringByAppendingString:model.ShoppingCartId];
                }else{
                    idStr =[idStr stringByAppendingString:[NSString stringWithFormat:@",%@",model.ShoppingCartId]];
                }
            }

            [self deleteShoppingCarwithID:idStr];
        } else {
           
            [EasyShowTextView showText:@"你还没有选择任何商品"];
            
        }
    }
    
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editBtnClick{
    editFlag =!editFlag;
    if (editFlag ==0) {
        //非编辑状态
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        //把之前已选择的全部删除
        for (HRCartModel *model in self.selectedArray) {
            model.select = NO;
        }
        
        
        selectAll.hidden =YES;
        selectAll.selected =NO;
         [self countPrice];
        [self GetshangpinList];
        label.hidden =NO;
        [btn setTitle:@"去结算" forState:UIControlStateNormal];
        
    }else{
        //编辑状态
         [editBtn setTitle:@"完成" forState:UIControlStateNormal];
        selectAll.hidden =NO;
        
        [self GetshangpinList];
        label.hidden =YES;//隐藏合计lab
        [btn setTitle:@"删除" forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------网络请求-------------
//获取购物车商品列表
- (void)GetshangpinList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetShoppingCartList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] =UserId_New;
    
    params[@"Type"] = @"2";//类型 传数字2 18-08-09 添加
    
    //18-09-17
    if (self.ActivityIdType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.ActivityIdType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.ActivityIdType.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            requestIndext++;
            NSLog(@"购物车商品列表：%@",object);
            
            self.dataArray = [HRCartModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            _TotalCount = [[object valueForKey:@"TotalCount"] integerValue];
    
//            //9.20修改，默认全选中
            
            [self.selectedArray removeAllObjects];
            if (editFlag ==0) {
                for (HRCartModel *model in self.dataArray) {
                    
                    [self.selectedArray addObject:model];
                }
            }

//
//
     
            if (self.dataArray.count > 0) {
                if (requestIndext==1) {
                    [self setupCartView];
                }else{
                    [self reloadTable];
                }
//                if (editFlag ==0) {
//                    [self GetCouDanList];
//                }
                [self countPrice];
            } else {

               [self changeView];
            }
            
           
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}


//删除购物车商品
-(void)deleteShoppingCarwithID:(NSString*)shoppingCarId {
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DelShoppingCart";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ShoppingCartIds"] = shoppingCarId;
   
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showSuccessText:@"删除成功"];
       
            [self GetshangpinList];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
}
//修改购物车商品
-(void)UpShoppingCarRequestWithShoppingCarID:(NSString *)shoppCarID withXingHaoID:(NSString*)xinghaoID WithNumber:(NSInteger )number{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpShoppingCart";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ShoppingCartId"] = shoppCarID;
    params[@"Count"] = [NSString stringWithFormat:@"%zd",number];
    //FIXME: 暂时不修改型号，需要修改型号更改此参数
    params[@"PlaceOriginId"] = xinghaoID;
    
    //18-09-17
    if (self.ActivityIdType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.ActivityIdType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.ActivityIdType.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            [EasyShowTextView showSuccessText:@"修改成功"];
           
            
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
         [self GetshangpinList];
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
}

#pragma mark 获取凑单商品列表
- (void)GetCouDanList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/ShoppingCartPieceTogether";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"凑单商品 --- %@",object);
           
            self.tuijianArray = [YPShoppingCartPieceTogether mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
//            NSArray *arr = [NSArray arrayWithArray:self.listMarr.copy];
//            for (YPGetCommodityTypeTableList *listModel in arr) {
//                if (listModel.Data.count == 0) {
//                    [self.listMarr removeObject:listModel];
//                }
//            }
//
            if (self.dataArray.count!=0) {
                //一个cell刷新

                [self.collectionView reloadData];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.dataArray.count inSection:0];
                [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

@end
