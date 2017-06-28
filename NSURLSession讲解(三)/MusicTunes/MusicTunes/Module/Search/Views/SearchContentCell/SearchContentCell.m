//
//  SearchContentCell.m
//  MusicTunes
//
//  Created by Cain on 2017/6/21.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SearchContentCell.h"

@interface SearchContentCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong, readwrite) UILabel *progressLabel;

@property (nonatomic, strong, readwrite) UIProgressView *progressView;

@property (nonatomic, strong, readwrite) UIButton *pauseButton;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;
@property (nonatomic, strong, readwrite) UIButton *downloadButton;

@end

@implementation SearchContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self mt_addConstraintsWithSuperView];
    }
    
    return self;
}

#pragma mark - 配置Cell的内容
- (void)configuraCellWithModel:(SearchModel *)model
                      download:(DownloadModel *)download {
    
    if (model) {
        
        self.titleLabel.text = model.songName;
        self.artistLabel.text = model.artistName;
        
        BOOL showDownloadControls = NO;
        
        if (download.isDownload) {
            
            showDownloadControls = YES;
            
            NSString *title = download.isDownload ? @"暂停" : @"恢复";
            
            [self.pauseButton setTitle:title
                              forState:UIControlStateNormal];
            
            self.progressLabel.text = download.isDownload ? @"下载中..." : @"暂停下载";
        }
        
        self.pauseButton.hidden   = !showDownloadControls;
        self.cancelButton.hidden  = !showDownloadControls;
        self.progressView.hidden  = !showDownloadControls;
        self.progressLabel.hidden = !showDownloadControls;
        
        self.selectionStyle = model.downloaded ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
        
        self.downloadButton.hidden = model.downloaded || showDownloadControls;
    }
}

#pragma mark - 更新下载进度和下载详细
- (void)updateDisplayWithProgress:(CGFloat)progress
                        totalSize:(NSString *)totalSize {
    
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%% of %@", progress * 100, totalSize];
}

#pragma mark - 暂停或继续的点击事件
- (void)pauseButtonAction:(UIButton *)sender {
    
    if (self.searchContentCellDelegate) {
        
        if ([sender.titleLabel.text isEqualToString:@"暂停"]) {
            [self.searchContentCellDelegate pauseTapped:self];
        } else {
            [self.searchContentCellDelegate resumeTapped:self];
        }
    }
}

#pragma mark - 取消下载的点击事件
- (void)cancelButtonAction:(UIButton *)sender {
    
    if (self.searchContentCellDelegate) {
        [self.searchContentCellDelegate cancelTapped:self];
    }
}

#pragma mark - 下载的点击事件
- (void)downloadButtonAction:(UIButton *)sender {
    
    if (self.searchContentCellDelegate) {
        [self.searchContentCellDelegate downloadTapped:self];
    }
}

#pragma mark - Labels
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel           = [[UILabel alloc] init];
        _titleLabel.text      = @"歌名";
        _titleLabel.font      = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:32]];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.tintColor = [UIColor cyanColor];
    }
    
    return _titleLabel;
}

- (UILabel *)artistLabel {
    
    if (!_artistLabel) {
        
        _artistLabel           = [[UILabel alloc] init];
        _artistLabel.text      = @"歌手";
        _artistLabel.font      = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:28]];
        _artistLabel.textColor = [UIColor cl_colorWithHex:0x666666];
        _artistLabel.tintColor = [UIColor cyanColor];
    }
    
    return _artistLabel;
}

- (UILabel *)progressLabel {
    
    if (!_progressLabel) {
        
        _progressLabel           = [[UILabel alloc] init];
        _progressLabel.text      = @"100% of 1.35MB";
        _progressLabel.font      = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:22]];
        _progressLabel.hidden    = YES;
        _progressLabel.textColor = [UIColor cl_colorWithHex:0xAAAAAA];
        _progressLabel.tintColor = [UIColor cyanColor];
    }
    
    return _progressLabel;
}

#pragma mark - ProgressView
- (UIProgressView *)progressView {
    
    if (!_progressView) {
        
        _progressView           = [[UIProgressView alloc] init];
        _progressView.hidden    = YES;
        _progressView.tintColor = [UIColor blueColor];
        _progressView.progress  = 0;
    }
    
    return _progressView;
}

#pragma mark - Buttons
- (UIButton *)pauseButton {
    
    if (!_pauseButton) {
        
        _pauseButton                 = [[UIButton alloc] init];
        _pauseButton.hidden          = YES;
        _pauseButton.titleLabel.font = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:30]];
        
        [_pauseButton setTitle:@"继续"
                      forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor cyanColor]
                           forState:UIControlStateNormal];
        [_pauseButton setTitleShadowColor:[UIColor cl_colorWithHex:0x7f7f7f]
                                 forState:UIControlStateNormal];
        [_pauseButton setTintColor:[UIColor cyanColor]];
        
        [_pauseButton addTarget:self
                         action:@selector(pauseButtonAction:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _pauseButton;
}

- (UIButton *)cancelButton {
    
    if (!_cancelButton) {
        
        _cancelButton                 = [[UIButton alloc] init];
        _cancelButton.hidden          = YES;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:30]];
        
        [_cancelButton setTitle:@"取消"
                       forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor cyanColor]
                            forState:UIControlStateNormal];
        [_cancelButton setTitleShadowColor:[UIColor cl_colorWithHex:0x7f7f7f]
                                  forState:UIControlStateNormal];
        [_cancelButton setTintColor:[UIColor cyanColor]];
        
        [_cancelButton addTarget:self
                          action:@selector(cancelButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (UIButton *)downloadButton {
    
    if (!_downloadButton) {
        
        _downloadButton                 = [[UIButton alloc] init];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:[UIScreen cl_fitScreen:30]];
        
        [_downloadButton setTitle:@"开始下载"
                         forState:UIControlStateNormal];
        [_downloadButton setTitleColor:[UIColor cyanColor]
                              forState:UIControlStateNormal];
        [_downloadButton setTitleShadowColor:[UIColor cl_colorWithHex:0x7f7f7f]
                                    forState:UIControlStateNormal];
        [_downloadButton setTintColor:[UIColor cyanColor]];
        
        [_downloadButton addTarget:self
                            action:@selector(downloadButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    }

    return _downloadButton;
}

- (void)mt_addConstraintsWithSuperView {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.artistLabel];
    [self addSubview:self.progressLabel];
    
    [self addSubview:self.progressView];
    
    [self addSubview:self.pauseButton];
    [self addSubview:self.cancelButton];
    [self addSubview:self.downloadButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset([UIScreen cl_fitScreen:16]);
        make.left.equalTo(self).offset([UIScreen cl_fitScreen:28]);
        make.right.equalTo(self).offset(-[UIScreen cl_fitScreen:204]);
    }];
    
    [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset([UIScreen cl_fitScreen:2]);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.artistLabel.mas_bottom).offset([UIScreen cl_fitScreen:12]);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-[UIScreen cl_fitScreen:18]);
        make.centerY.equalTo(self.progressView);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset([UIScreen cl_fitScreen:18]);
        make.right.equalTo(self).offset(-[UIScreen cl_fitScreen:16]);
        make.height.mas_equalTo([UIScreen cl_fitScreen:60]);
    }];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.centerY.top.equalTo(self.cancelButton);
        make.right.equalTo(self.cancelButton.mas_left).offset(-[UIScreen cl_fitScreen:16]);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.cancelButton);
        make.top.equalTo(self).offset([UIScreen cl_fitScreen:18]);
        make.right.equalTo(self).offset(-[UIScreen cl_fitScreen:34]);
    }];
}

@end
