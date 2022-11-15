//
//  JYLocalStore.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYLocalStore : NSObject

/**
 单例

 @return self
 */
+ (JYLocalStore *)sharedInstance;

/**
 序列化value，通过key标记

 @param value 值
 @param key 键
 */
- (void)serializeValue:(id)value withKey:(NSString *)key;


/**
 反序列化value

 @param key 键
 @return 返回反序列化结果
 */
- (id)deserializeValueWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
