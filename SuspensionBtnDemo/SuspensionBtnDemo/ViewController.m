//
//  ViewController.m
//  SuspensionBtnDemo
//
//  Created by wld-Janek on 2019/9/19.
//  Copyright © 2019 Janek. All rights reserved.
//

#import "ViewController.h"

#import "SuspensionWindowButton.h"

@interface ViewController ()
@property (strong, nonatomic)SuspensionWindowButton *robotBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(time) withObject:nil afterDelay:1];
}


-(void)time {
    _robotBtn = [[SuspensionWindowButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 50, [[UIScreen mainScreen] bounds].size.height/2-25, 50, 50)];
}

@end
