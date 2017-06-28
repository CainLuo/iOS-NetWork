//
//  SearchController.h
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarDelegate.h"
#import "SearchTableViewDelegate.h"
#import "SearchTableViewDataSource.h"
#import "SearchViewModel.h"
#import "DownloadService.h"
#import "QueryService.h"

@class SearchTableViewDelegate, SearchViewModel, SearchTableViewDataSource, SearchBarDelegate;
@interface SearchController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) UISearchBar *searchBar;

@property (nonatomic, strong, readonly) SearchTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong, readonly) SearchBarDelegate         *searchBarDelegate;
@property (nonatomic, strong, readonly) SearchViewModel           *searchViewModel;
@property (nonatomic, strong, readonly) SearchTableViewDelegate   *tableViewDelegate;

@property (nonatomic, strong, readonly) DownloadService *downloadService;
@property (nonatomic, strong, readonly) QueryService *queryService;

@end
