//
//  UIFont+Category.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Class cls = object_getClass(self);
    
    SEL oldSel = @selector(systemFontOfSize:);
    SEL newSel = @selector(jy_systemFontOfSize:);
    
    Method oldMethod = class_getClassMethod(cls, oldSel);
    Method newMethod = class_getClassMethod(cls, newSel);

    BOOL flag = class_addMethod(cls, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));

    if (flag) {
      class_replaceMethod(cls, oldSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
      method_exchangeImplementations(oldMethod, newMethod);
    }
  });
}

+ (void)jy_systemFontOfSize:(CGFloat)size {
  CGFloat scale = size * kCurrentPoint;
  [UIFont jy_systemFontOfSize:scale];
}

@end
