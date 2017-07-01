//
//  LogViewController.m
//  IMServer
//
//  Created by Cain on 2017/7/1.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "LogViewController.h"
#import "SocketViewModel.h"

@interface LogViewController ()

@property (weak) IBOutlet NSTextView *logTextView;
@property (weak) IBOutlet NSTextField *contentTextField;

@property (nonatomic, strong) NSMutableArray *userListArray;

@property (nonatomic, strong) SocketViewModel *socketViewModel;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.socketViewModel createSocketWithClient];
    
    [self.contentTextField becomeFirstResponder];
}

- (IBAction)sendButtonAction:(NSButton *)sender {
    
    if (self.contentTextField.stringValue) {
        
        [self.socketViewModel sendMessageToClientWithString:self.contentTextField.stringValue];
        
        self.contentTextField.stringValue = @"";
        
        [self.contentTextField resignFirstResponder];
    }
}

- (SocketViewModel *)socketViewModel {
    
    if (!_socketViewModel) {
        
        __weak __typeof(&*self)weakSelf = self;
        
        _socketViewModel = [[SocketViewModel alloc] init];
        
        [_socketViewModel setMessageWithClientSocket:^(NSString *message){
            
            if (message) {
                
                weakSelf.logTextView.string = [NSString stringWithFormat:@"%@ /n %@ /n", weakSelf.logTextView.string, message];
            }
        }];
    }
    
    return _socketViewModel;
}

@end
