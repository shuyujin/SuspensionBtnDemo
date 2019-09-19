//
//  SmartRobotButton.h
//  Weleadin_xiaoMi
//
//  Created by wld-Janek on 2019/9/19.
//  Copyright © 2019 wld-Janek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionWindowButton : UIWindow
-(void)removeView;
@end

@interface UIView (KJCategory)
@property(nonatomic,assign) CGFloat X;
@property(nonatomic,assign) CGFloat Y;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGFloat width;
@end

NS_ASSUME_NONNULL_END
