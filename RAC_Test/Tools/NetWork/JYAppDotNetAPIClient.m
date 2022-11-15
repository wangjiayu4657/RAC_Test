//
//  JYAppDotNetAPIClient.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import "JYAppDotNetAPIClient.h"

@implementation JYAppDotNetAPIClient

+ (instancetype)sharedClient {
  static JYAppDotNetAPIClient *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  });
  return instance;
}

@end
