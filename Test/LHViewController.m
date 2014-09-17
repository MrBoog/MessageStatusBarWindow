//
//  LHViewController.m
//  Test
//
//  Created by LH'sMacbook on 14-9-16.
//  Copyright (c) 2014年 liuhuan. All rights reserved.
//

#import "LHViewController.h"
#import "MessageStatusBarWindow.h"

@interface LHViewController ()
{
    MessageStatusBarWindow *messageWindow;
}
@end

@implementation LHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    messageWindow = [[MessageStatusBarWindow alloc] initWithMessage:@"您收到一条消息"];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    static int i = 1;
    if ( i ) {
        [messageWindow show];
        i --;
    }else{
        [messageWindow dismiss];
        i ++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
