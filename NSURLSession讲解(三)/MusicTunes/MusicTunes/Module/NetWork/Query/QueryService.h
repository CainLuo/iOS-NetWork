//
//  QueryService.h
//  MusicTunes
//
//  Created by Cain on 2017/6/25.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryService : NSObject

- (void)getSearchResultsWithSearchTerm:(NSString *)searchTerm
                            completion:(void (^)(NSMutableArray *array, NSString *errMessage))completion;

@end
