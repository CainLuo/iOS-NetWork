//
//  SearchBarDelegate.h
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchController.h"

@class SearchController;
@interface SearchBarDelegate : NSObject <UISearchBarDelegate>

@property (nonatomic, strong, readonly) SearchController * searchController;

- (instancetype)initSearchBarDelegateWithController:(SearchController *)controller;

@end
