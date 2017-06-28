//
//  SearchTableViewDelegate.m
//  MusicTunes
//
//  Created by Cain on 2017/6/23.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchTableViewDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SearchModel.h"

@interface SearchTableViewDelegate()

@property (nonatomic, strong, readwrite) SearchViewModel * viewModel;

@end

@implementation SearchTableViewDelegate

- (instancetype)initSearchTableViewDelegateWithViewModel:(SearchViewModel *)viewModel {
    
    self = [super init];
    
    if (self) {
        
        self.viewModel = viewModel;
    }
    
    return self;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchModel *searchModel = self.viewModel.dataSource[indexPath.row];
    
    if (searchModel.downloaded) {
        
        [self playDownloadWithModel:searchModel];
    }
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

- (void)playDownloadWithModel:(SearchModel *)model {
    
    AVPlayerViewController *playerController = [[AVPlayerViewController alloc] init];
    
    // 这两个属性是在iOS 11之后才有的
    playerController.entersFullScreenWhenPlaybackBegins = YES;
    playerController.exitsFullScreenWhenPlaybackEnds = YES;
    
    [self.viewModel.searchController presentViewController:playerController
                                                  animated:YES
                                                completion:nil];
    
    NSURL *playerURL = [self localFileWithPath:model.previewURL];
    
    AVPlayer *player = [AVPlayer playerWithURL:playerURL];
    
    playerController.player = player;
    
    [player play];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen cl_fitScreen:124];
}

- (NSURL *)localFileWithPath:(NSURL *)url {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *documentsPath = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                inDomains:NSUserDomainMask] firstObject];
    
    return [documentsPath URLByAppendingPathComponent:url.lastPathComponent];
}

@end
