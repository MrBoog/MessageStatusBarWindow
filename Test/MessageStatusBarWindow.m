//
//  MessageStatusBarWindow.m
//  Test
//
//  Created by LH'sMacbook on 14-9-16.
//  Copyright (c) 2014年 liuhuan. All rights reserved.
//

#import "MessageStatusBarWindow.h"
const static CGFloat kDefaultStatusBarHeight       = 20;
const static CGFloat kDefaultStatusBarWidth        = 200;
const static CGFloat kFontOfSize                   = 13;

#define kInitStatusBarOriginX   [UIScreen mainScreen].bounds.size.width

#define IOS7_OR_LATER           [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define StatusBarColor          [UIColor colorWithRed:255/255.0 green:127/255.0 blue:127/255.0 alpha:1.0]

@interface MessageStatusBarWindow ()
{
    UIWindow *previousKeyWindow;
//    CGFloat labelWidth;
//    CGFloat labelHeight;
    CGSize messageLabelSize;
    CGFloat statusBarWidth;
}
@end

@implementation MessageStatusBarWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithMessage:(NSString *)messageStr
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
    

        statusBarWidth = kDefaultStatusBarWidth;
        
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.userInteractionEnabled = YES;
		self.backgroundColor = StatusBarColor;

        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, statusBarWidth, kDefaultStatusBarHeight)];
        messageLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = messageStr;
        messageLabel.numberOfLines = 1;
        messageLabel.backgroundColor = [UIColor clearColor];
        CGSize maximumLabelSize = CGSizeMake(statusBarWidth, kDefaultStatusBarHeight);
        messageLabelSize = [messageLabel sizeThatFits:maximumLabelSize];
        CGFloat labelWidth = messageLabelSize.width;
        CGFloat labelHeight = messageLabelSize.height;
        statusBarWidth = labelWidth * 2;
        
        self.frame = CGRectMake(kInitStatusBarOriginX, 0, statusBarWidth, kDefaultStatusBarHeight);
        messageLabel.frame = CGRectMake(5, (kDefaultStatusBarHeight - labelHeight)/2.0, labelWidth, labelHeight);

        [self addSubview:messageLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

- (UIWindow *)findKeyWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window;
}



- (void)show
{
    if (![self isKeyWindow])
	{
		previousKeyWindow = [self findKeyWindow];
        
        CGFloat toValue = kInitStatusBarOriginX - 10;
        POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        onscreenAnimation.toValue = @(toValue);
        onscreenAnimation.springBounciness = 10.f;
        [self.layer pop_addAnimation:onscreenAnimation forKey:@"showMessage"];
		[self makeKeyAndVisible];
        
        //NOTE:
//        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:0 animations:^{
//            self.frame = CGRectMake(kInitStatusBarOriginX - statusBarWidth, 0, statusBarWidth, kDefaultStatusBarHeight);
//        } completion:^(BOOL finish){
//        }];
//		[self makeKeyAndVisible];
	}
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^
     {
         self.frame = CGRectMake(kInitStatusBarOriginX, 0, statusBarWidth, kDefaultStatusBarHeight);
     }];

    [previousKeyWindow makeKeyWindow];
}

@end
