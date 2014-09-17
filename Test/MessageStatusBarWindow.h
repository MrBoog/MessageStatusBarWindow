//
//  MessageStatusBarWindow.h
//  Test
//
//  Created by LH'sMacbook on 14-9-16.
//  Copyright (c) 2014年 liuhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageStatusBarWindow : UIWindow
{
    UILabel *messageLabel;
}

- (id)initWithMessage:(NSString *)message;

- (void)show;
- (void)dismiss;
@end
