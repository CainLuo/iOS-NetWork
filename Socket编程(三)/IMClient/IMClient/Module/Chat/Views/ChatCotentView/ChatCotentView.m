//
//  ChatCotentView.m
//  IMClient
//
//  Created by Cain on 2017/7/1.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "ChatCotentView.h"

@interface ChatCotentView ()

@property (nonatomic, strong) UITextField *sendTextField;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UITextView *contentTextView;

@end

@implementation ChatCotentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.opaque = YES;
        
        self.backgroundColor = [UIColor colorWithRed:222.0 / 250.0
                                               green:224.0 / 250.0
                                                blue:227.0 / 250.0
                                               alpha:1.0];
        
        [self addConstraintsWithSuperView];
    }
    
    return self;
}

- (void)changeLogTextViewWithString:(NSString *)string {
    
    self.contentTextView.text = [NSString stringWithFormat:@"%@\n %@\n", self.contentTextView.text, string];
}

- (UITextField *)sendTextField {
    
    if (!_sendTextField) {
        
        _sendTextField = [[UITextField alloc] init];
        
        _sendTextField.textColor   = [UIColor blackColor];
        _sendTextField.placeholder = @"输入发送的内容";
        _sendTextField.borderStyle = UITextBorderStyleLine;
    }
    
    return _sendTextField;
}

- (UIButton *)sendButton {
    
    if (!_sendButton) {
        
        _sendButton = [[UIButton alloc] init];

        [_sendButton setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送"
                     forState:UIControlStateNormal];
        [_sendButton addTarget:self
                        action:@selector(sendButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
}

- (void)sendButtonAction:(UIButton *)sender {
    
    if (self.chatContentSendMessage) {
        
        if (self.sendTextField.text) {
            
            self.chatContentSendMessage(self.sendTextField.text);
        } else {
            
            self.chatContentSendMessage(@"没有输入发送内容");
        }
        
        self.sendTextField.text = @"";
        
        [self.sendTextField resignFirstResponder];
    }
}

- (UITextView *)contentTextView {
    
    if (!_contentTextView) {
        
        _contentTextView = [[UITextView alloc] init];
        
        _contentTextView.textColor       = [UIColor blackColor];
        _contentTextView.backgroundColor = [UIColor lightTextColor];
    }
    
    return _contentTextView;
}

- (void)addConstraintsWithSuperView {
    
    [self addSubview:self.sendButton];
    [self addSubview:self.sendTextField];
    [self addSubview:self.contentTextView];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self).with.insets(UIEdgeInsetsMake(20, 0, 0, 20));
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    
    [self.sendTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        make.top.bottom.equalTo(self.sendButton);
        make.right.equalTo(self.sendButton.mas_left).offset(-20);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.sendButton.mas_bottom).offset(20);
        make.left.bottom.right.equalTo(self).with.insets(UIEdgeInsetsMake(0, 20, 20, 20));
    }];
}

@end
