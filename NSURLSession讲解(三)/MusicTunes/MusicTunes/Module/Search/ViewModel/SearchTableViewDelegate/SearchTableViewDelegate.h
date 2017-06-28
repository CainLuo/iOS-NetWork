//
//  SearchTableViewDelegate.h
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchViewModel.h"

@class SearchViewModel;
@interface SearchTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, strong, readonly) SearchViewModel *viewModel;

- (instancetype)initSearchTableViewDelegateWithViewModel:(SearchViewModel *)viewModel;

- (NSURL *)localFileWithPath:(NSURL *)url;

@end
