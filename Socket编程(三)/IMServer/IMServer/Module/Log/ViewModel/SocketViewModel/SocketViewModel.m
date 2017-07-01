//
//  SocketViewModel.m
//  IMServer
//
//  Created by Cain on 2017/7/1.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SocketViewModel.h"

@interface SocketViewModel () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation SocketViewModel

#pragma mark - 绑定IP地址和端口号
- (void)createSocketWithClient {
    
    NSInteger post = 8080;
    NSError *error;
    
    [self.serverSocket acceptOnPort:post
                              error:&error];
    
    if (error) {
        
        NSString *errorString = [NSString stringWithFormat:@"连接客户端失败: %@", error.localizedDescription];
        
        [self changeLogTextViewWithString:errorString];

        return;
    }
}

- (void)sendMessageToClientWithString:(NSString *)string {
    
    [self.clientSocket writeData:[string dataUsingEncoding:NSUTF8StringEncoding]
                     withTimeout:-1
                             tag:0];

    NSString *sendMessage = [NSString stringWithFormat:@"发送的消息为: %@", string];
    
    [self changeLogTextViewWithString:sendMessage];
}

- (void)socket:(GCDAsyncSocket *)sock
didWriteDataWithTag:(long)tag {
    
    [self redClientSocket];
}

- (void)redClientSocket {
    
    [self.clientSocket readDataWithTimeout:-1
                                       tag:0];
}

#pragma mark - Init Socket
- (GCDAsyncSocket *)serverSocket {
    
    if (!_serverSocket) {
        
        _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                             delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    
    return _serverSocket;
}

#pragma mark - Socket Delegate
- (void)socket:(GCDAsyncSocket *)sock
didAcceptNewSocket:(GCDAsyncSocket *)newSocket {

    if (!newSocket) {
        
        [self changeLogTextViewWithString:@"链接客户端失败"];

        return;
    }
    
    self.clientSocket = newSocket;
    
    [self changeLogTextViewWithString:@"客户端连接成功"];
    
    [self redClientSocket];
}

- (void)socket:(GCDAsyncSocket *)sock
   didReadData:(NSData *)data
       withTag:(long)tag {
    
    
    NSString *getMessage = @"";

    if (!data) {
        
        getMessage = @"读取数据失败";
        
        return;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    getMessage = [NSString stringWithFormat:@"接收的消息为: %@", string];
    
    [self changeLogTextViewWithString:getMessage];
    
}

#pragma mark - Socket Log
- (void)changeLogTextViewWithString:(NSString *)string {
    
    if (self.messageWithClientSocket) {
        
        self.messageWithClientSocket(string);
    }
}

@end
