//
//  DownloadService.m
//  MusicTunes
//
//  Created by Cain on 2017/6/25.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "DownloadService.h"
#import "SearchSessionDelegate.h"

@interface DownloadService()

@property (nonatomic, strong) NSURLSession *downloadSession;

@end

@implementation DownloadService

- (instancetype)initWithSession:(NSURLSession *)session {
    
    self = [super init];
    
    if (self) {
        
        self.downloadSession = session;
    }
    
    return self;
}

- (void)startDownloadWithModel:(SearchModel *)model {
    
    DownloadModel *downloadModel = [[DownloadModel alloc] initDownloadModelWtihSearchModel:model];
    
    downloadModel.downloadTask = [self.downloadSession downloadTaskWithURL:model.previewURL];
    
    [downloadModel.downloadTask resume];
    
    downloadModel.isDownload = YES;
    
    self.downloadDictionary = @{downloadModel.searchModel.previewURL : downloadModel};
}

- (void)pauseDownloadWithModel:(SearchModel *)model {
    
    DownloadModel *downloadModel = self.downloadDictionary[model.previewURL];
    
    if (!downloadModel) {
        return;
    }
    
    if (downloadModel.isDownload) {
        
        [downloadModel.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            
            downloadModel.data = resumeData;
        }];
        
        downloadModel.isDownload = NO;
    }
}

- (void)cancelDownloadWithModel:(SearchModel *)model {
    
    DownloadModel *downloadModel = self.downloadDictionary[model.previewURL];
    
    if (downloadModel) {
        
        [downloadModel.downloadTask cancel];
        
        self.downloadDictionary = @{[NSString stringWithFormat:@"%@", model.previewURL] : [NSNull null]};
    }
}

- (void)resumeDownloadWithModel:(SearchModel *)model {
    
    DownloadModel *downloadModel = self.downloadDictionary[model.previewURL];
    
    if (!downloadModel) {
        return;
    }
    
    if (downloadModel.data) {
        
        downloadModel.downloadTask = [self.downloadSession downloadTaskWithResumeData:downloadModel.data];
    } else {
        downloadModel.downloadTask = [self.downloadSession downloadTaskWithURL:downloadModel.searchModel.previewURL];
    }
    
    [downloadModel.downloadTask resume];
    
    downloadModel.isDownload = YES;
}

@end
