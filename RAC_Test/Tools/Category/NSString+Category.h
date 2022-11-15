//
//  NSString+Category.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

/// 返回一个添加行间距的富文本
/// 链式调用 @"xx".lineSpace(8)
- (NSMutableAttributedString *(^)(CGFloat))lineSpace;

/// 返回一个添加行间距的富文本
- (NSMutableAttributedString *)addLineSpacing:(CGFloat)lineSpace;

@end

NS_ASSUME_NONNULL_END
