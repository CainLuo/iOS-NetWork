//
//  DownloadModel.m
//  MusicTunes
//
//  Created by Cain on 2017/6/26.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel

- (instancetype)initDownloadModelWtihSearchModel:(SearchModel *)searchModel {
    
    self = [super init];
    
    if (self) {
        
        self.searchModel = searchModel;
        self.progress = 0.0;
        self.isDownload = NO;
    }
    
    return self;
}
@end
