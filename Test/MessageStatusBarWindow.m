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
    CGFloat labelWidth;
    CGFloat labelHeight;
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
    
        labelWidth = 0;
        statusBarWidth = kDefaultStatusBarWidth;
        
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.userInteractionEnabled = YES;
		self.backgroundColor = StatusBarColor;

        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, statusBarWidth, kDefaultStatusBarHeight)];
        messageLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        messageLabel.textAlignment = NSTextAlignmentRight;
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = messageStr;
        messageLabel.numberOfLines = 1;
        messageLabel.backgroundColor = [UIColor clearColor];
        CGSize maximumLabelSize = CGSizeMake(statusBarWidth, kDefaultStatusBarHeight);
        CGSize labelSize = [messageLabel sizeThatFits:maximumLabelSize];
        labelWidth = labelSize.width;
        labelHeight = labelSize.height;
        statusBarWidth = labelWidth + 10;
        
        self.frame = CGRectMake(kInitStatusBarOriginX, 0, statusBarWidth, kDefaultStatusBarHeight);
        messageLabel.frame = CGRectMake(statusBarWidth - labelWidth, (kDefaultStatusBarHeight - labelHeight)/2.0, labelWidth, labelSize.height);

        
        [self addSubview:messageLabel];
    }
    return self;
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
        

        //NOTE:
//        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:0 animations:^{
//            self.frame = CGRectMake(kInitStatusBarOriginX - statusBarWidth, 0, statusBarWidth, kDefaultStatusBarHeight);
//        } completion:^(BOOL finish){
//        }];

        
//        //NOTE:
        CGFloat toValue = kInitStatusBarOriginX - CGRectGetMidX(self.bounds);
        POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        onscreenAnimation.toValue = @(toValue);
        onscreenAnimation.springBounciness = 10.f;
        [self.layer pop_addAnimation:onscreenAnimation forKey:@"showMessage"];
        
		[self makeKeyAndVisible];
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
