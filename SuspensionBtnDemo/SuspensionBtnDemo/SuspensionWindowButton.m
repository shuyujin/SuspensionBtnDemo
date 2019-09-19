//
//  SmartRobotButton.m
//  Weleadin_xiaoMi
//
//  Created by wld-Janek on 2019/9/19.
//  Copyright © 2019 wld-Janek. All rights reserved.
//

#import "SuspensionWindowButton.h"

#define kAlpha                0.5
#define kPrompt_DismisTime    0.2

#define kWindow          [[UIApplication sharedApplication].windows firstObject]
#define kScreenBounds    [[UIScreen mainScreen] bounds]
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define kAssistiveTouchIMG          [UIImage imageNamed:@"robotBtn"]


@interface SuspensionWindowButton()

@property(strong,nonatomic)UIButton *touchButton;
@property(nonatomic,strong)UIView *backView;

@end

@implementation SuspensionWindowButton


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.windowLevel = UIWindowLevelAlert + 1;
        [self makeKeyAndVisible];
        
        _touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_touchButton setBackgroundImage:kAssistiveTouchIMG forState:UIControlStateNormal];
        [_touchButton setBackgroundImage:kAssistiveTouchIMG forState:UIControlStateDisabled];
        [_touchButton setBackgroundImage:kAssistiveTouchIMG forState:UIControlStateHighlighted];
        
        _touchButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [_touchButton addTarget:self action:@selector(suspensionAssistiveTouch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_touchButton];
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [_touchButton addGestureRecognizer:pan];
        
        self.alpha = 1;
        [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
        
    }
    return self;
}

-(void)removeView {
    [self removeFromSuperview];
}

-(void)suspensionAssistiveTouch {
    
    [kWindow addSubview:self.backView];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.alpha = 0;
        self.backView.alpha = kAlpha;
        
    } completion:^(BOOL finished) {
        
        [kWindow endEditing:YES];
    }];
}

-(void)disapper:(UITapGestureRecognizer *)tap{
    
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.alpha = 1;
        [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
        self.backView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.backView.alpha = 0;
        
        [self.backView removeFromSuperview];
    }];
}

-(void)changePostion:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointZero inView:self];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self beginPoint];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self changePoint];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self endPoint];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self endPoint];
        }
            break;
            
        default:
            break;
    }
}

- (void)beginPoint {
    
    _touchButton.enabled = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.alpha = 1.0;
    }];
}

- (void)changePoint {
    
    BOOL isOver = NO;
    
    CGRect frame = self.frame;
    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
        isOver = YES;
    } else if (frame.origin.x+frame.size.width > kWindow.width) {
        frame.origin.x = kWindow.width - frame.size.width;
        isOver = YES;
    }
    
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        isOver = YES;
    } else if (frame.origin.y+frame.size.height > kWindow.height) {
        frame.origin.y = kWindow.height - frame.size.height;
        isOver = YES;
    }
    if (isOver) {
        [UIView animateWithDuration:kPrompt_DismisTime animations:^{
            self.frame = frame;
        }];
    }
    _touchButton.enabled = YES;
    
}


static CGFloat _allowance = 30;
- (void)endPoint {
    
    if (self.X <= kWindow.width / 2 - self.width/2) {
        
        if (self.Y >= kWindow.height - self.height - _allowance) {
            self.Y = kWindow.height - self.height;
        }else
        {
            if (self.Y <= _allowance) {
                self.Y = STATUSBAR_HEIGHT;
            }else
            {
                self.X = 0;
            }
        }
        
    }
    else {
        if (self.Y >= kWindow.height - self.height - _allowance) {
            self.Y = kWindow.height - self.height;
        }else
        {
            if (self.Y <= _allowance) {
                self.Y = STATUSBAR_HEIGHT;
            }else
            {
                self.X = kWindow.width - self.width;
            }
        }
    }
    
    _touchButton.enabled = YES;
    [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
}


-(void)setAlpha {
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.alpha = kAlpha;
    }];
}


-(void)setX:(CGFloat)X{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        [super setX:X];
    }];
}
-(void)setY:(CGFloat)Y{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        [super setY:Y];
    }];
}


#pragma mark - lazy
-(UIView *)backView {
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame:kScreenBounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper:)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}


@end


@implementation UIView (KJCategory)

-(CGFloat)X{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)X{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}

-(CGFloat)Y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)Y{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



@end
