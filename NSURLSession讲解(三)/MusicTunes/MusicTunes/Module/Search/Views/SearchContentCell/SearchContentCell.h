//
//  SearchContentCell.h
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
#import "DownloadModel.h"

@class SearchContentCell;

@protocol SearchContentCellDelegate <NSObject>

- (void)pauseTapped:(SearchContentCell *)cell;
- (void)resumeTapped:(SearchContentCell *)cell;
- (void)cancelTapped:(SearchContentCell *)cell;
- (void)downloadTapped:(SearchContentCell *)cell;

@end

@interface SearchContentCell : UITableViewCell

@property (nonatomic, weak) id<SearchContentCellDelegate> searchContentCellDelegate;

@property (nonatomic, strong, readonly) UILabel *progressLabel;

@property (nonatomic, strong, readonly) UIProgressView *progressView;

@property (nonatomic, strong, readonly) UIButton *pauseButton;
@property (nonatomic, strong, readonly) UIButton *cancelButton;
@property (nonatomic, strong, readonly) UIButton *downloadButton;

- (void)configuraCellWithModel:(SearchModel *)model
                      download:(DownloadModel *)download;

- (void)updateDisplayWithProgress:(CGFloat)progress
                        totalSize:(NSString *)totalSize;

@end
