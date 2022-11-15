//
//  UIView+Category.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "UIView+Category.h"



@implementation UIView (Category)

- (void)makeCornerWithRadius:(CGFloat)radius {
  if (self.bounds.size.width == 0) {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
  } else {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
  }
}

- (void)makeCornerWithStyle:(UIRectCorner)style corner:(CGFloat)corner {
  if (self.bounds.size.width == 0) {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = corner;
  } else {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:style cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
  }
}

- (void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor {
  [self makeCornerWithRadius:radius];
  
  self.layer.borderWidth = 1;
  self.layer.borderColor = borderColor.CGColor;
}



@end
