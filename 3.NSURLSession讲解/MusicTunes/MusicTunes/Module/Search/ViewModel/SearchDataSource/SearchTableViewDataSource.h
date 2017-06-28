//
//  SearchTableViewDataSource.h
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchViewModel.h"

@class SearchViewModel;
@interface SearchTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) SearchViewModel *viewModel;
@property (nonatomic, strong, readonly) NSArray *cellArray;

- (instancetype)initSearchDataSourceWithViewModel:(SearchViewModel *)viewModel;

@end
