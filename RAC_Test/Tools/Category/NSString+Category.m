//
//  NSString+Category.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSMutableAttributedString *(^)(CGFloat))lineSpace {
  return ^NSMutableAttributedString *(CGFloat lineSpace){
    return [self addLineSpacing:lineSpace];
  };
}

- (NSMutableAttributedString *)addLineSpacing:(CGFloat)lineSpace {
  NSRange range = NSMakeRange(0, self.length);
  
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  style.lineSpacing = 8;
  
  NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
  [attribute addAttributes:@{NSParagraphStyleAttributeName:style} range:range];
  
  return attribute;
}

@end
