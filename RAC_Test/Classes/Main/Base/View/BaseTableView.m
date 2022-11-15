//
//  BaseTableView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    UIView *wrapView = self.subviews.firstObject;
    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
      for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
        if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"]) {
          gesture.enabled = NO;
          break;
        }
      }
    }
  }
  
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style  {
  if(self = [super initWithFrame:frame style:style]) {
    self.rowHeight = UITableViewAutomaticDimension;
    self.sectionHeaderHeight = 0;
    self.sectionFooterHeight = 0;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
      self.sectionHeaderTopPadding = 0;
    }
  }
  return self;
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
  if ([view isKindOfClass:[UIControl class]]) { return YES; }
  return [super touchesShouldCancelInContentView:view];
}

@end
