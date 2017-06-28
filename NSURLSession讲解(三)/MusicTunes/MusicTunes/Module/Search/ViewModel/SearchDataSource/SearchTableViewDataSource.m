//
//  SearchTableViewDataSource.m
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchTableViewDataSource.h"
#import "SearchContentCell.h"
#import "SearchModel.h"

@interface SearchTableViewDataSource () <SearchContentCellDelegate>

@property (nonatomic, strong, readwrite) SearchViewModel *viewModel;

@end

@implementation SearchTableViewDataSource

- (instancetype)initSearchDataSourceWithViewModel:(SearchViewModel *)viewModel {
    
    self = [super init];
    
    if (self) {
        
        self.viewModel = viewModel;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchContentCell"];
    
    if (!cell) {
        cell = [[SearchContentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:@"SearchContentCell"];
        
        cell.searchContentCellDelegate = self;
    }
    
    SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
    
    [cell configuraCellWithModel:searchModel
                        download:self.viewModel.searchController.downloadService.downloadDictionary[searchModel.previewURL]];
    
    return cell;    
}

#pragma mark - SearchContentCell代理方法
- (void)pauseTapped:(SearchContentCell *)cell {
    
    NSIndexPath *indexPath = [self.viewModel.searchController.tableView indexPathForCell:cell];
    
    if (indexPath) {
        
        SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
        
        [self.viewModel.searchController.downloadService pauseDownloadWithModel:searchModel];
        
        [self reloadTableViewCellDataWithIndexPath:indexPath.row];
    }
}

- (void)resumeTapped:(SearchContentCell *)cell {
    
    NSIndexPath *indexPath = [self.viewModel.searchController.tableView indexPathForCell:cell];
    
    if (indexPath) {
        
        SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
        
        [self.viewModel.searchController.downloadService resumeDownloadWithModel:searchModel];
        
        [self reloadTableViewCellDataWithIndexPath:indexPath.row];
    }
}

- (void)cancelTapped:(SearchContentCell *)cell {
    
    NSIndexPath *indexPath = [self.viewModel.searchController.tableView indexPathForCell:cell];
    
    if (indexPath) {
        
        SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
        
        [self.viewModel.searchController.downloadService cancelDownloadWithModel:searchModel];
        
        [self reloadTableViewCellDataWithIndexPath:indexPath.row];
    }
}

- (void)downloadTapped:(SearchContentCell *)cell {
    
    NSIndexPath *indexPath = [self.viewModel.searchController.tableView indexPathForCell:cell];
    
    if (indexPath) {
        
        SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
        
        [self.viewModel.searchController.downloadService startDownloadWithModel:searchModel];
        
        [self reloadTableViewCellDataWithIndexPath:indexPath.row];
    }
}

- (void)reloadTableViewCellDataWithIndexPath:(NSInteger)row {
    
    [self.viewModel.searchController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]]
                                             withRowAnimation:UITableViewRowAnimationNone];
}

@end
