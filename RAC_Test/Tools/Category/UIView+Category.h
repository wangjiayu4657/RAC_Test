//
//  UIView+Category.h
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)
///设置圆角
- (void)makeCornerWithRadius:(CGFloat)radius;

/// 设置圆角
/// @param style 设置哪个位置的圆角
/// @param corner 圆角大小
- (void)makeCornerWithStyle:(UIRectCorner)style corner:(CGFloat)corner;

///设置圆角和边框颜色
- (void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor;
@end

NS_ASSUME_NONNULL_END
