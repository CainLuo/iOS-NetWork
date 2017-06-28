//
//  SearchController.m
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchController.h"
#import <AVKit/AVKit.h>
#import "SearchSessionDelegate.h"

@interface SearchController ()

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UISearchBar *searchBar;

@property (nonatomic, strong, readwrite) SearchTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong, readwrite) SearchBarDelegate         *searchBarDelegate;
@property (nonatomic, strong, readwrite) SearchViewModel           *searchViewModel;
@property (nonatomic, strong, readwrite) SearchTableViewDelegate   *tableViewDelegate;

@property (nonatomic, strong, readwrite) DownloadService *downloadService;
@property (nonatomic, strong, readwrite) QueryService *queryService;

@property (nonatomic, strong) NSURLSession *downloadSession;

@property (nonatomic, strong) SearchSessionDelegate *searchSessionDelegate;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    
    [self mt_addConstraintsWithSuperView];
}

- (DownloadService *)downloadService {
    
    if (!_downloadService) {
        
        _downloadService = [[DownloadService alloc] initWithSession:self.downloadSession];
    }
    
    return _downloadService;
}

- (QueryService *)queryService {
    
    if (!_queryService) {
        
        _queryService = [[QueryService alloc] init];
    }
    
    return _queryService;
}

#pragma mark - 添加约束
- (void)mt_addConstraintsWithSuperView {
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(20);
        (void)make.left.right;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.searchBar.mas_bottom);
        (void)make.left.right.bottom;
    }];
}

#pragma mark - Table View
- (UITableView *)tableView {
  
    if (!_tableView) {
        
        _tableView                     = [[UITableView alloc] init];
        _tableView.delegate            = self.tableViewDelegate;
        _tableView.dataSource          = self.tableViewDataSource;
        _tableView.backgroundColor     = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    
    return _tableView;
}

- (SearchTableViewDelegate *)tableViewDelegate {
    
    if (!_tableViewDelegate) {
        
        _tableViewDelegate = [[SearchTableViewDelegate alloc] initSearchTableViewDelegateWithViewModel:self.searchViewModel];
    }
    
    return _tableViewDelegate;
}

- (SearchTableViewDataSource *)tableViewDataSource {
    
    if (!_tableViewDataSource) {
        
        _tableViewDataSource = [[SearchTableViewDataSource alloc] initSearchDataSourceWithViewModel:self.searchViewModel];
    }
    
    return _tableViewDataSource;
}

- (SearchViewModel *)searchViewModel {
    
    if (!_searchViewModel) {
        
        _searchViewModel = [[SearchViewModel alloc] initSearchViewModelWithController:self];
    }
    
    return _searchViewModel;
}

#pragma mark - Search Bar
- (UISearchBar *)searchBar {
    
    if (!_searchBar) {
        
        _searchBar                = [[UISearchBar alloc] init];
        _searchBar.delegate       = self.searchBarDelegate;
        _searchBar.placeholder    = @"输入歌手或者是歌名";
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
    }
    
    return _searchBar;
}

- (SearchBarDelegate *)searchBarDelegate {
    
    if (!_searchBarDelegate) {
        
        _searchBarDelegate = [[SearchBarDelegate alloc] initSearchBarDelegateWithController:self];
    }
    
    return _searchBarDelegate;
}

- (NSURLSession *)downloadSession {
    
    if (!_downloadSession) {
        
        NSURLSessionConfiguration *urlSessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"backgroundSessionConfiguration"];
        
        _downloadSession = [NSURLSession sessionWithConfiguration:urlSessionConfiguration
                                                         delegate:self.searchSessionDelegate
                                                    delegateQueue:nil];
    }
    
    return _downloadSession;
}

- (SearchSessionDelegate *)searchSessionDelegate {
    
    if (!_searchSessionDelegate) {
        
        _searchSessionDelegate = [[SearchSessionDelegate alloc] initSearchSessionDelegateWithController:self];
    }
    
    return _searchSessionDelegate;
}

@end
