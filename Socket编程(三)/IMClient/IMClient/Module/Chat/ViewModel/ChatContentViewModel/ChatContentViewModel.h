//
//  ChatContentViewModel.h
//  IMClient
//
//  Created by Cain on 2017/6/30.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatContentViewModel : NSObject

@property (nonatomic, copy) void(^chatContentSendMessage)(NSString *message);

/**
 创建Socket连接
 */
- (void)createSocketConnect;

/**
 发消息给服务端

 @param message NSString
 */
- (void)sendMessageWithString:(NSString *)message;

@end
