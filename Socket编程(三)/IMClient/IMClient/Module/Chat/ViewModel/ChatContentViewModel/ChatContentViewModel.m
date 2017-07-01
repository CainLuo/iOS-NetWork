//
//  ChatContentViewModel.m
//  IMClient
//
//  Created by Cain on 2017/6/30.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "ChatContentViewModel.h"

@interface ChatContentViewModel () <GCDAsyncSocketDelegate>

@property (nonatomic, strong, readwrite) GCDAsyncSocket *socket;

@end

@implementation ChatContentViewModel

#pragma mark - Bind IP Host And Post
- (void)createSocketConnect {
    
    NSString *host = @"127.0.0.1";
    NSInteger post = 8080;
    NSError *error;
    
    [self.socket connectToHost:host
                        onPort:post
                         error:&error];
    
    if (error) {
                
        [self socketLogMessageWithString:[NSString stringWithFormat:@"连接失败: %@", error.localizedDescription]];
        
        return;
    }
}

#pragma mark - Init Socket
- (GCDAsyncSocket *)socket {
    
    if (!_socket) {
        
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                              delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    
    return _socket;
}

#pragma mark - Socket代理代理方法
// 成功连接
- (void)socket:(GCDAsyncSocket *)sock
didConnectToHost:(NSString *)host
          port:(uint16_t)port {
    
    [self socketLogMessageWithString:[NSString stringWithFormat:@"连接成功: %@", host]];

    [self.socket readDataWithTimeout:-1
                                 tag:0];
}

// 断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock
                  withError:(NSError *)err {
    if (err) {
        
        [self socketLogMessageWithString:[NSString stringWithFormat:@"连接失败: %@", err.localizedDescription]];
    } else {
        
        [self socketLogMessageWithString:[NSString stringWithFormat:@"正常断开: %@", err.localizedDescription]];
    }
}

// 发送消息
- (void)sendMessageWithString:(NSString *)message {
    
    [self.socket writeData:[message dataUsingEncoding:NSUTF8StringEncoding]
               withTimeout:-1
                       tag:0];
    
    NSString *sendMessage = [NSString stringWithFormat:@"发送给服务器的消息: %@", message];
    
    [self socketLogMessageWithString:sendMessage];
}

// 发送数据后的回调方法
- (void)socket:(GCDAsyncSocket *)sock
didWriteDataWithTag:(long)tag {
    
    // 发送完数据手动读取，-1不设置超时
    [self.socket readDataWithTimeout:-1
                                 tag:0];
    
    NSLog(@"消息发送成功, 用户ID号为: %ld", tag);
}

// 读取数据
- (void)socket:(GCDAsyncSocket *)sock
   didReadData:(NSData *)data
       withTag:(long)tag {
        
    if (!data) {
        
        [self socketLogMessageWithString:@"并没有接收到服务器的消息"];
        
        return;
    }
    
    NSString *receiverStr = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
    
    NSLog(@"读取数据成功: %@", receiverStr);
    
    
    NSString *sendMessage = [NSString stringWithFormat:@"接收到的服务器消息: %@", receiverStr];
    
    [self socketLogMessageWithString:sendMessage];
}

#pragma mark - Log Message
- (void)socketLogMessageWithString:(NSString *)string {
    
    dispatch_async(dispatch_get_main_queue(), ^{

        if (self.chatContentSendMessage) {
            
            self.chatContentSendMessage(string);
        }
    });
}

@end
