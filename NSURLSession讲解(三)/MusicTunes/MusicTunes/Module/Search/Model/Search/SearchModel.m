//
//  SearchModel.m
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (instancetype)initSearchModelWithSongName:(NSString *)songName
                                 artistName:(NSString *)artistName
                                 previewURL:(NSURL *)previewURL
                                      index:(NSInteger)index {
    self = [super init];
    
    if (self) {
        
        self.songName   = songName;
        self.artistName = artistName;
        self.previewURL = previewURL;
        self.index      = index;
    }
    
    return self;
}

@end
