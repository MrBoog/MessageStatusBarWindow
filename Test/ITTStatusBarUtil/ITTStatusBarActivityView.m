//
//  ITTStatusBarActivityView.m
//  
//
//  Created by jack 廉洁 on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ITTStatusBarActivityView.h"
#import <QuartzCore/QuartzCore.h>
#import "LHAppDelegate.h"

@interface ITTStatusBarActivityView()
- (void)setInProgressStatus;
- (void)setFailStatus;
- (void)setSuccessStatus;
- (void)showWithCompletion:(void (^)(void))completion;
- (void)hideWithCompletion:(void (^)(void))completion;
@end

#define ITTStatusBarActivityViewDisappearTime 2 
@implementation ITTStatusBarActivityView
#pragma mark - private methods

- (void)showWithCompletion:(void (^)(void))completion
{
    if (self.alpha == 0) {
        self.layer.transform = CATransform3DMakeRotation(degreesToRadian(90), 1, 0, 0);
        self.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            self.layer.transform = CATransform3DMakeRotation(degreesToRadian(0), 1, 0, 0);
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }        
        }];
    }else {
        if (completion) {
            completion();
        }        
    }
}
- (void)hideWithCompletion:(void (^)(void))completion
{
    _statusLbl.text = @"";
    _activityIndicator.alpha = 0;
    self.layer.transform = CATransform3DMakeRotation(degreesToRadian(0), 1, 0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeRotation(degreesToRadian(90), 1, 0, 0);
    } completion:^(BOOL finished) {
        self.alpha = 0;
        if (completion) {
            completion();
        }        
    }];
}

- (void)setFailStatus
{
    _statusLbl.text = @"下载失败";
    _activityIndicator.alpha = 0;
    [self showWithCompletion:^{
        [self performSelector:@selector(hide) withObject:nil afterDelay:ITTStatusBarActivityViewDisappearTime];
    }];
}

- (void)setSuccessStatus
{
    _statusLbl.text = @"下载成功";
    _activityIndicator.alpha = 0;
    [self showWithCompletion:^{
        [self performSelector:@selector(hide) withObject:nil afterDelay:ITTStatusBarActivityViewDisappearTime];
    }];
}

- (void)setInProgressStatus
{
    _statusLbl.text = @"正在下载...";
    _activityIndicator.alpha = 1;
    [self showWithCompletion:^{
    }];
}

#pragma mark - public methods

- (void)hide
{
    [UIView animateWithDuration:1 animations:^{
        _activityIndicator.alpha = 0;
    } completion:^(BOOL finished) {
        _statusLbl.text = @"";
        [self hideWithCompletion:nil];
    }];
}


- (void)setStatus:(ITTStatusBarActivityViewStatus)status
{
    switch (status) {
        case ITTStatusBarActivityViewStatusNone:{
            [self hide];
            break;
        }
        case ITTStatusBarActivityViewStatusSuccess:{
            [self setSuccessStatus];
            break;
        }
        case ITTStatusBarActivityViewStatusFail:{
            [self setFailStatus];
            break;
        }
        case ITTStatusBarActivityViewStatusInProgress:{
            [self setInProgressStatus];
            break;
        }
        default:
        {
            break;
        }
    }
    _status = status;
}
#pragma mark - lifecycle methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    _status = ITTStatusBarActivityViewStatusNone;
    _activityIndicator.frame = CGRectMake(_activityIndicator.frame.origin.x, 4, 12, 12);
    if ([[UIDevice currentDevice].systemVersion intValue] >= 5)
        _activityIndicator.transform = CGAffineTransformMakeScale(0.6, 0.6);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)dealloc
{
}
@end
