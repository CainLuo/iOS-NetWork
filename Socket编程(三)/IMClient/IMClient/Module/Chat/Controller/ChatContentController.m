//
//  ChatContentController.m
//  IMClient
//
//  Created by Cain on 2017/6/30.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "ChatContentController.h"
#import "ChatContentViewModel.h"
#import "ChatCotentView.h"

@interface ChatContentController ()

@property (nonatomic, strong) ChatContentViewModel  *chatContentViewModel;

@property (nonatomic, strong) ChatCotentView *chatContentView;

@end

@implementation ChatContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.opaque = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addeConstraintsWithSuperView];
    
    [self.chatContentViewModel createSocketConnect];
}

- (ChatContentViewModel *)chatContentViewModel {
    
    if (!_chatContentViewModel) {
        
        __weak __typeof(&*self)weakSelf = self;
        
        _chatContentViewModel = [[ChatContentViewModel alloc] init];
        
        [_chatContentViewModel setChatContentSendMessage:^(NSString *message){
            
            [weakSelf.chatContentView changeLogTextViewWithString:message];
        }];
    }
    
    return _chatContentViewModel;
}

- (ChatCotentView *)chatContentView {
    
    if (!_chatContentView) {
        
        __weak __typeof(&*self)weakSelf = self;
        
        _chatContentView = [[ChatCotentView alloc] init];
        
        [_chatContentView setChatContentSendMessage:^(NSString *message){
            
            [weakSelf.chatContentViewModel sendMessageWithString:message];
        }];
    }
    
    return _chatContentView;
}

- (void)addeConstraintsWithSuperView {
    
    [self.view addSubview:self.chatContentView];
    
    [self.chatContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
}

@end
