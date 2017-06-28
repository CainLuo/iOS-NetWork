//
//  SearchSessionDelegate.m
//  MusicTunes
//
//  Created by Cain on 2017/6/26.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchSessionDelegate.h"
#import "DownloadModel.h"
#import "SearchContentCell.h"
#import "AppDelegate.h"

@interface SearchSessionDelegate()

@property (nonatomic, strong) SearchController  *searchController;

@end

@implementation SearchSessionDelegate

- (instancetype)initSearchSessionDelegateWithController:(SearchController *)controller {
    
    self = [super init];
    
    if (self) {
        
        self.searchController = controller;
    }
    
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate
// 下载完成后的方法
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSURL *sourceURL = downloadTask.originalRequest.URL;
    
    if (sourceURL) {
        
        DownloadModel *downloadModel = self.searchController.downloadService.downloadDictionary[sourceURL];
        
        downloadModel.isDownload = NO;
        
        NSURL *destinationURL = [self.searchController.tableViewDelegate localFileWithPath:sourceURL];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSError *error;
        
        if ([fileManager removeItemAtURL:destinationURL error:&error]) {

            [fileManager removeItemAtURL:destinationURL error:&error];
        }
        
        if ([fileManager copyItemAtURL:location toURL:destinationURL error:&error]) {
            
            downloadModel.searchModel.downloaded = YES;
        } else {
            
            NSLog(@"Could not copy file to disk: %@", error.localizedDescription);
        }
        
        NSInteger index = downloadModel.searchModel.index;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.searchController.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]
                                                   withRowAnimation:UITableViewRowAnimationNone];
        });
    }
}

// 正在下载时调用的方法
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSURL *sourceURL = downloadTask.originalRequest.URL;
    
    if (sourceURL) {
        
        DownloadModel *downloadModel = self.searchController.downloadService.downloadDictionary[sourceURL];
        
        CGFloat percentage = (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
        
        downloadModel.progress = percentage;
        
        NSString *totalString = [NSByteCountFormatter stringFromByteCount:totalBytesExpectedToWrite
                                                               countStyle:NSByteCountFormatterCountStyleFile];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            SearchContentCell *contentCell = [self.searchController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:downloadModel.searchModel.index
                                                                                                                       inSection:0]];
            
            [contentCell updateDisplayWithProgress:downloadModel.progress
                                         totalSize:totalString];
        });
    }
}
#pragma mark - NSURLSessionDelegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.backgroundSessionCompletionHandler) {
        
        void (^completionHandler)() = [appDelegate backgroundSessionCompletionHandler];
        
        appDelegate.backgroundSessionCompletionHandler = nil;
        
        completionHandler();
    }
}

@end
