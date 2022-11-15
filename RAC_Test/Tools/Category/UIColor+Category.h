//
//  UIColor+Category.h
//  XKHouse
//
//  Created by GDB on 16/6/3.
//  Copyright © 2016年 gdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)colorHex:(NSString *)hex;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
