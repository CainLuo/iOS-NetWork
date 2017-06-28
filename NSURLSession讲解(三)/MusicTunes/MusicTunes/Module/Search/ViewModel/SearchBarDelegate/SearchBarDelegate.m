//
//  SearchBarDelegate.m
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchBarDelegate.h"
#import "QueryService.h"

@interface SearchBarDelegate() 

@property (nonatomic, strong, readwrite) SearchController * searchController;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation SearchBarDelegate

- (instancetype)initSearchBarDelegateWithController:(SearchController *)controller {
    
    self = [super init];
    
    if (self) {
        
        self.searchController = controller;
    }
    
    return self;
}

#pragma mark - SearchBar代理方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBarDismissKeyBoard];
    
    if (!searchBar.text) {
        return;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    QueryService *queryService = [[QueryService alloc] init];
    
    [queryService getSearchResultsWithSearchTerm:searchBar.text
                                      completion:^(NSMutableArray *array, NSString *errMessage) {
                                          
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                          
                                          if (errMessage) {
                                              
                                              NSLog(@"Search Error: %@", errMessage);
                                              
                                              return;
                                          }
                                          
                                          if (array) {
                                              
                                              [self.searchController.searchViewModel.dataSource addObjectsFromArray:array];
                                              [self.searchController.tableView reloadData];
                                              
                                              [self.searchController.tableView setContentOffset:CGPointZero
                                                                                       animated:NO];
                                          }
                                      }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.searchController.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [self.searchController.view removeGestureRecognizer:self.tapGestureRecognizer];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
}

#pragma mark - 取消UISearchBar响应者, 也就是会收缩键盘
- (void)searchBarDismissKeyBoard {
    
    [self.searchController.searchBar resignFirstResponder];
}

#pragma mark - 添加一个轻拍的手势
- (UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (!_tapGestureRecognizer) {
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(searchBarDismissKeyBoard)];
    }
    
    return _tapGestureRecognizer;
}

@end
