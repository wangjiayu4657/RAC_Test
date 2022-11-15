//
//  BuilderSubviewsProtocol.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import <Foundation/Foundation.h>

@protocol BuilderSubviewsProtocol <NSObject>

@optional
///构建子视图
- (void)buildSubviews;
///处理事件
- (void)handlerCommand:(id)data;

@end


