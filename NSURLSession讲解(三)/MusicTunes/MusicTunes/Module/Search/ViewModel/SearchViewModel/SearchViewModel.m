//
//  SearchViewModel.m
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchViewModel.h"

@interface SearchViewModel ()

@property (nonatomic, strong, readwrite) SearchController *searchController;

@end

@implementation SearchViewModel

- (instancetype)initSearchViewModelWithController:(SearchController *)controller {
    
    self = [super init];
    
    if (self) {
        
        self.searchController = controller;
    }
    
    return self;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

@end
