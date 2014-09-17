//
//  ITTStatusBarActivityView.h
//  
//
//  Created by jack 廉洁 on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    ITTStatusBarActivityViewStatusNone,
    ITTStatusBarActivityViewStatusSuccess,
    ITTStatusBarActivityViewStatusFail,
    ITTStatusBarActivityViewStatusInProgress
}ITTStatusBarActivityViewStatus;   

@interface ITTStatusBarActivityView : UIView

@property (nonatomic, assign) ITTStatusBarActivityViewStatus status;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UILabel *statusLbl;

- (void)setStatus:(ITTStatusBarActivityViewStatus)status;
- (void)hide;

@end
