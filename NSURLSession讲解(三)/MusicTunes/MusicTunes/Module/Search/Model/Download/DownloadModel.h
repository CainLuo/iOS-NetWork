//
//  DownloadModel.h
//  MusicTunes
//
//  Created by Cain on 2017/6/26.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"

@interface DownloadModel : NSObject

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, assign) BOOL isDownload;

@property (nonatomic, strong) SearchModel *searchModel;

- (instancetype)initDownloadModelWtihSearchModel:(SearchModel *)searchModel;

@end
