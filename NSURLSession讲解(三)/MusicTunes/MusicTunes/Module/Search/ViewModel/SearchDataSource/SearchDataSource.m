//
//  SearchDataSource.m
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchTableViewDataSource.h"
#import "SearchContentCell.h"

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
    
    return cell;    
}

#pragma mark - SearchContentCell代理方法
- (void)pauseTapped:(SearchContentCell *)cell {
    
}

- (void)resumeTapped:(SearchContentCell *)cell {
    
}

- (void)cancelTapped:(SearchContentCell *)cell {
    
}

- (void)downloadTapped:(SearchContentCell *)cell {
    
}

@end
