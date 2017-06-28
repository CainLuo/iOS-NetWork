//
//  DownloadService.h
//  MusicTunes
//
//  Created by Cain on 2017/6/25.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
#import "DownloadModel.h"

@interface DownloadService : NSObject

@property (nonatomic, strong) NSDictionary *downloadDictionary;

- (instancetype)initWithSession:(NSURLSession *)session;
    
/**
 开始下载
 
 @param model SearchModel
 */
- (void)startDownloadWithModel:(SearchModel *)model;

/**
 暂停下载
 
 @param model SearchModel
 */
- (void)pauseDownloadWithModel:(SearchModel *)model;

/**
 取消下载
 
 @param model SearchModel
 */
- (void)cancelDownloadWithModel:(SearchModel *)model;

/**
 恢复下载
 
 @param model SearchModel
 */
- (void)resumeDownloadWithModel:(SearchModel *)model;

@end
