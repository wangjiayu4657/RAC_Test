//
//  JYAppDotNetAPIClient.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

NS_ASSUME_NONNULL_END
