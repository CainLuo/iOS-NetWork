//
//  SearchViewModel.h
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchController.h"
#import "DownloadModel.h"

@class SearchController;
@interface SearchViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong, readonly) SearchController *searchController;

- (instancetype)initSearchViewModelWithController:(SearchController *)controller;

@end
