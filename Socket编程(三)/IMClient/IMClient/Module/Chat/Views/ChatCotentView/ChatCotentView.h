//
//  ChatCotentView.h
//  IMClient
//
//  Created by Cain on 2017/7/1.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCotentView : UIView

@property (nonatomic, copy) void(^chatContentSendMessage)(NSString *message);

- (void)changeLogTextViewWithString:(NSString *)string;

@end
