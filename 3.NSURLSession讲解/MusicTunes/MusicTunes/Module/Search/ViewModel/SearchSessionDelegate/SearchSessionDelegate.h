//
//  SearchSessionDelegate.h
//  MusicTunes
//
//  Created by Cain on 2017/6/26.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchController.h"

@interface SearchSessionDelegate : NSObject <NSURLSessionDownloadDelegate, NSURLSessionDelegate>

- (instancetype)initSearchSessionDelegateWithController:(SearchController *)controller;

@end
