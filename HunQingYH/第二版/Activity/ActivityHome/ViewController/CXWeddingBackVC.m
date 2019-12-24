//
//  CXWeddingBackVC.m
//  HunQingYH
//
//  Created by canxue on 2019/11/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXWeddingBackVC.h"
#import "CXWeddingBackItem.h"
#import "SegMentView.h"
@interface CXWeddingBackVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView  *collectionView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) SegMentView  *segmentView;    // <#这里是个注释哦～#>
@end

@implementation CXWeddingBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.collectionView];
}

// MARK: - Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CXWeddingBackItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXWeddingBackItem" forIndexPath:indexPath];
    return item;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) {

        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
        [view addSubview:self.segmentView];
        return view;
    }
    return nil;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake((ScreenWidth - Line375(45))/2, Line375(240));
        flow.sectionInset = UIEdgeInsetsMake(Line375(15), Line375(15), Line375(15), Line375(15));
        flow.minimumLineSpacing = Line375(10);
        flow.minimumInteritemSpacing = Line375(10);
        flow.headerReferenceSize = CGSizeMake(ScreenWidth, Line375(40));
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor yellowColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"CXWeddingBackItem" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CXWeddingBackItem"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    }
    return _collectionView;
}

- (SegMentView *)segmentView {
    
    if (!_segmentView) {
        _segmentView = [[SegMentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(40))];
        _segmentView.dataArr = @[@"彩妆专区",@"护肤专区",@"美体专区",@"厨具专区",@"箱包专区"];
        [_segmentView makeShow];
    }
    return _segmentView;
}
- (UIView *)listView {
    
    return self.view;
}


@end
