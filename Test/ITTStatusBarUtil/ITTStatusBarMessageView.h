//
//  ITTStatusBarMessageView.h
//  iTotemFramework
//
//  Created by jack 廉洁 on 4/1/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITTStatusBarMessageView : UIView

@property (retain, nonatomic) IBOutlet UILabel *messageLbl;
- (void)showMessage:(NSString*)msg withDisappearTime:(int)disappearTime;
- (void)showMessage:(NSString*)msg;
- (void)hide;
@end
