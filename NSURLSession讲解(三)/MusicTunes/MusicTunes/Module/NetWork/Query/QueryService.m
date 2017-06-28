//
//  QueryService.m
//  MusicTunes
//
//  Created by Cain on 2017/6/25.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "QueryService.h"
#import "SearchModel.h"

@interface QueryService()

@property (nonatomic, strong, readwrite) NSMutableArray *songArray;
@property (nonatomic, strong) NSDictionary *JSONDictionary;

@property (nonatomic, copy) NSString *errMessage;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation QueryService

- (void)getSearchResultsWithSearchTerm:(NSString *)searchTerm
                            completion:(void (^)(NSMutableArray *array, NSString *errMessage))completion {
    
    [self.dataTask cancel];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:@"https://itunes.apple.com/search"];
    
    if (urlComponents) {
        
        urlComponents.query = [NSString stringWithFormat:@"media=music&entity=song&term=%@", searchTerm];
        
        NSURL *url = urlComponents.URL;
        
        if (url) {
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            self.dataTask = [session dataTaskWithURL:url
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                       
                                       if (error) {
                                           
                                           self.errMessage = [NSString stringWithFormat:@"DataTask error: %@ \n", error.localizedDescription];
                                           self.dataTask = nil;
                                           
                                           return;
                                       }
                                       
                                       if (data) {
                                           
                                           NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
                                           
                                           if (urlResponse.statusCode == 200) {
                                               
                                               [self updateSearchResultsWithData:data];
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                   completion(self.songArray, self.errMessage);
                                               });
                                           }
                                       }
                                   }];
        }
        [self.dataTask resume];
    }
}

- (void)updateSearchResultsWithData:(NSData *)data {
    
    self.JSONDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    
    if (!self.JSONDictionary) {
        
        NSError *error;
        
        self.errMessage = [NSString stringWithFormat:@"JSONSerialization error: %@", error.localizedDescription];
        
        return;
    }
    
    if (!self.JSONDictionary[@"results"]) {
        
        self.errMessage = [NSString stringWithFormat:@"Dictionary does not contain results key\n"];
        
        return;
    }
    
    NSArray *array = self.JSONDictionary[@"results"];
    NSInteger index = 0;
    
    for (NSDictionary *trackDictionary in array) {
        
        if (!trackDictionary) {
            
            self.errMessage = [NSString stringWithFormat:@"Problem parsing trackDictionary\n"];
            
            return;
        }
        
        NSString *previewURLString = trackDictionary[@"previewUrl"];
        NSURL *previewURL          = [NSURL URLWithString:previewURLString];
        NSString *songName         = trackDictionary[@"trackName"];
        NSString *artistName       = trackDictionary[@"artistName"];
        
        SearchModel *searchModel = [[SearchModel alloc] initSearchModelWithSongName:songName
                                                                         artistName:artistName
                                                                         previewURL:previewURL
                                                                              index:index];
        index += 1;
        
        [self.songArray addObject:searchModel];
    }
}

- (NSMutableArray *)songArray {
    
    if (!_songArray) {
        
        _songArray = [NSMutableArray array];
    }
    
    return _songArray;
}

@end
