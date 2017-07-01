//
//  SocketViewModel.h
//  IMServer
//
//  Created by Cain on 2017/7/1.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketViewModel : NSObject

- (void)createSocketWithClient;
- (void)sendMessageToClientWithString:(NSString *)string;

@property (nonatomic, copy) void(^messageWithClientSocket)(NSString *message);

@end
