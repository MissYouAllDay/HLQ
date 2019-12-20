//
//  LWSearchView.m
//  Hdoctor
//
//  Created by lanwon on 15/12/4.
//  Copyright © 2015年 lanwon. All rights reserved.
//

#import "SearchView.h"
#import "SearchTableViewCell.h"

@interface SearchView ()
<UITableViewDelegate,UITableViewDataSource,
UITextFieldDelegate,SearchTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray      *dataArray;
@end

@implementation SearchView
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 15, 15)];
    search.image = [UIImage imageNamed:@"search icon"];
    self.textField.leftView = search;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clearsOnBeginEditing =YES;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self  bringSubviewToFront:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navHeight.constant =NAVIGATION_BAR_HEIGHT;
}

- (IBAction)buttonClick:(id)sender {
    // 一般为返回上一页面
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"backHome" object:self];
}

- (void)reloadData {
    
    [self refreshDataArray:[_datasource searchView:self]];
}

- (void)refreshDataArray:(NSArray *)newArray {
    
    [self.dataArray removeAllObjects];
    self.dataArray = [NSMutableArray arrayWithArray:newArray];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - UITextField代理及自定义方法

// 点击
- (void)valueChanged:(UITextField *)sender {
    
    self.tableView.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didInputKeyWord:)]) {
        [self refreshDataArray:[self.delegate searchView:self didInputKeyWord:sender.text]];
    }
}

// 开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.tableView.hidden = NO;
    if (self.datasource && [self.datasource respondsToSelector:@selector(searchView:)]) {
        
        [self reloadData];
    }
}

// 点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.tableView.hidden = YES;
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:shouldReturnKeyWord:)]) {
        [self.delegate searchView:self shouldReturnKeyWord:textField.text];
    }
    return YES;
}


#pragma mark -
#pragma mark - UITableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.keyWordLb.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.hidden = YES;
    [self.textField resignFirstResponder];
    SearchTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *keyWord = cell.keyWordLb.text;
    self.textField.text = keyWord;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didSelectKeyWord:)]) {
        [self.delegate searchView:self didSelectKeyWord:keyWord];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 42;
}

#pragma mark -
#pragma mark - CustomTableViewCell代理

- (void)deleteButtonClick:(NSString *)keyword {
    
    [self.dataArray removeObject:keyword];
    [self.tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didDeleteKeyWord:)]) {
        [self.delegate searchView:self didDeleteKeyWord:keyword];
    }
}
@end
