//
//  TableViewController.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "TableViewController.h"
#import "HomeTableViewDelegate.h"
#import "HomeTableViewDataSource.h"
#import "JCViewModel.h"
#import "JCTableViewCell.h"

@interface TableViewController ()

@property (nonatomic, strong) HomeTableViewDelegate *delegate;
@property (nonatomic, strong) HomeTableViewDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray<JCModel *> *totalSourceMArray;
@property (nonatomic, strong) JCViewModel *viewModel;

@end

@implementation TableViewController

#pragma mark - Init

- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupView];
}

#pragma mark - Private Methods

/**
 *  @author chenjiangchuan, 17-02-13 14:02:03
 *
 *  初始化界面
 */
- (void)setupView {
    
    // 注册cell
    [self.tableView registerClass:[JCTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.delegate = [[HomeTableViewDelegate alloc] init];
    self.dataSource = [[HomeTableViewDataSource alloc] init];
    self.tableView.delegate = self.delegate;
    self.tableView.dataSource = self.dataSource;
    
    // 下拉刷新
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    }];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  @author chenjiangchuan, 17-02-13 14:02:53
 *
 *  下拉刷新
 */
- (void)headerRefreshAction {
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel headerRefreshRequestWithCallBack:^(NSArray<JCModel *> *array) {
        __strong typeof(self) strongSelf = weakSelf;
        
        strongSelf.totalSourceMArray = (NSMutableArray *)array;
        strongSelf.dataSource.array = strongSelf.totalSourceMArray;
        strongSelf.delegate.array = strongSelf.totalSourceMArray;
        
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

/**
 *  @author chenjiangchuan, 17-02-13 14:02:08
 *
 *  上拉刷新
 */
- (void)footerRefreshAction {
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel footerRefreshRequestWithCallback:^(NSArray<JCModel *> *array) {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.totalSourceMArray addObjectsFromArray:array];
        
        strongSelf.dataSource.array = strongSelf.totalSourceMArray;
        strongSelf.delegate.array = strongSelf.totalSourceMArray;
        
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];

    }];
}

#pragma mark - Lazy

- (NSMutableArray<JCModel *> *)totalSourceMArray {
    
    if (_totalSourceMArray == nil) {
        _totalSourceMArray = [NSMutableArray array];
    }
    return _totalSourceMArray;
}

- (JCViewModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[JCViewModel alloc] init];
    }
    return _viewModel;
}

@end
