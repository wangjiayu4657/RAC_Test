//
//  JYServerConfig.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYServerConfig : NSObject

///env: 环境参数 00: 测试环境  01: 生产环境
+ (void)setJYConfigEnv:(NSString *)value;

///返回环境参数 00: 测试环境  01: 生产环境
+ (NSString *)JYConfigEnv;

///获取服务器地址
+ (NSString *)getJYServerAddr;

@end

NS_ASSUME_NONNULL_END
