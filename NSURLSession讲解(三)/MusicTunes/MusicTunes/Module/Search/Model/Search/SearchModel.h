//
//  SearchModel.h
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, strong) NSURL *previewURL;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL downloaded;

- (instancetype)initSearchModelWithSongName:(NSString *)songName
                                 artistName:(NSString *)artistName
                                 previewURL:(NSURL *)previewURL
                                      index:(NSInteger)index;

@end
