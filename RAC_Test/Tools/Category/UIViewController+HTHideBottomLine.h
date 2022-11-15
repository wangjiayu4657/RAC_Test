//
//  UIViewController+HTHideBottomLine.h
//  HeartTrip
//
//  Created by 熊彬 on 17/1/17.
//  Copyright © 2017年 BinBear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HTHideBottomLine)

- (void)HT_hideBottomLineInView:(UIView *)view;
- (void)HT_showBottomLineInView:(UIView *)view;

@end


@interface UIViewController (UIBarButtonItem)

- (void)addRightItem:(NSString *)itemName callBack:(void(^)(void))callBack;

@end
